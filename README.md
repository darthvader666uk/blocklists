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

## 📰 Recent changes

Dated entries have moved to **[CHANGELOG.md](CHANGELOG.md)**. Most recent:
the gist → repository migration (3 Sep 2026), the uBlock Origin URL fixes and
uBO Lite deprecation, and a full reconciliation of every rule count in this
README against the actual files.

---

## ✅ **Filter Status by Service (September 2026)**

| Service | Filter File | Status | Notes |
|---------|------------|--------|-------|
| **HBO Max** 🔥 | `filterlist.streaming.hbo.txt` | ✅ **PRODUCTION READY** | Rebrand support (max.com + hbomax.com), 21 rules (13 blocks + 8 allows) incl. UK/EMEA ad hosts, whitelists protect playback |
| **Disney+** | `filterlist.streaming.disney.txt` | ✅ **WORKING** | 30-40% effectiveness (SSAI limitation), disneyadvertising.com targeted |
| **Roku** | `filterlist.streaming.roku.txt` | ✅ **ENHANCED** | 32 rules — 17 blocks + 15 allows, incl. 2 regex patterns |
| **Apple TV** | `filterlist.streaming.appletv.txt` | ⚪ **NO AD TIER** | 2 rules, kept as a stub (Apple has "no plans" for ads) |
| **Peacock/NBC** | `filterlist.streaming.peacock.txt` | ⚠️ **IMPROVED (May 2026)** | App v7.4.21+ changed ad delivery; ajstrick81 v2.7 claims renewed effectiveness on Android/iOS; 5-40% effective |
| **Paramount+** | `filterlist.streaming.paramount.txt` | 🔴 **INEFFECTIVE (April 2026)** | DAI makes DNS blocking 0% effective; stay on an older app version |
| **Amazon Prime** | `filterlist.streaming.amazon.txt` | ⚠️ **LIMITED** | SSAI-only = cannot be blocked at DNS |
| **Hulu** | `filterlist.streaming.hulu.txt` | ⚪ **STUB** | US app only, 1 rule. Disney's ad hosts are in the Disney list |
| **Channel 4 / All4 + My5** | `filterlist.streaming.ukcatchup.txt` | 🆕 **NEW (Aug 2026)** | UK-only catch-up TV; 17 domains; medium FP risk (whitelist `cdn.http.anno.channel4.com` if playback fails) |
| **Main List** | `filterlist.txt` | ✅ **CURRENT** | 383 rules — 143 blocks + 240 allows (wildcard-optimised) |

---

## 📋 **Quick Summary**

| Metric | Details |
|--------|---------|
| **Format** | AdBlock Plus (`\|\|domain.com^`) + regex support |
| **Rules** | 383 in `filterlist.txt` (143 blocks + 240 allows), + 164 across the 13 streaming lists |
| **Last Updated** | **13 October 2026** (stack checked against the live AdGuard Home config) |
| **Primary Use** | AdGuard Home DNS-level blocking |
| **Also Works** | AdGuard browser extension, uBlock Origin, Adblock Plus, NextDNS, AdGuard DNS (cloud) |
| **Verification** | Cross-referenced against ozankiratli, ajstrick81, lit-bg community research |
| **Testing** | Normalized line endings (CRLF → LF), syntax verified |
| **AdGuard DNS Limit** | Custom list at 383/1000 rules (617 headroom remaining) |
| **AdGuard Home** | 34 lists, checked against the live config 13 Oct 2026 — see [CHANGELOG.md](CHANGELOG.md) |

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
| **HBO Max/Max** ⭐ | 21 rules (13 blocks + 8 allows) | 20-30% | ✅ **PRODUCTION READY** |
| **Disney+** | 6 rules — disneyadvertising.com + diproton-ads regex | 30-40% | ✅ **WORKING** |
| **Apple TV** | 2 rules | n/a | ⚪ **NO AD TIER** |
| **Roku** | 32 rules — 17 blocks + 15 allows, 2 regex | 40%+ | ✅ **ENHANCED** |
| **Hulu** | 1 rule | 50% (US app) | ⚪ **STUB** |
| **Sky Glass** | 20 rules — 13 blocks + 7 allows | 40% | ✅ **WORKING** |
| **Peacock/NBC** | 23 rules — 6 blocks + 17 allows | 5-40% | ⚠️ **IMPROVED (May 2026)** |
| **Paramount+** | 23 rules | 0% | 🔴 **DAI UNSOLVABLE** |
| **Amazon Prime** | 8 rules | 0% | ⚠️ **SSAI ONLY** |

### Tracking & Analytics
- **Meta/Facebook** — covered by the third-party lists (the old `$third-party` rules were ignored by AdGuard Home and removed 2026-09-28)
- **Google** — Google Analytics, AdSense, DoubleClick, Ads, Tagmanager
- **Apple** — iCloud Feedback, Weather analytics
- **Microsoft** (Copilot blocking, Telemetry)
- **OpenAI, Anthropic, Gemini** — AI service blocking
- **Pinterest, Snapchat, TikTok** — Social media tracking

