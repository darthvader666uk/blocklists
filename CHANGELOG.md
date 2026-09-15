# Changelog

Dated entries for this project, newest first. Current status, install
instructions and the active list stack live in the [README](README.md).

---

## 15 September 2026

### ➖ Removed HaGeZi DoH/VPN/Proxy Bypass from AdGuard Home

- It was blocking `nfct-prod-nordvpn-vernemq-*.elb.us-east-1.amazonaws.com`, the
  NordVPN browser extension's control channel (VerneMQ MQTT on an AWS load
  balancer). The list flags VPN infrastructure by design, so it will keep
  colliding with Nord.
- Removed outright rather than swapped for HaGeZi's DoH-only `doh.txt`, so the
  Roku/Fire TV hardcoded-DoH bypass protection it was added for on 19 Aug is
  **no longer covered**. `doh.txt` (3,316 rules, only touches Nord's own DNS
  resolvers) is the drop-in if that gap needs closing.
- Stack is now 37 lists target / 25 running.

### ✅ Allowlist: NordVPN AWS broker

- `@@/^nfct-prod-nordvpn-[a-z0-9-]+\.elb\.[a-z0-9-]+\.amazonaws\.com$/` in the
  master list. Regex because the hash rotates on redeploy. Kept even though the
  blocking list is gone, so the block cannot come back with it.
- Unrelated to HBO Max's "Are You Using a VPN?" banner, which appeared the same
  day: that is exit-IP reputation on Nord's own ASN (AS147049 PacketHub S.A.)
  and nothing at DNS changes it.

---

## 3 September 2026

### 📦 Gist → repository migration completed

- Moved from a flat GitHub Gist to `github.com/darthvader666uk/blocklists`, split
  into `adguard/`, `ublock/` and `plugblock/`. Filenames unchanged; every
  subscription URL changed. See [MIGRATION.md](MIGRATION.md).
- All 14 AdGuard Home subscriptions re-pointed and verified (HTTP 200, non-zero
  rule counts).
- The old gist was **tombstoned, not deleted** — README replaced with a pointer
  and a `! MOVED` header added to every list, so existing subscribers keep
  working on frozen rules rather than getting a 404.
- A GitHub PAT committed to `.env` back in February blocked the first push
  (GH013). It was already revoked, but push protection matches the token
  *pattern*, not its validity — purged from all 200 commits with
  `git filter-branch`. Tree hash verified unchanged.

### 🔧 uBlock Origin files corrected

- `ublock-main.txt`: the 14 gist subscription URLs rewritten to repo URLs across
  `externalLists`, `importedLists` and `selectedFilterLists`.
- `ublock-filters-lite.txt`: **deprecated and frozen** — moved back to full
  uBlock Origin on Firefox. Kept published so subscribers don't 404.
- Fixed a real defect in that file: its `EXTERNAL FILTER LISTS` section held **48
  bare URLs with no `!` prefix**. In ABP syntax a bare URL is a network filter
  pattern, so uBO Lite was treating them as rules blocking any request
  containing that string — including the filter feeds they documented.

### 📊 Documentation reconciled against the files

Every rule count in the README was re-derived from the actual lists. Most were
wrong. Notably **HBO was documented as "131 rules" since 17 April 2026 — that
was the file's *line* count, mislabelled.** The list has never had 131 rules; it
peaked at 31 and sits at 18. No rules were lost.

Changelog entries split out of the README into this file.

---

## 📍 LATEST UPDATE: September 2, 2026

### 🔎 **CONFIG AUDIT — README reconciled against the live AdGuard Home config**

The running `AdGuardHome.yaml` was diffed against this README for the first time. They did not
match, and the README was the wrong one:

- **Live config had 26 blocklists, not the 35 documented here.** The Aug 7 / 12 / 19 changes below
  were written up but **never applied** to AdGuard Home.
- **Still enabled despite being listed as removed:** HaGeZi TIF (full) and AdGuard DNS filter —
  the latter mislabelled "AdGuard CNAME Trackers". Since the Aug 12 note blamed the filtered-rate
  drop on its *removal*, that explanation never held: it was running the whole time. It is
  DNS-native (unlike the browser lists) and is **kept** in the target stack, just renamed.
- **Documented as added but absent:** OISD Small, all six `native.*` device lists,
  `doh-vpn-proxy-bypass`, StreamNoAds, FTPrivacy/BlocklistProject Smart TV, DynDNS, Badware Hoster,
  Mobile App Banners. The Aug 12 "coverage gap closed" work was therefore **still open** at DNS level.
- **Six of this repo's own streaming lists were missing from AdGuard Home:** `roku`, `peacock`,
  `hulu`, `pluto`, `tubi`, `ukcatchup` — including Roku, the best-performing list at 40%+. They were
  loaded only in uBlock Origin, which does nothing for TVs and streaming sticks.
- **Browser-extension lists were loaded into DNS mode** (EasyList, EasyPrivacy, Fanboy's Annoyance,
  Cookie List, Annoyances, uBlock Privacy/Badware). AdGuard Home discards their cosmetic, scriptlet
  and path rules, so they inflated the list count while contributing almost nothing.
- **Every list reported `rules_count: 0` with no `last_updated`** — a likely cause of the low
  filtered rate, ahead of the SSAI explanation given below. Verify the rule counts are non-zero on
  the Filters page.

The corrected 38-list stack is in `.vscode/docs/adguard-home-stack.md` (local, not published).
**The table further down now documents that target stack, not the old 26.**

