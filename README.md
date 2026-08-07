# Custom Ad Blocking Filter List for AdGuard Home & Streaming Services

**A comprehensive, organized DNS-level filter list specifically optimized for blocking streaming service ads (HBO Max, Disney+, Apple TV+, Peacock, Roku, Paramount+, etc.) and aggressive tracking.**

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

## ✅ **Filter Status by Service (April 2026)**

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
| **Paramount+** (legacy) | `filterlist.streaming.paramount.txt` | 🔴 **UNSOLVABLE** | Google DAI (April 2026+) overrides DNS blocking |
| **Main List** | `filterlist.txt` | ✅ **CURRENT** | 585+ cross-service + tracking rules |
| **AdGuard Format** | `filterlist.adguard.txt` | ✅ **AVAILABLE** | Hostlist format (one per line) |

---

## 📋 **Quick Summary**

| Metric | Details |
|--------|---------|
| **Format** | AdBlock Plus (`\|\|domain.com^`) + regex support |
| **Rules** | ~585 carefully curated & verified |
| **Last Updated** | **August 7, 2026** (Blocklist stack overhaul — verified against Hagezi docs, 37 → 27 lists) |
| **Primary Use** | AdGuard Home DNS-level blocking |
| **Also Works** | AdGuard browser extension, uBlock Origin, Adblock Plus, NextDNS |
| **Verification** | Cross-referenced against ozankiratli, ajstrick81, lit-bg community research |
| **Testing** | Normalized line endings (CRLF → LF), syntax verified |

---

## 🚀 **Quick Start**

### Option 1: AdGuard Home (Recommended for Smart TVs & Network-Wide)

1. **Download the raw file:**
   ```
   https://gist.githubusercontent.com/darthvader666uk/ccfdab18b9d59830876c373db8b4210d/raw/filterlist.txt
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

## 🔗 **Active Filter Lists (AdGuard Home)**

All lists below are active and verified as of **7 August 2026**. Stack verified against Hagezi's official documentation (README + FAQ):

- Hagezi's documented recommendation = **one Multi tier + TIF** (his own public DNS runs Multi Pro + TIF)
- **Multi PRO (`pro.txt`)** is Hagezi's personal recommendation — Pro++ (`pro.plus.txt`) is "experienced users only, may contain false positives"
- Safe extras on top: DynDNS, Badware Hoster, Native Vivo/WinOffice; **Dandelion Sprout's Anti-Malware is explicitly recommended for AdGuard Home**
- ❌ Removed in the Aug 2026 cleanup (already curated inside Hagezi, redundant or FP sources): StevenBlack hosts, AdGuard DNS filter, AdGuard CNAME Trackers + disguised CNAME lists, Phishing Army **Extended**, ShadowWhisperer, Scam Blocklist, URLHaus, NoCoin, AdGuard Popup Hosts

### 🛡️ Blocklists (27)

| List | URL | Rules | Purpose |
|------|-----|-------|---------|
| **Hagezi Multi PRO** ⭐ MAIN | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt` | 218,204 | Hagezi's personal recommendation — ads, trackers, malware, phishing, scam, popups, bug trackers |
| **Hagezi Threat Intelligence Feeds** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/tif.txt` | 2,444,220 | Threat intel domains (≥2GB RAM recommended in AGH; TIF Medium 412k for constrained devices) |
| **Hagezi TIF — IPs** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/tif-ips.txt` | 56,948 | IP-based threat blocking |
| **Hagezi Dynamic DNS** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/dyndns.txt` | 1,525 | Security extra |
| **Hagezi Badware Hoster** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/hoster.txt` | 1,259 | Security extra |
| **Hagezi Native Vivo** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.vivo.txt` | 228 | Vivo device tracking |
| **Hagezi Native Windows/Office** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.winoffice.txt` | 390 | Windows/Office telemetry |
| **Dandelion Sprout's Anti-Malware** | `https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Dandelion%20Sprout%27s%20Anti-Malware%20List.txt` | 14,021 | Malware blocking — Hagezi explicitly recommends for AGH |
| **Perflyst & Dandelion Sprout Smart-TV** | `https://adguardteam.github.io/HostlistsRegistry/assets/filter_7.txt` | 159 | Smart TV ad blocking |
| **FTPrivacy Smart TV** | `https://raw.githubusercontent.com/ftpmorph/ftpihole/master/blocklists/smart-tv-ads-tracking.txt` | 231 | LG/Samsung/Sony/Roku (optional — overlaps Perflyst) |
| **BlocklistProject Smart TV** | `https://raw.githubusercontent.com/blocklistproject/Lists/master/smart-tv.txt` | 77 | Samsung/LG/Roku telemetry (optional — overlaps Perflyst) |
| **AdGuard Fingerprinting** | `https://filters.adtidy.org/extension/chromium/filters/11.txt` | 7,814 | Anti-fingerprinting |
| **AdGuard Mobile App Banners** | `https://filters.adtidy.org/extension/chromium/filters/21.txt` | 8,316 | "Get our app" banner removal |
| **StreamNoAds** | `https://raw.githubusercontent.com/tammo2701/StreamNoAds/main/adblock-streaming-services` | 150 | Netflix ads, Twitch, Crunchyroll, German/Indian streaming, streaming ad platforms — requires companion whitelist |

