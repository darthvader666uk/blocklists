# plugblock — architecture

Plug-and-play, network-wide ad/tracker blocking. Flash an image, plug the box in,
and traffic starts getting filtered **without logging into the router**.

> **Revised 2026-09-03** after a research pass. The flagship mode changed from
> ARP interception to transparent L2 bridge. Read
> [RESEARCH-2026-09.md](RESEARCH-2026-09.md) for the evidence; the short version
> is that Firewalla — the only company to ship the ARP approach at consumer
> scale — is retiring it because Android 14+ and newer routers break it, and
> because it cannot fail open. The pre-revision doc is kept at
> `ARCHITECTURE.md.pre-research.bak`.

## The design constraint that actually matters

"No router config" is the product. But it is not the only cost a user can pay.
There are three currencies:

| Cost | Acceptable? |
|---|---|
| Log into your router and change a setting | ✗ — this is the thing we're eliminating |
| Move your devices to a new SSID | ✗ — worse than the router login |
| **Move one cable** | **✓ — physical, one-time, easy to instruct** |

The original design treated "plug into any port" as the only acceptable answer
and accepted ARP spoofing as the price. That trade is worse than it looked: the
price isn't just complexity, it's an unfixable outage mode and a compatibility
treadmill against OS and router vendors. One cable move buys all of it back.

## Modes

- **Mode D — Transparent bridge (flagship).** Box sits physically between the
  router and the rest of the network (router → box → switch/AP). Bridges L2, so
  **no IP addresses, subnets, SSIDs or DHCP settings change** and nothing is
  spoofed. All traffic passes through us; DNS is redirected inline. Fails open.
- **Mode A — Manual DNS (safety net).** User points router/device DNS at the box.
  Just AdGuard Home, no interception. Near-zero support burden.
- **Mode B — Auto / ARP (opt-in fallback, build last).** Box wins the IPv4
  gateway role via gratuitous ARP. Zero physical work, but: breaks Android 14+
  Wi-Fi, fights router anti-spoofing, is a permanently contested race, and
  **cannot fail open** — an unclean box failure takes the network down for
  30–120 s. Ships gated behind explicit consent and a managed-network detector,
  if it ships at all.
- **Mode C — Router mode.** Out of scope. That's a router product.

## The blocking is the easy part

AdGuard Home already does blocklists, query log and the web UI. The engineering
lives entirely in **getting traffic to the box cheaply** and in **plugging the
leaks** (IPv6, encrypted DNS).

## Component stack (bottom to top)

1. **Base OS** — Debian/RPi OS Lite, read-only root + writable overlay so a
   pulled power cord can't corrupt state.
2. **Datapath** — L2 bridge across two NICs, plus **fail-open**: on power loss or
   daemon failure the two ports become a straight-through cable.
3. **DNS redirect + leak plugging** — nftables: DNAT all :53 (v4 **and v6**) to
   local AdGuard; block DoT 853; block known DoH endpoint IPs; serve the Firefox
   canary; NXDOMAIN Private Relay; strip HTTPS RR (type 65).
4. **Filtering** — AdGuard Home on 127.0.0.1:53. Unmodified. Don't reinvent.
5. **Control plane** — first-boot portal, health supervisor, OTA/list updates.

## Fail-open is the safety story

This replaces the old "the watchdog is load-bearing" section, and it is a much
stronger position.

In ARP mode the box *is* the declared gateway, so any unclean failure — power
loss, kernel panic, SD-card death — blackholes the network until every client's
neighbour cache expires (Linux 15–45 s reachable / 60 s stale; Windows ~60 s;
cheap IoT unbounded). No software can fix that, because the software is gone.

An inline bridge has no such property:

- **Hardware:** a fail-to-wire bypass relay closes on power loss and shorts the
  two ports into a straight cable. Standard practice in inline appliances.
  *Open item: BOM and sourcing at Pi form factor / gigabit — validate early, this
  is the whole safety argument.*
- **Software:** on filter-daemon failure, keep bridging and stop filtering. Ads
  get through; the network does not go down. Degrade, don't blackhole.

Whatever the mode, the heal/failsafe path **must not live inside the daemon** —
an in-process watchdog cannot heal the process that killed it. Separate
dependency-free binary, fired by systemd `ExecStopPost=` / `OnFailure=`, backed
by the Pi's hardware watchdog.

## IPv6 — solved by being inline

The previous design needed to win an RA race: advertise RDNSS via `radvd` more
aggressively than the real router, possibly drop the router's RAs and
re-originate corrected ones. All of that was necessary only because ARP is
IPv4-only and we were never in the v6 path.

