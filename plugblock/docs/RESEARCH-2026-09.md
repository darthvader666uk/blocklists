# plugblock — research findings, 2026-09-03

Scope: the six questions that gate the interception primitive. Two conclusions
change the project's shape; the rest are cheap wins.

**Headline: the flagship mode should not be ARP. It should be transparent L2
bridge.** Reasoning below.

---

## 1. Prior art — ARP mode is being retired by the only vendor who shipped it

Firewalla is direct prior art: their **Simple Mode is exactly plugblock's Mode B**
(box wins the gateway role by ARP spoofing, no router config). What they now say
about it is the single most important input to this project.

From their own documentation:

> "Please note that support for Simple Mode may be reduced soon due to increasing
> compatibility issues with Android 14. We highly recommend using Bridge or
> Router Mode."
> — [How Does Firewalla Intercept Traffic?](https://help.firewalla.com/hc/en-us/articles/115004292514-How-Does-Firewalla-Intercept-Traffic-Which-Firewalla-Mode-Should-I-Use)

> "Android 14 may not respond properly when it sees a different MAC address
> respond to ARP queries." … "Unfortunately, this is not something firewalla can
> fix. It is how the Android operating system deals with ARP spoofing."
> — [Why is my Android device disconnecting in Simple Mode (Legacy)?](https://help.firewalla.com/hc/en-us/articles/20994764766227-Why-is-my-Android-device-disconnecting-in-Simple-Mode-Legacy)

Firewalla staff, on r/firewalla:

> "Android 14 is not happy with arp spoofing, and more of the newer routers don't
> like it either; as the compatibility problems start to spread more, the arp
> spoofing (simple mode)…"

Corroborating evidence that this is a structural decline, not a bug:

- **Both** Simple Mode and DHCP Mode are now titled **"(Legacy)"** throughout
  Firewalla's docs. The two no-new-hardware modes are the two being sunset.
- They maintain a **[router compatibility list](https://help.firewalla.com/hc/en-us/articles/360047098773-Router-Compatibility-Simple-and-DHCP-Mode-Legacy)**
  for Simple/DHCP mode — i.e. ARP mode's support burden was large enough to need
  a per-model matrix.
- They shipped an **"Experimental Simple Mode"** whose entire stated purpose was
  "to make some routers compatible with arp spoofing."
- Community note on the mechanism: *"it relies on a race condition. Firewalla
  needs to be the first device to respond to the ARP request."* ARP takeover is
  a permanently-contested race, not an acquired state.

**Fingbox — the other ARP-based consumer box — is discontinued.** A 2026 review
records the failure modes: *"Blocking relies on ARP spoofing and fails on routers
with client isolation or IPv6 bypass"*, plus *"Fingbox discontinuation means the
DIY Agent route is now the only always-on option."* Two independent reports of
second-order damage: Fingbox's ARP traffic *"destroys wifi performance"* on
multi-AP 2.4 GHz networks, and when a Firewalla and a Fingbox shared a network,
*"the Fingbox lost its ability to identify or block new devices"* — two ARP
spoofers fight each other.

**Verdict:** ARP-as-flagship is building on a primitive that client OSes and
router vendors are actively hardening against, that two shipped consumer products
have now walked away from, and whose failure mode is user-visible Wi-Fi drops on
the single most common phone platform.

---

## 2. DHCP takeover does not rescue plug-and-play (correcting my own earlier suggestion)

The idea was: win DHCP with a short lease and hand out only option 6 (DNS), so
you never take the gateway role, never funnel WAN traffic, and self-heal on power
loss when clients renew against the real router.

The failure mode is genuinely better. The plug-and-play claim is not.

- **Firewalla's DHCP mode is cooperative, not rogue** — it *"require[s] you to
  disable DHCP service on Routers."* It is a router-login mode, same as manual
  DNS. It buys nothing over Mode A.
- **Rogue DHCP racing does work** but is explicitly a race — *"a race condition
  inherent in the protocol, as DHCP clients generally accept the first valid offer
  received"*, and *"because this new rogue DHCP server was significantly closer to
  the customers than the actual DHCP server, it won the race every time."*
  Proximity usually wins, so we'd usually win. Usually is not a product.
- Worse for a *DNS-only* takeover: clients on existing multi-hour leases don't
  re-DISCOVER until renewal, so first-boot coverage arrives over hours, not
  seconds. That's fatal for a "plug it in and it works" demo.

**Verdict:** rogue DHCP is a legitimate *supplementary* lever (short leases, good
heal behaviour) but cannot be the primary. Not the escape hatch I thought it was.

---

## 3. The mode ARCHITECTURE.md is missing: transparent L2 bridge

Mode C in the current doc is described as "box WAN → ISP router, devices on the
box LAN… user must move devices to a new SSID." That's **router mode**, and its
cost is correctly identified as prohibitive. But there is a third inline shape
the doc never considers:

> "Transparent Bridge Mode places a Firewalla Box physically in the middle of an
> existing network **without modifying the IP address of the network**."
> — [Firewalla: Transparent Bridge Mode](https://help.firewalla.com/hc/en-us/articles/1500012304202-Firewalla-Transparent-Bridge-Mode)

And on why it exists, from Firewalla staff:

> "the bridge mode is really made for routers that doesn't work too well with
> simple mode (arp spoofing compatibility), and customers don't want to use DHCP
> mode, and replace their current router."

That is precisely our problem statement. Transparent bridge gives us:

| | ARP mode | Transparent bridge |
|---|---|---|
| Router login needed | no | no |
| New SSID / subnet change | no | **no** |
| DHCP change | no | no |
| Physical work | plug into any port | **move one cable** |
| Sees all WAN traffic | yes | yes |
| Android 14+ safe | **no** | yes |
| Router-vendor hardening risk | **high, rising** | none |
| Contested race | **permanent** | none |
| IPv6 DNS | must win an RA race | **just filter it inline** |
| Failure = outage | **yes, unavoidable** | **no — can fail open** |

The cost is one cable move (router → box → switch/AP). That is a materially
smaller ask than "log into your router" for most people, and it is a *physical*
instruction, which is the kind non-technical users follow best.

### The decisive advantage: bridges can fail open

ARP mode's core risk is unfixable. The watchdog handles daemon death, but nothing
in software survives power loss, kernel panic, or SD-card failure — and in those
cases every client keeps sending to a MAC that no longer answers until its
neighbour cache expires (see §4). "Unplug this box and your house goes offline
for a minute" is a permanent property of ARP mode.

An inline bridge does not have this property. **Fail-to-wire bypass relays** are
standard practice in inline network appliances: on power loss the relay closes
and the two ports become a straight-through cable. Network unaffected, instantly.
A software bridge also degrades better (keep forwarding, stop filtering).

*Needs validation:* BOM cost and sourcing of an RJ45 fail-to-wire relay in a
Pi-class form factor, and whether a plain DPDT relay is adequate at gigabit.
This is the one open hardware question and it is worth answering early, because
it is the whole safety argument.

### The second prize: the IPv6 section largely disappears

ARCHITECTURE.md's "two risky bits" include racing `radvd` RDNSS against the real
router and possibly re-originating corrected RAs ("RA guard in reverse"). Inline,
none of that is needed — IPv6 DNS is just another flow to DNAT or drop, exactly
like IPv4. **Choosing bridge deletes the project's second-hardest problem
outright**, not just makes it easier.

---

## 4. ARP cache expiry — the doc's "minutes" estimate is about right

For the record, since it bounds the ARP-mode outage window:

- **Linux:** `base_reachable_time_ms` default 30000, randomised 50–150% → each
  entry is REACHABLE for **15–45 s**; `gc_stale_time` default **60 s**. Route-cache
  GC on some kernels only runs every 5 min, which can extend it.
- **Windows:** Vista+ base reachable time ~**60 s** (some sources cite 120 s).
- IoT/embedded stacks vary and some use long or static entries — unbounded tail.

So: **~30–120 s of dead network** for mainstream clients after an unclean box
failure, with a long tail on cheap devices. The watchdog's corrective-ARP design
is correct and does shrink the *daemon-crash* case to seconds. It cannot touch
the power-loss case. This number is a product disclosure, not a bug to fix.

---

## 5. Throughput — Pi 5 only, and not with much headroom

Both ARP mode and bridge mode put all WAN traffic through the box, so this
applies either way. ARCHITECTURE.md doesn't mention throughput at all.

- Pi 5 with nftables NAT: one source reports **~940 Mbps wire speed**; another,
  more conservative, reports **500–700 Mbps** for a routing + firewall workload.
- Pi 4: **200–300 Mbps** routing. **Not viable** for gigabit broadband.
- Pi thermal caveat: without adequate cooling, throughput has been observed
  throttling to ~50 Mbps. A passive fanless enclosure is a real design risk.

L2 bridging is cheaper than L3 NAT, so bridge mode should sit at the better end
of that range. **Pi 5 or better is the floor; a fanless case needs thermal
testing under sustained load.**

---

## 6. Encrypted DNS — three free wins the doc doesn't have

The doc's analysis is sound but leaves value on the table.

**a) Don't build `config/doh-ips.txt`. Consume a maintained list.**
[`dibdot/DoH-IP-blocklists`](https://github.com/dibdot/DoH-IP-blocklists) —
~1,426 domains with **hourly automated updates**, publishing `doh-ipv4.txt`,
`doh-ipv6.txt` and domain lists. [`hagezi/dns-blocklists`](https://github.com/hagezi/dns-blocklists)
also ships DoH IP lists. A hand-curated file is a permanent maintenance liability
for strictly worse coverage. *(This is the one genuine overlap with the `gist`
repo: a list-consumption pipeline, not a hand-written file.)*

**b) ECH is not the end of SNI — because we own DNS.**
ECH is on by default in Firefox since v119. But two documented properties matter:
- *"If the HTTPS DNS record is missing, blocked, or stripped by a middlebox, the
  TLS connection still works — it just falls back to a normal handshake with the
  SNI visible in plaintext."* We are the resolver. **Stripping/​NXDOMAINing HTTPS
  RR (type 65) queries forces SNI back into the clear.**
- *"Firefox won't use ECH to encrypt traffic if any of the DoH opt-outs have been
  configured"* — the `use-application-dns.net` canary we already planned to serve
  also disables ECH in Firefox as a side effect.

This doesn't make SNI filtering v1, but it means the doc's "ECH will erode this"
is too pessimistic for a resolver-owning box. Worth a line in the README instead
of a surrender.

**c) Two cheap additions:**
- **iCloud Private Relay** is not filterable, but it *is* disableable: NXDOMAIN
  on `mask.icloud.com` and `mask-h2.icloud.com` and Apple devices stand down.
  Standard practice; add to the baked config.
- **Android Private DNS**: *Automatic* mode *"falls back silently to unencrypted
  DNS"* when 853 is blocked — the doc's assumption is confirmed correct.
  But **hostname/strict mode has no fallback**: *"Every lookup has to reach that
  one host, over port 853… there is no fallback if it cannot."* Blocking 853
  gives those users **total DNS failure**, not degradation. This needs active
  detection (repeated blocked 853 from one MAC) and a named-device warning in the
  UI, or it becomes the #1 support ticket.

---

## 7. Legal — a design requirement, not a README line

Relevant UK hooks are the Computer Misuse Act 1990 **s.3** (unauthorised acts
impairing the operation of a computer — note *"the offender must know that the
act was unauthorised"*) and **s.3A** (making, supplying or obtaining articles for
use in such offences). Not legal advice, but the shape is clear: a device whose
**default** mode spoofs ARP on whatever network it is plugged into is a different
proposition from one that does so only on explicit, informed, per-network consent.

"Not for managed networks" in a README is not a control. If ARP mode ships at
all, it needs an active managed-network detector (802.1X, DAI, enterprise gear
fingerprints) that refuses to arm, plus an explicit consent gate naming the
network. Bridge mode sidesteps this question entirely — nothing is spoofed.

---

## Recommendation

1. **Transparent L2 bridge becomes the flagship.** Cost: one cable move. Buys:
   Android compatibility, no vendor-hardening treadmill, fail-open safety, and
   the deletion of the entire IPv6 RA-racing problem.
2. **ARP mode is demoted to an opt-in "no cable move" fallback** — built last,
   shipped with the Android and outage-window warnings stated plainly, gated by
   a managed-network detector. Possibly not in v1 at all.
3. **Manual DNS stays as-is** (Mode A), and is now the *third* option rather than
   the only fallback.
4. **Router mode is out of scope** — that's a router product, not this product.
5. **Rogue DHCP** is a possible later supplement for ARP mode, not a primitive.

### Revised build order

1. Bridge datapath + **fail-open behaviour** (software first, relay BOM in parallel) — the spine
2. nftables: DNS DNAT (v4 **and v6**) + DoT block + DoH IP blocklist from `dibdot` + Firefox canary + Private Relay NXDOMAIN + HTTPS-RR strip
3. AdGuard Home + baked-in lists + web UI
4. First-boot captive portal
5. Strict-mode-DoT detection + per-device warnings (prevents the top support ticket)
6. Per-device list/block toggle + new-device alert
7. One-tap pause
8. Manual-DNS fallback
9. *(maybe)* ARP mode, gated and warned

### Open questions this did not close

- **Fail-to-wire relay BOM** at Pi form factor and gigabit — the one hardware unknown.
- **Thermal**: sustained-load throughput in a fanless enclosure.
- **Language**: still open, but now much lower stakes — with fail-open bridging,
  the watchdog stops being safety-critical. Python is fine. See note below.

### Note on the watchdog and language

With bridge mode the watchdog's job changes from *"restore the network before the
user notices"* to *"stop filtering, keep forwarding."* That is a far weaker
requirement and it removes the argument for Go on timing/robustness grounds.

Regardless of mode, the heal path should **not live inside the daemon** — an
in-process watchdog cannot heal the process that killed it. Make it a separate
dependency-free binary fired by systemd `ExecStopPost=` / `OnFailure=`, backed by
the Pi's hardware watchdog.

---

## Sources

- [Firewalla — How Does Firewalla Intercept Traffic? Which Mode Should I Use?](https://help.firewalla.com/hc/en-us/articles/115004292514-How-Does-Firewalla-Intercept-Traffic-Which-Firewalla-Mode-Should-I-Use)
- [Firewalla — Why is my Android device disconnecting in Simple Mode (Legacy)?](https://help.firewalla.com/hc/en-us/articles/20994764766227-Why-is-my-Android-device-disconnecting-in-Simple-Mode-Legacy)
- [Firewalla — Transparent Bridge Mode](https://help.firewalla.com/hc/en-us/articles/1500012304202-Firewalla-Transparent-Bridge-Mode)
- [Firewalla — Everything about DHCP Mode (Legacy)](https://help.firewalla.com/hc/en-us/articles/115004304114-Everything-about-Firewalla-DHCP-Mode-Legacy)
- [Firewalla — Router Compatibility: Simple and DHCP Mode (Legacy)](https://help.firewalla.com/hc/en-us/articles/360047098773-Router-Compatibility-Simple-and-DHCP-Mode-Legacy)
- [Fing — Troubleshoot Block and Pause](https://help.fing.com/hc/en-us/articles/26496208028700-Troubleshoot-Block-and-Pause)
- [Tech O Dash — Fing Review 2026](https://techodash.com/soho-reviews-fing-review/)
- [dibdot/DoH-IP-blocklists](https://github.com/dibdot/DoH-IP-blocklists) · [hagezi/dns-blocklists](https://github.com/hagezi/dns-blocklists)
- [Mozilla — ECH FAQ](https://support.mozilla.org/en-US/kb/faq-encrypted-client-hello) · [Understand ECH](https://support.mozilla.org/en-US/kb/understand-encrypted-client-hello) · [MozillaWiki — Security/Encrypted Client Hello](https://wiki.mozilla.org/Security/Encrypted_Client_Hello)
- [fixmycert — ECH / SNI fallback behaviour](https://fixmycert.com/guides/encrypted-client-hello)
- [Android Police — Private DNS strict mode has no fallback](https://www.androidpolice.com/traced-pixels-random-mobile-data-drops-to-single-dns-setting/)
- [Server Fault — default ARP cache timeout](https://serverfault.com/questions/684380/default-arp-cache-timeout) · [Red Hat — ARP neighbour entry lifetime](https://access.redhat.com/solutions/38289)
- [homelabrouter — Raspberry Pi router speed](https://homelabrouter.com/raspberry-pi-router-speed/) · [Botmonster — Debian router with nftables](https://botmonster.com/self-hosting/build-linux-router-nftables-traffic-shaping/)
- [SDN46 — Block Apple Private Relay with DNS filtering](https://www.sdn46.com/how-to-block-apples-icloud-private-relay-using-pi-hole-and-dns-filtering/)
- [CPS — Computer Misuse Act legal guidance](https://www.cps.gov.uk/legal-guidance/computer-misuse-act)