### Ad Networks & CDNs
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
- **AdGuard Home (DNS):** ✅ Full support — **regex included**; `filterlist.streaming.roku.txt` relies on it
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

### AdGuard Home — live stack (34 lists)

Read from the live `AdGuardHome.yaml` on **13 October 2026**, with the changes from that
day's audit applied (see [CHANGELOG.md](CHANGELOG.md)). No DNS allowlists are loaded: allow
rules live in `filterlist.txt`, where they are documented.

> **Note:** AdGuard Home and uBlock Origin are *separate* stacks and are no longer
> documented as one. uBlock (desktop) runs a 21-list set that assumes AdGuard Home handles
> DNS: uBO built-ins, EasyList, EasyPrivacy (the only list with path rules for the Meta Pixel),
> URL Tracking Protection, URLhaus, Peter Lowe, the EasyList cookie and annoyance lists,
> Netflix and two cosmetic lists. No DNS lists: HaGeZi PRO was dropped 13 Oct 2026 as a
> duplicate of AdGuard Home. The master list is deliberately left out, because its
> `@@` allow rules override EasyList in uBO.

#### 🛡️ Blocklists (34)

| # | Group | List | URL | Purpose |
|---|---|---|---|---|
| 1 | Core | **HaGeZi Multi PRO** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt` | Main list: ads, trackers, malware, phishing, scam, popups. Includes the HaGeZi native lists at partial strength |
| 2 | Core | **AdGuard DNS filter** | `https://filters.adtidy.org/extension/chromium/filters/15.txt` | ~107K domains not in Pro, mostly CNAME-cloaked first-party trackers (`metrics.`, `stape.`) |
| 3 | Core | **OISD Small** | `https://small.oisd.nl/` | 99% inside Pro (374 extra domains). Kept as a second maintainer, optional |
| 4 | Security | **HaGeZi TIF Mini** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/tif.mini.txt` | Threat intelligence, small build. Full TIF (2.18M) deliberately not used |
| 5 | Security | **HaGeZi TIF - IPs** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/tif-ips.txt` | IP-based threat blocking ⚠️ see FP note |
| 6 | Security | **Dandelion Sprout's Anti-Malware (AGH build)** | `https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Alternate%20versions%20Anti-Malware%20List/AntiMalwareAdGuardHome.txt` | Malware. The browser build's `$all`/`$doc` rules are ignored by AGH, use this one |
| 7 | Security | **Phishing Army Extended** | `https://phishing.army/download/phishing_army_blocklist_extended.txt` | Dedicated phishing domains |
| 8 | Security | **URLHaus** | `https://malware-filter.gitlab.io/malware-filter/urlhaus-filter-agh.txt` | Malicious URLs (AdGuard Home build) |
| 9 | Security | **HaGeZi Badware Hoster** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/hoster.txt` | Free hosters that host badware |
| 10 | Security | **HaGeZi Dynamic DNS** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/dyndns.txt` | Dynamic DNS abuse |
| 11 | Smart TV | **Perflyst & Dandelion Sprout Smart-TV** | `https://adguardteam.github.io/HostlistsRegistry/assets/filter_7.txt` | Smart TV ads |
| 12 | Smart TV | **BlocklistProject Smart TV** | `https://raw.githubusercontent.com/blocklistproject/Lists/master/smart-tv.txt` | Samsung/LG/Roku telemetry |
| 13 | Native OEM | **HaGeZi Native Amazon (Fire TV)** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.amazon.txt` | Fire TV/Stick ad bidding, OTT DTB (26 domains beyond Pro) |
| 14 | Native OEM | **HaGeZi Native Roku (ACR)** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.roku.txt` | Roku ACR, ravm.tv (17 beyond Pro) |
| 15 | Native OEM | **HaGeZi Native Apple** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.apple.txt` | Apple TV analytics, SKAdNetwork (40 beyond Pro) |
| 16 | Native OEM | **HaGeZi Native Windows/Office** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.winoffice.txt` | Windows/Office telemetry (50 beyond Pro) |
| 17 | Native OEM | **HaGeZi Native Samsung** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.samsung.txt` | Fully inside Pro, optional |
| 18 | Native OEM | **HaGeZi Native LG webOS** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.lgwebos.txt` | Fully inside Pro, optional |
| 19 | Native OEM | **HaGeZi Native TikTok** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.tiktok.txt` | Fully inside Pro, optional |
| 20 | Native OEM | **HaGeZi Native Vivo** | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.vivo.txt` | 5 domains beyond Pro, optional |
| 21 | Mine | **My Own Filter List - Master** | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/filterlist.txt` | Custom cross-service + tracking blocks |
| 22 | Mine | **My Own Filter List - Amazon** | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.amazon.txt` | Amazon ad/tracking blocks |
| 23 | Mine | **My Own Filter List - Appletv** | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.appletv.txt` | Appletv ad/tracking blocks |
| 24 | Mine | **My Own Filter List - Disney** | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.disney.txt` | Disney ad/tracking blocks |
| 25 | Mine | **My Own Filter List - Hbo** | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.hbo.txt` | Hbo ad/tracking blocks |
| 26 | Mine | **My Own Filter List - Hulu** | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.hulu.txt` | Hulu ad/tracking blocks |
| 27 | Mine | **My Own Filter List - Netflix** | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.netflix.txt` | Netflix ad/tracking blocks |
| 28 | Mine | **My Own Filter List - Paramount** | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.paramount.txt` | Paramount ad/tracking blocks |
| 29 | Mine | **My Own Filter List - Peacock** | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.peacock.txt` | Peacock ad/tracking blocks |
| 30 | Mine | **My Own Filter List - Pluto** | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.pluto.txt` | Pluto ad/tracking blocks |
| 31 | Mine | **My Own Filter List - Roku** | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.roku.txt` | Roku ad/tracking blocks |
| 32 | Mine | **My Own Filter List - Skyglass** | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.skyglass.txt` | Skyglass ad/tracking blocks |
| 33 | Mine | **My Own Filter List - Tubi** | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.tubi.txt` | Tubi ad/tracking blocks |
| 34 | Mine | **My Own Filter List - Ukcatchup** | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.ukcatchup.txt` | Ukcatchup ad/tracking blocks |