**Inline, we are in the v6 path.** IPv6 DNS is just another flow to DNAT or drop,
exactly like IPv4. This entire risk area disappears — one of the two headline
reasons to prefer bridge mode.

## DoH / DoT — apps that ignore your DNS

Chrome, Firefox, many TVs and IoT ship hardcoded encrypted DNS. Levers, weakest
to strongest:

1. **Block DoT :853.** Android Private DNS in *Automatic* mode falls back
   silently to plaintext — confirmed. Cheap, do it.
   ⚠️ *But* Private DNS in **hostname/strict** mode has **no fallback**: those
   users get total DNS failure, not degradation. Detect repeated blocked :853
   from one MAC and warn by device name in the UI, or this becomes the #1
   support ticket.
2. **Block known DoH IPs.** **Consume [`dibdot/DoH-IP-blocklists`](https://github.com/dibdot/DoH-IP-blocklists)**
   (~1,426 domains, hourly automated updates) and/or hagezi's DoH IP lists.
   Do *not* hand-curate `config/doh-ips.txt` — worse coverage, permanent
   maintenance liability.
3. **Firefox canary.** NXDOMAIN for `use-application-dns.net`. Bonus: the DoH
   opt-out also disables ECH in Firefox.
4. **iCloud Private Relay.** Not filterable, but disableable — NXDOMAIN
   `mask.icloud.com` and `mask-h2.icloud.com` and Apple devices stand down.
5. **HTTPS RR (type 65) stripping.** ECH is on by default in Firefox 119+, but if
   the HTTPS DNS record is missing or stripped, TLS falls back to a plaintext
   SNI handshake. We own the resolver, so we can strip it. Keeps SNI-based
   filtering on the table for later rather than conceding it to ECH.

Honest README line: plaintext and DoT are reliably caught; DoH is caught for
major providers by IP and canary but is a moving target; Private Relay is opted
out rather than filtered. Nobody gets 100% (Firewalla included).

## Hardware floor

All traffic traverses the box, so throughput is a hard constraint the previous
draft didn't state:

- **Pi 5 or better.** Reported ~940 Mbps wire-speed with nftables NAT at best,
  500–700 Mbps for a realistic routing+firewall workload. L2 bridging is cheaper
  than L3 NAT, so bridge mode sits at the better end.
- **Pi 4 is not viable** for gigabit broadband (200–300 Mbps routing).
- **Thermals are a real risk:** Pi networking has been observed throttling to
  ~50 Mbps without adequate cooling. Fanless enclosure needs sustained-load
  testing before it's committed to.
- Two NICs required (onboard + USB 3.0 2.5 GbE dongle, or a HAT).

## v1 build order

1. **Bridge datapath + fail-open** (software first; relay BOM investigated in
   parallel) — the spine
2. nftables: DNS DNAT v4+v6, DoT block, DoH IP blocklist ingest, Firefox canary,
   Private Relay NXDOMAIN, HTTPS-RR strip
3. AdGuard Home + baked-in lists + web UI
4. First-boot captive portal, one question, bridge-mode default
5. Strict-DoT detection + per-device warnings
6. Per-device list + per-device block toggle + new-device alert
7. One-tap pause
8. Manual-DNS fallback (trivial once the above exists)
9. *(maybe)* ARP mode, gated behind consent + managed-network detection

v2: per-device profiles, scheduling, bandwidth/traffic stats (this is where the
project starts becoming Firewalla — conscious scope decision needed).

## Build vs glue

| Piece | Decision | Notes |
|---|---|---|
| Base OS + read-only overlay | glue | overlayroot / standard Debian |
| L2 bridge | glue | kernel bridge, `systemd-networkd` |
| Fail-open relay | **build (hardware)** | bypass relay + GPIO power-fail detect |
| Blocklist filtering + UI | glue | AdGuard Home |
| DNS DNAT + DoH/DoT block | glue | nftables config |
| DoH IP list ingest | build (light) | fetch + convert `dibdot` / hagezi |
| Health supervisor | build (small) | degrade-not-blackhole, out-of-process failsafe |
| Captive portal | glue | hostapd + dnsmasq + small web page |
| List/image updates | build (light) | AdGuard auto-updates lists; script OTA |
| ARP announcer | **deferred** | opt-in fallback only, build last |

## Open questions

- **Fail-to-wire relay BOM** at Pi form factor and gigabit — the one hardware
  unknown, and the whole safety argument rests on it.
- **Thermals** under sustained load in a fanless case.
- **Language.** Still open, but now low-stakes: with fail-open bridging the
  watchdog is no longer safety-critical, which removes the timing/robustness
  argument for Go. Python is fine. Decide when writing the supervisor, not before.