### ➕ New whitelist: Cruise Nation

`@@||cruisenation.com^` added to `filterlist.txt`. `www.cruisenation.com` was blocked by
**Threat Intelligence Feeds - IPs** — not by domain, but because it resolves to `216.150.1.193`,
a **Vercel shared IP** in the feed. Site verified live (HTTP 200). Expect this class of false
positive to recur for any Vercel / Cloudflare / Netlify-hosted site; each needs its own
`@@||domain^` entry.

---

## 📍 LATEST UPDATE: August 19, 2026

### 🟢 **OPTIMIZATION — 52% Rule Reduction + Apple/iCloud/CarPlay Allowlist + AI Chatbot/Windows/Reddit/Discord Blocks**

- **Filter list optimized from 882 → 425 rules (52% reduction)** using wildcards — critical for AdGuard DNS cloud (1K custom rule limit)
- **Added comprehensive Apple iCloud/iMessage/CarPlay allowlist** — gateway.icloud.com, setup.icloud.com, APNs, mzstatic.com, etc. now unblocked
- **Added AI chatbot tracking blocks** — OpenAI, Perplexity, Mistral, Cohere, HuggingFace, Meta AI
- **Added Windows 11 telemetry blocks** — diagnostic data, advertising ID (core Windows still works)
- **Added Reddit/Discord tracking blocks** — analytics and ads blocked, services still work
- **Added OISD Small** to both AdGuard Home and AdGuard DNS — lightweight supplement to HaGeZi Pro

---

## 📍 LATEST UPDATE: August 12, 2026

### 🟢 **COVERAGE GAP CLOSED — Native Device Trackers + DNS Bypass Prevention**

- **Added Hagezi `native.*` OEM device lists** (additive — NOT included in Multi PRO, which is only partial 🟨 for native coverage): `native.amazon` (Fire TV/Stick ad bidding, OTT DTB), `native.roku` (ACR, ravm.tv), `native.samsung` (TV telemetry, Adobe Analytics), `native.apple` (Apple TV analytics, SKAdNetwork), `native.lgwebos`, `native.tiktok` — ~2,100 domains that were previously only in the uBlock config, not AdGuard Home
- **Added Hagezi `doh-vpn-proxy-bypass`** — stops Roku/Fire TV hardcoded DoH from bypassing AdGuard Home's DNS entirely
- **New UK catch-up list: `filterlist.streaming.ukcatchup.txt`** — Channel 4 / All4 / My5 ad & measurement hosts (23 domains), replacing the broken upstream `UK-CatchupDNS` `domains.txt` (which had the entire Hagezi Pro list accidentally appended — 324k domains)
- **Whitelists unchanged:** Coupert + uBlock Unbreak + StreamNoAds whitelist (2,639 rules ≈ 0.1% of stack — not a factor)
- **Filtered-rate note:** dashboard % dropped from ~30% → ~8% after the Aug 7 stack slim-down. Expected: the overhaul removed the highest-hit-rate lists (AdGuard DNS filter, CNAME trackers, popupads) and DAI/SSAI makes streaming ads unblockable at DNS. Native.* + DoH bypass should recover genuine coverage without Pro++-style breakage.

---

## 📍 LATEST UPDATE: August 7, 2026

### 🟢 **BLOCKLIST STACK OVERHAUL — Verified Against Hagezi's Official Docs**

- **Reverted to Hagezi Multi PRO (`pro.txt`)** — his personal recommendation (Pro++ is "experienced users only, may contain false positives")
- **Kept:** TIF + TIF-IPs, DynDNS, Badware Hoster, Native Vivo/WinOffice, Dandelion Sprout's Anti-Malware (explicitly recommended for AGH), Perflyst Smart-TV, StreamNoAds + companion whitelist
- **Removed (redundant/FP sources, already curated inside Hagezi):** StevenBlack hosts, AdGuard DNS filter, AdGuard CNAME Trackers + disguised CNAME lists, Phishing Army Extended, ShadowWhisperer, Scam Blocklist, URLHaus, NoCoin, AdGuard Popup Hosts
- **Allowlists:** uBlock Unbreak + StreamNoAds whitelist + Coupert (required for extension)
- **Result:** 37 → 27 blocklists, ~3.7M → ~2.75M rules

---

## 📍 LATEST UPDATE: August 4, 2026

### 🔴 **CRITICAL FINDINGS - April 2026 Streaming App Updates**

**What Changed:**
- **Peacock:** Android v7.4.21 (April 13, 2026) broke ad blocking; iOS broken for weeks
- **Paramount+:** Switched to Google DAI (Direct Ad Injection) — DNS blocking now **0% effective**
- **Roku:** Upgraded with comprehensive regex patterns — still working ✅

**What You Should Know:**
- **Peacock & Paramount+:** Users are disabling app auto-updates to stay on older versions
- **Current Workaround:** Disable auto-updates in app stores, stay on Peacock v7.4.20 or earlier, Paramount+ v16.8 or earlier
- **Effectiveness Reality:** SSAI (Server-Side Ad Insertion) limits DNS blocking to 5-40% effectiveness across all streaming services

**Community Research:**
- Cross-verified against ozankiratli community gist (138⭐, last updated July 10, 2025)
- Latest gist comments show April 2026 app update breakage
- Reference: https://gist.github.com/ozankiratli/801ba17705e7f2a904d2e443af5a64f8