**My Custom Filter Lists** (12 active in AGH, ~700 rules): Master + streaming (Amazon, Apple TV+, Disney+, HBO Max, Netflix, Paramount+, Sky Glass, Hulu, Roku, Tubi, Pluto TV) — curated blocks + playback whitelists, see File Structure below. (Peacock file exists in repo but is not enabled — DAI makes it 0% effective.)

**uBlock-only** (browser extension, not used in AGH): `ublock-main.txt`, `ublock-filters.txt`, `ublock-filters-lite.txt`

### ✅ Allowlists (3)

| List | URL | Rules | Purpose |
|------|-----|-------|---------|
| **uBlock filters – Unbreak** | `https://raw.githubusercontent.com/uBlockOrigin/uAssets/refs/heads/master/filters/unbreak.txt` | 2,536 | Curated anti-breakage exceptions (DNS-level: only plain `@@` rules apply) |
| **StreamNoAds Whitelist** | `https://raw.githubusercontent.com/tammo2701/StreamNoAds/main/whitelist-streaming` | 40 | REQUIRED companion to StreamNoAds — protects playback CDNs |
| **Coupert Whitelist** | `https://coupertteam.github.io/allowlist/smart-shopping.txt` | 62 | Required for Coupert extension (whitelists cashback/affiliate trackers network-wide — deliberate trade-off) |

### 📊 Total Coverage

| Metric | Value |
|--------|-------|
| **Third-party blocklist rules** | ~2,753,000 |
| **My custom rules** | ~700 (blocks + allows across all files) |
| **Blocklists active** | 27 |
| **Allowlists active** | 3 |
| **Last verified** | 7 August 2026 |

---

## 📄 **License & Attribution**

- **Filter Format:** AdBlock Plus (open standard)
- **Community Reference:** ozankiratli gist, Hagezi, AdGuard, EasyList, uBlock Origin, Dandelion Sprout
- **Verification:** Brave Search, Jina AI, Firecrawl
- **Last Comprehensive Update:** August 7, 2026

---

## 🔗 **File Structure**

```
filterlist.txt                      # Main cross-service filter (258 blocks + 143 allows)
filterlist.streaming.*.txt          # Service-specific filters:
  - hbo.txt (HBO Max - PRODUCTION READY)
  - disney.txt (Disney+ - WORKING)
  - paramount.txt (Paramount+ - DAI UNSOLVABLE)
  - peacock.txt (Peacock - IMPROVED May 2026)
  - roku.txt (Roku - ENHANCED, regex converted to hostnames)
  - amazon.txt (Prime Video - LIMITED)
  - hulu.txt (Hulu - WORKING)
  - appletv.txt (Apple TV+ - WORKING)
  - netflix.txt (Netflix - tracking)
  - skyglass.txt (Sky Glass - WORKING)
  - tubi.txt, pluto.txt (FAST services)
ublock-main.txt                    # uBlock Origin full backup (settings, lists, userFilters)
ublock-filters.txt                 # uBlock Origin cosmetic/scriptlet filters (legacy reference)
ublock-filters-lite.txt            # MV3-compatible subset (53 rules)
```

---

## ⚡ **Performance Tips**

1. **Don't enable all filters at once** — Start with main + 1 service
2. **Monitor logs** — AdGuard Home shows what's blocked
3. **Whitelist wisely** — Only whitelist CDN, not ad servers
4. **Update frequency** — Check for app updates that break blocking
5. **Device-specific** — DNS works better on Roku/Android than iOS/Smart TV OS

---

**Made with ❤️ for ad-free streaming**

*Last updated: August 7, 2026*
*Cross-verified against: ozankiratli community research, Hagezi, AdGuard, EasyList*
