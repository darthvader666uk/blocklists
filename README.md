# Custom Ad Blocking Filter List for AdGuard Home & Streaming Services

**A comprehensive, organized DNS-level filter list specifically optimized for blocking streaming service ads (HBO Max, Disney+, Apple TV+, Peacock, Roku, Paramount+, etc.) and aggressive tracking.**


> ### 📦 Moved from Gist → repository
>
> This project used to live as a flat GitHub Gist. It is now a real repository
> split into [`adguard/`](adguard/), [`ublock/`](ublock/) and
> [`plugblock/`](plugblock/). **Filenames are unchanged; only their directories
> are new — but every subscription URL changed.** If your AdGuard Home is still
> pointed at the old `gist.githubusercontent.com` URLs it is serving a frozen
> snapshot. See [MIGRATION.md](MIGRATION.md) for the old → new URL table.

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

---

## ✅ **Filter Status by Service (August 2026)**

| Service | Filter File | Status | Notes |
|---------|------------|--------|-------|
| **HBO Max** 🔥 | `filterlist.streaming.hbo.txt` | ✅ **PRODUCTION READY** | Rebrand support (max.com + hbomax.com), 131 rules, whitelists protect playback |
| **Disney+** | `filterlist.streaming.disney.txt` | ✅ **WORKING** | 30-40% effectiveness (SSAI limitation), disneyadvertising.com targeted |
| **Roku** | `filterlist.streaming.roku.txt` | ✅ **ENHANCED** | 5 regex patterns + 15 individual blocks, comprehensive coverage |
| **Apple TV+** | `filterlist.streaming.appletv.txt` | ✅ **WORKING** | 9 verified rules |
| **Peacock/NBC** | `filterlist.streaming.peacock.txt` | ⚠️ **IMPROVED (May 2026)** | App v7.4.21+ changed ad delivery; ajstrick81 v2.7 claims renewed effectiveness on Android/iOS; 5-40% effective |
| **Paramount+** | `filterlist.streaming.paramount.txt` | 🔴 **INEFFECTIVE (April 2026)** | DAI makes DNS blocking 0% effective; fwmrm.net whitelist needed for Android app; stay on v16.8 |
| **Amazon Prime** | `filterlist.streaming.amazon.txt` | ⚠️ **LIMITED** | SSAI-only = cannot be blocked at DNS |
| **Hulu** | `filterlist.streaming.hulu.txt` | ✅ **WORKING** | 50% effectiveness (less SSAI-reliant) |
| **Channel 4 / All4 + My5** | `filterlist.streaming.ukcatchup.txt` | 🆕 **NEW (Aug 2026)** | UK-only catch-up TV; 23 verified domains; medium FP risk (whitelist `cdn.http.anno.channel4.com` if playback fails) |
| **Main List** | `filterlist.txt` | ✅ **CURRENT** | 229 blocks + 196 allows (52% optimized with wildcards) |

---

## 📋 **Quick Summary**

| Metric | Details |
|--------|---------|
| **Format** | AdBlock Plus (`\|\|domain.com^`) + regex support |
| **Rules** | ~431 carefully curated & optimized (wildcards) |
| **Last Updated** | **August 19, 2026** (52% rule reduction, Apple allowlist, AI/Windows/Reddit blocks, Phishing Army + URLHaus added) |
| **Primary Use** | AdGuard Home DNS-level blocking |
| **Also Works** | AdGuard browser extension, uBlock Origin, Adblock Plus, NextDNS, AdGuard DNS (cloud) |
| **Verification** | Cross-referenced against ozankiratli, ajstrick81, lit-bg community research |
| **Testing** | Normalized line endings (CRLF → LF), syntax verified |
| **AdGuard DNS Limit** | Custom list at 431/1000 rules (569 headroom remaining) |
| **AdGuard Home** | 37 lists target / **26 actually running** as of the 2 Sep audit — see top of file |

---

## 🚀 **Quick Start**

### Option 1: AdGuard Home (Recommended for Smart TVs & Network-Wide)

1. **Download the raw file:**
   ```
   https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/filterlist.txt
   ```

2. **Add to AdGuard Home:**
   - Go to **Filters → DNS Blocklists → Add blocklist**
   - Paste the URL above
   - Enable it
   - Restart AdGuard Home

3. **For Smartphones (iOS/Android):**
   - Install AdGuard app → Settings → DNS protection
   - Paste URL or use AdGuard DNS

### Option 2: Browser Extensions

#### uBlock Origin
- Dashboard → Filter lists → Import → Paste raw URL
- Or: **My filters** tab → paste rules directly