> ⚠️ **TIF-IPs false positives:** it blocks by resolved IP, so any site on a shared
> Vercel/Cloudflare/Netlify address can be caught (e.g. `cruisenation.com` on 2026-09-02).
> Each needs an `@@||domain^` entry in `filterlist.txt`. Drop TIF-IPs if it becomes frequent.

**Removed 13 October 2026:** StreamNoAds (AI-generated entries, root-blocked `yospace.com`),
FTPrivacy Smart TV (unmaintained since 2022), and the two DNS allowlists, Coupert (unblocked
data brokers) and uBlock filters – Unbreak (a browser list). **Considered and skipped:**
HaGeZi spam-tlds (blocks all `.shop`/`.store`/`.online`), Pop-Up Ads (inside Pro), 1Hosts Lite.

### 📊 Total Coverage

| Metric | Value |
|--------|-------|
| **Third-party blocklist rules** | ~883,000 before overlap (Pro 193K, AdGuard DNS 184K, Phishing Army 141K, TIF Mini 236K) |
| **My custom rules** | 383 in `filterlist.txt` (143 blocks + 240 allows) + 164 across the 13 streaming lists |
| **Blocklists** | 34 |
| **Last verified** | 13 October 2026, against the live AdGuardHome.yaml. Rule counts re-derived from the files. |

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
| My Own Filter List - Master | **470** | **470/1000** |

**Why wildcards matter:** AdGuard DNS limits custom lists to 1K rules. The August wildcard pass took the list from 882 → 425; it has since grown back to 470, still 47% below the pre-optimisation peak and comfortably under the cap.

---

## 📄 **License & Attribution**

- **Filter Format:** AdBlock Plus (open standard)
- **Community Reference:** ozankiratli gist, Hagezi, AdGuard, EasyList, uBlock Origin, Dandelion Sprout, OISD
- **Verification:** Brave Search, Jina AI, Firecrawl
- **Last Comprehensive Update:** 3 September 2026

---

## 🔗 **Repository Layout**

```
adguard/
  filterlist.txt                    # Main cross-service filter (383 rules — 143 blocks + 240 allows)
  streaming/                        # Service-specific filters:
    filterlist.streaming.hbo.txt        (HBO Max - PRODUCTION READY)
    filterlist.streaming.disney.txt     (Disney+ - WORKING)
    filterlist.streaming.paramount.txt  (Paramount+ - DAI UNSOLVABLE)
    filterlist.streaming.peacock.txt    (Peacock - IMPROVED May 2026)
    filterlist.streaming.roku.txt       (Roku - ENHANCED, 2 regex + 17 blocks)
    filterlist.streaming.amazon.txt     (Prime Video - LIMITED)
    filterlist.streaming.hulu.txt       (Hulu - stub, US app)
    filterlist.streaming.appletv.txt    (Apple TV - stub, no ad tier)
    filterlist.streaming.netflix.txt    (Netflix - tracking)
    filterlist.streaming.skyglass.txt   (Sky Glass - WORKING)
    filterlist.streaming.tubi.txt       (FAST service, stub, covered upstream)
    filterlist.streaming.pluto.txt      (FAST service, stub, covered upstream)
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

*Last updated: 3 September 2026*
*Cross-verified against: ozankiratli community research, Hagezi, AdGuard, EasyList, OISD*
