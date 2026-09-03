# plugblock

Plug-and-play, network-wide ad/tracker blocking appliance. **Design stage — no
implementation yet.**

Flash an image, put the box inline, and filtering starts without logging into
the router.

- [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) — the design. Read this first.
- [docs/RESEARCH-2026-09.md](docs/RESEARCH-2026-09.md) — prior-art and
  feasibility research behind it.

## Current position

The flagship mode is a **transparent L2 bridge** (router → box → switch/AP): no
router login, no SSID change, nothing spoofed, and it can **fail open** via a
fail-to-wire bypass relay. ARP interception was demoted to an opt-in fallback
after research found Firewalla retiring the same approach over Android 14+
breakage, and Fingbox discontinued.

Filtering itself is AdGuard Home, unmodified, with the lists from
[`../adguard/`](../adguard/) baked into the image.

## Next steps

1. Fail-to-wire relay BOM at Pi form factor / gigabit — the one open hardware
   question, and the whole safety argument rests on it.
2. Bridge datapath + fail-open behaviour.
3. nftables: DNS DNAT v4+v6, DoT block, DoH IP blocklist ingest, canary,
   Private Relay NXDOMAIN, HTTPS-RR strip.

Language is still undecided (Python vs Go) and deliberately low-stakes — see the
Open Questions section of the architecture doc.