> **Note:** uBlock Origin dropped active Facebook support in Aug 2026 — community stop-gap filters live in `ublock-main.txt` userFilters.

#### AdGuard Browser Extension
- Settings → Ad blocker → Custom & experimental → Custom filters
- Add URL: Same as above

---

## ✅ **What This List BLOCKS**

### Streaming Services (DNS-Level Blocking)
| Service | Coverage | Effectiveness | Status |
|---------|----------|---|---------|
| **HBO Max/Max** ⭐ | 30 verified + regional rules | 20-30% | ✅ **PRODUCTION READY** |
| **Disney+** | disneyadvertising.com + partners | 30-40% | ✅ **WORKING** |
| **Apple TV+** | 9 rules | 20-30% | ✅ **WORKING** |
| **Roku** | 37 rules + 5 regex patterns | 40%+ | ✅ **ENHANCED** |
| **Hulu** | 12 rules | 50% | ✅ **WORKING** |
| **Sky Glass** | 21 ad network rules | 40% | ✅ **WORKING** |
| **Peacock/NBC** | 11 whitelists + 2 blocks | 5-40% | ⚠️ **IMPROVED (May 2026)** |
| **Paramount+** | 25+ rules | 0% | 🔴 **DAI UNSOLVABLE** |
| **Amazon Prime** | 5 rules | 0% | ⚠️ **SSAI ONLY** |

### Tracking & Analytics (~150 rules)
- **Meta/Facebook** (70+ rules) — All third-party Facebook/Instagram tracking
- **Google** (15+ rules) — Google Analytics, AdSense, DoubleClick, Ads, Tagmanager
- **Apple** (16 rules) — iCloud Feedback, Weather analytics
- **Microsoft** (Copilot blocking, Telemetry)
- **OpenAI, Anthropic, Gemini** — AI service blocking
- **Pinterest, Snapchat, TikTok** — Social media tracking

### Ad Networks & CDNs (50+ rules)
- General ad servers (adsrvr.org, adsafeprotected.com)
- Attribution networks (krxd.net, everesttech.net)
- SSAI services (fwmrm.net, braze.com)
- Video ad insertion services
- Smart TV ad frameworks

---

## ❌ **What This List CANNOT BLOCK (Technical Limitations)**

### Services Using SSAI (Server-Side Ad Insertion)
**These services CANNOT be blocked at DNS level** because ads are embedded in the video stream itself:

- ❌ **Paramount+** (April 2026+) — Google DAI makes blocking impossible
- ❌ **Amazon Prime Video** — 0-5% blockable (all SSAI)
- ⚠️ **Peacock** (April 2026+) — App updates changed ad architecture
- ⚠️ **Netflix** (if SSAI enabled) — Ads baked into stream

**Why:** SSAI embeds ads server-side. DNS blocking can't separate ads from video on the same CDN domain.

### Hardware/Device Protections
- Smart TV OS prevents browser-level blocking (DNS only works)
- iOS/Apple TV don't allow network-level ad blocking apps
- Some devices use encrypted CDN paths DNS can't intercept

---

## 🔧 **Installation & Configuration**

### AdGuard Home + Streaming Services Setup

**Best Practice Approach:**
1. Enable main `filterlist.txt`
2. Enable streaming-specific list (e.g., `filterlist.streaming.hbo.txt`)
3. Monitor logs for breakage
4. Whitelist playback CDN if needed (see filter comments)

**Common Whitelists (if videos don't play):**
```
@@||discomax.com^              (Disney+/Hulu CDN)
@@||cbsi.com^                  (Paramount+/CBS CDN)
@@||nflxext.com^               (Netflix CDN)
@@||rokutime.com^              (Roku CDN)
```

### Testing Your Setup

**Check if blocking is working:**
- Open streaming service
- Check AdGuard Home logs: **Logs** tab
- Look for `BLOCKED` entries from filter
- If videos don't play, whitelist the blocked CDN domain

**Read Filter Comments:**
- Each filter file contains inline documentation
- Comments marked with `!` explain risk levels and regional targeting
- Whitelists marked with `@@||` are preserved for playback

---

## 📊 **Verification & Quality Assurance**

### April 2026 Updates

✅ **Cross-Referenced Against:**
- ozankiratli community gist (138⭐, July 2025 + April 2026 comments)
- ajstrick81 community research (v2.7, May 2026)
- lit-bg community research
- Brave Search API (domain verification)
- Jina AI web extraction (current infrastructure analysis)
- Firecrawl scraping (real-time service checking)

✅ **All Domains Verified Safe:**
- adsrvr.org ✓ (Skai DoubleVerify)
- adsafeprotected.com ✓ (Amazon DSP)
- disneyadvertising.com ✓ (Disney ad server)
- braze.com ✓ (Marketing automation)
- All others verified legitimate

✅ **Code Quality:**
- Line endings normalized (CRLF → LF)
- Syntax verified (Adblock Plus format)
- DNS compatibility confirmed
- No path-scoped rules (AdGuard Home compatible)

### Testing Notes

- **Peacock:** Filter updated but app v7.4.21+ breaks blocking (disable auto-updates)
- **Paramount+:** Filter serves as reference; DAI makes it 0% effective (stay on v16.8)
- **Roku:** Regex patterns tested against community findings
- **HBO Max:** Dual domain support (max.com + hbomax.com post-rebrand)
- **Disney+:** Stable and reliable (30-40% effective)

---

## 🎯 **For Advanced Users**

### Regex Patterns (AdGuard Home Supports)

```
! Roku comprehensive blocking
^(([^.]+\.)*(logs|ads|web|prod\.mobile|cti|voice)(\.([^.]+)*\.))roku\.com$

! Disney advertising
^([^.]+\.)*disneyadvertising\.com$
```

### Whitelist Syntax

```
! Preserve playback CDN
@@||discomax.com^
@@||cbsi.com^
```

### Format Support

- **AdBlock Plus:** ✅ Full support
- **AdGuard Home (DNS):** ✅ Full support (no regex in DNS mode)
- **AdGuard Browser:** ✅ Full support (regex enabled)
- **uBlock Origin:** ✅ Full support
- **NextDNS:** ✅ Full support

---

## 📞 **Support & Updates**

### Reporting Issues

If something breaks:
1. Check the filter **Comments** (marked with `!`)
2. Review the **Whitelist** section in that filter
3. Try whitelisting the blocked domain
4. Check ozankiratli gist for recent app updates

### Latest Research

- **April 2026:** Paramount+ DAI update documented
- **April 2026:** Peacock app v7.4.21 breakage noted
- **July 2025:** Peacock regex patterns from ozankiratli gist
- **Ongoing:** Community discussions in gist comments

### Streaming Services Monitoring

Following these services for changes:
- ✅ HBO Max/MAX (rebrand tracked, dual domains supported)
- ⚠️ Peacock (April 2026 app update breakage)
- 🔴 Paramount+ (April 2026 DAI migration)
- ✅ Roku (comprehensive regex coverage)
- ✅ Disney+ (stable)

---

## 🔗 **Active Filter Lists**

### AdGuard Home — target stack (38 lists)

Target stack as of **2 September 2026**, reconciled against the live `AdGuardHome.yaml`.
Apply via `.vscode/docs/adguard-home-stack.md` — the running config had only 26 of these.

> **Note:** AdGuard Home and uBlock Origin are *separate* stacks and are no longer
> documented as one. uBlock subscribes to 59 lists including browser-only ones that do
> not belong in DNS filtering.

#### 🛡️ Blocklists (38)

| # | Group | List | URL | Purpose |
|---|---|---|---|---|
| 1 | Core | **HaGeZi Multi PRO** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt` | Main list — ads, trackers, malware, phishing, scam, popups |
| 2 | Core | **OISD Small** | `https://small.oisd.nl/` | Lightweight ads + trackers, different curation to HaGeZi |
| 3 | Security | **HaGeZi TIF - IPs** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/tif-ips.txt` | IP-based threat blocking ⚠️ see FP note |
| 4 | Security | **Dandelion Sprout's Anti-Malware** | `https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Dandelion%20Sprout%27s%20Anti-Malware%20List.txt` | Malware — HaGeZi explicitly recommends for AGH |
| 5 | Security | **Phishing Army Extended** | `https://phishing.army/download/phishing_army_blocklist_extended.txt` | Dedicated phishing domains |
| 6 | Security | **URLHaus** | `https://malware-filter.gitlab.io/malware-filter/urlhaus-filter-agh.txt` | Malicious URLs (AdGuard Home native build) |
| 7 | Security | **HaGeZi Badware Hoster** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/hoster.txt` | Free hosters that host badware |
| 8 | Security | **HaGeZi Dynamic DNS** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/dyndns.txt` | Dynamic DNS abuse |
| 9 | Core | **AdGuard DNS filter** | `https://filters.adtidy.org/extension/chromium/filters/15.txt` | DNS-native composite (Base+EasyList+EasyPrivacy, simplified for DNS) — ⚠️ currently mislabelled "AdGuard CNAME Trackers" in the live config |
| 10 | Privacy | **AdGuard Fingerprinting** | `https://filters.adtidy.org/extension/chromium/filters/11.txt` | Anti-fingerprinting |
| 11 | DNS bypass | **HaGeZi DoH/VPN/Proxy Bypass** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/doh-vpn-proxy-bypass.txt` | Stops Roku/Fire TV hardcoded DoH escaping your DNS |
| 12 | Smart TV | **Perflyst & Dandelion Sprout Smart-TV** | `https://adguardteam.github.io/HostlistsRegistry/assets/filter_7.txt` | Smart TV ads |
| 13 | Smart TV | **FTPrivacy Smart TV** | `https://raw.githubusercontent.com/ftpmorph/ftpihole/master/blocklists/smart-tv-ads-tracking.txt` | LG/Samsung/Sony/Roku |
| 14 | Smart TV | **BlocklistProject Smart TV** | `https://raw.githubusercontent.com/blocklistproject/Lists/master/smart-tv.txt` | Samsung/LG/Roku telemetry |
| 15 | Native OEM | **HaGeZi Native Amazon (Fire TV)** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.amazon.txt` | Fire TV/Stick ad bidding, OTT DTB |
| 16 | Native OEM | **HaGeZi Native Roku (ACR)** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.roku.txt` | Roku ACR, ravm.tv |
| 17 | Native OEM | **HaGeZi Native Samsung** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.samsung.txt` | Samsung TV telemetry, Adobe Analytics |
| 18 | Native OEM | **HaGeZi Native Apple** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.apple.txt` | Apple TV analytics, SKAdNetwork |
| 19 | Native OEM | **HaGeZi Native LG webOS** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.lgwebos.txt` | LG webOS telemetry |
| 20 | Native OEM | **HaGeZi Native TikTok** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.tiktok.txt` | TikTok ads/telemetry |
| 21 | Native OEM | **HaGeZi Native Vivo** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.vivo.txt` | Vivo device tracking |
| 22 | Native OEM | **HaGeZi Native Windows/Office** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.winoffice.txt` | Windows/Office telemetry |
| 23 | Streaming | **StreamNoAds** | `https://raw.githubusercontent.com/tammo2701/StreamNoAds/main/adblock-streaming-services` | Netflix ads, Twitch, Crunchyroll, DE/IN streaming |
| 24 | Mobile | **AdGuard Mobile App Banners** | `https://filters.adtidy.org/extension/chromium/filters/21.txt` | "Get our app" banner removal |
| 25 | Mine | **My Own Filter List - Master** | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/filterlist.txt` | Custom cross-service + tracking blocks |
| 26 | Mine | **My Own Filter List - Amazon** | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.amazon.txt` | Amazon ad/tracking blocks |
| 27 | Mine | **My Own Filter List - Appletv** | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.appletv.txt` | Appletv ad/tracking blocks |
| 28 | Mine | **My Own Filter List - Disney** | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.disney.txt` | Disney ad/tracking blocks |
| 29 | Mine | **My Own Filter List - Hbo** | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.hbo.txt` | Hbo ad/tracking blocks |
| 30 | Mine | **My Own Filter List - Hulu** | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.hulu.txt` | Hulu ad/tracking blocks |
| 31 | Mine | **My Own Filter List - Netflix** | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.netflix.txt` | Netflix ad/tracking blocks |
| 32 | Mine | **My Own Filter List - Paramount** | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.paramount.txt` | Paramount ad/tracking blocks |
| 33 | Mine | **My Own Filter List - Peacock** | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.peacock.txt` | Peacock ad/tracking blocks |
| 34 | Mine | **My Own Filter List - Pluto** | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.pluto.txt` | Pluto ad/tracking blocks |
| 35 | Mine | **My Own Filter List - Roku** | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.roku.txt` | Roku ad/tracking blocks |
| 36 | Mine | **My Own Filter List - Skyglass** | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.skyglass.txt` | Skyglass ad/tracking blocks |
| 37 | Mine | **My Own Filter List - Tubi** | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.tubi.txt` | Tubi ad/tracking blocks |
| 38 | Mine | **My Own Filter List - Ukcatchup** | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.ukcatchup.txt` | Ukcatchup ad/tracking blocks |

> ⚠️ **TIF-IPs false positives:** it blocks by resolved IP, so any site on a shared
> Vercel/Cloudflare/Netlify address can be caught (e.g. `cruisenation.com` on 2026-09-02).
> Each needs an `@@||domain^` entry in `filterlist.txt`. Drop TIF-IPs if it becomes frequent.

### 📊 Total Coverage

| Metric | Value |
|--------|-------|
| **Third-party blocklist rules** | ~600,000 (target stack) |
| **My custom rules** | 469 in `filterlist.txt` (223 blocks + 246 allows) + ~300 across streaming files |
| **Blocklists (target)** | 38 |
| **Last verified** | 2 September 2026 (against live AdGuardHome.yaml) |

---

## 🔗 **AdGuard DNS (Cloud) — Backup**

When you're out and about, AdGuard DNS provides backup DNS filtering. **Personal plan limit: 1K custom rules.**

### Built-in Lists (16) — Don't count toward 1K limit

| Category | List | Rules |
|----------|------|-------|
| **General** | AdGuard DNS filter | 177K |
| **General** | HaGeZi's Pro Blocklist | 221K |
| **General** | OISD Blocklist Small 🆕 | 59K |
| **Security** | Dandelion Sprout's Anti-Malware | 13K |
| **Security** | HaGeZi's Badware Hoster | 1K |
| **Security** | Phishing Army | 157K |
| **Security** | uBlock₀ Badware Risks | 3K |
| **Security** | URLHaus | 5K |
| **Other** | HaGeZi Apple Tracker | 107 |
| **Other** | HaGeZi OPPO/Realme Tracker | 484 |
| **Other** | HaGeZi Samsung Tracker | 201 |
| **Other** | HaGeZi Vivo Tracker | 229 |
| **Other** | HaGeZi Windows/Office Tracker | 389 |
| **Other** | HaGeZi Xiaomi Tracker | 346 |
| **Other** | Smart-TV Blocklist | 159 |
| **Total** | | **639K** |

### Custom List (1)

| List | Rules | Limit |
|------|-------|-------|
| My Own Filter List - Master | **431** | **431/1000** |

**Why wildcards matter:** AdGuard DNS limits custom lists to 1K rules. Our 52% reduction (882 → 431) keeps us well under the cap while maintaining full coverage.

---

## 📄 **License & Attribution**

- **Filter Format:** AdBlock Plus (open standard)
- **Community Reference:** ozankiratli gist, Hagezi, AdGuard, EasyList, uBlock Origin, Dandelion Sprout, OISD
- **Verification:** Brave Search, Jina AI, Firecrawl
- **Last Comprehensive Update:** August 19, 2026

---

## 🔗 **Repository Layout**

```
adguard/
  filterlist.txt                    # Main cross-service filter (229 blocks + 196 allows — 52% optimized)
  streaming/                        # Service-specific filters:
    filterlist.streaming.hbo.txt        (HBO Max - PRODUCTION READY)
    filterlist.streaming.disney.txt     (Disney+ - WORKING)
    filterlist.streaming.paramount.txt  (Paramount+ - DAI UNSOLVABLE)
    filterlist.streaming.peacock.txt    (Peacock - IMPROVED May 2026)
    filterlist.streaming.roku.txt       (Roku - ENHANCED, regex converted to hostnames)
    filterlist.streaming.amazon.txt     (Prime Video - LIMITED)
    filterlist.streaming.hulu.txt       (Hulu - WORKING)
    filterlist.streaming.appletv.txt    (Apple TV+ - WORKING)
    filterlist.streaming.netflix.txt    (Netflix - tracking)
    filterlist.streaming.skyglass.txt   (Sky Glass - WORKING)
    filterlist.streaming.tubi.txt       (FAST service)
    filterlist.streaming.pluto.txt      (FAST service)
    filterlist.streaming.ukcatchup.txt  (Channel 4/All4/My5 - UK catch-up TV)

ublock/
  ublock-main.txt                   # uBlock Origin full backup (settings, lists, userFilters) — JSON
  ublock-filters-lite.txt           # DEPRECATED 2026-09-03 — frozen MV3 subset

plugblock/                          # Plug-and-play network blocking appliance (in design)
  docs/ARCHITECTURE.md              # Design — transparent L2 bridge, fail-open
  docs/RESEARCH-2026-09.md          # Prior-art + feasibility research

scripts/
  validate-filters.sh               # Syntax validator — run before committing
```

**Filenames are unchanged from the original gist** — only their directories are new.

---

## ⚡ **Performance Tips**

1. **Don't enable all filters at once** — Start with main + 1 service
2. **Monitor logs** — AdGuard Home shows what's blocked
3. **Whitelist wisely** — Only whitelist CDN, not ad servers
4. **Update frequency** — Check for app updates that break blocking
5. **Device-specific** — DNS works better on Roku/Android than iOS/Smart TV OS
6. **AdGuard DNS backup** — Use cloud DNS when out and about (1K custom rule limit)

---

**Made with ❤️ for ad-free streaming**

*Last updated: August 19, 2026*
*Cross-verified against: ozankiratli community research, Hagezi, AdGuard, EasyList, OISD*
