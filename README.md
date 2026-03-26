# Custom Ad Blocking Filter List for AdGuard Home & Streaming Services

**A comprehensive, organized DNS-level filter list specifically optimized for blocking streaming service ads (HBO Max, Disney+, Apple TV+, Peacock, etc.) and aggressive tracking.**

## ✅ HBO Max EU (Sky Glass) — WORKING

**Successfully blocking ads on HBO Max (EU region) with full video playback via surgical whitelisting of SSAI infrastructure.**

**Configuration:**
- ✅ Whitelist: `akm.eu.prd.media.max.com`, `gcp.eu.prd.media.max.com` (video/metadata)
- ✅ Whitelist: `litix.io`, `fwmrm.net` (SSAI playback engine — required for streaming)
- ❌ Block: 20+ regional CDN variants (cf-free, akm-free, gcp-free, etc.)
- ❌ Block: Pure ad-tech (braze, telegraph, app.link, brightline.tv, google.com/ccm)
- 🧹 Remove: Ad XML/JSON elements from manifests via uBlock scriptlets

**Result:** Full 4K video playback with ads removed from stream + analytics blocked

## 📋 Quick Summary

| Metric | Details |
|--------|---------|
| **Format** | AdBlock Plus (`\|\|domain.com^`) |
| **Rules** | ~585 carefully curated & categorized |
| **Primary Use** | AdGuard Home DNS-level blocking |
| **Also Works** | AdGuard browser extension, uBlock Origin, Adblock Plus |
| **Last Updated** | 2026-03-26 |
| **Focus** | Streaming ads + aggressive tracking (Meta/Facebook, Google, etc.) |

---

## 🚀 Quick Start

### Option 1: AdGuard Home (Recommended for Smart TVs & Network-Wide)

1. **Download the raw file (with cache-busting):**
   ```
   https://gist.githubusercontent.com/darthvader666uk/ccfdab18b9d59830876c373db8b4210d/raw/filterlist.txt?cache=$(date +%s)
   ```
   
   **OR** (without timestamp, uses CDN cache):
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

### Cache-Busting Note
If you're testing and updates aren't appearing, use the version with `?cache=$(timestamp)` to force a fresh download and bypass CDN caching.

### Option 2: Browser Extensions

#### uBlock Origin
- Dashboard → Filter lists → Import → Paste raw URL
- Or: **My filters** tab → paste rules directly

#### AdGuard Browser Extension
- Settings → Ad blocker → Custom & experimental → Custom filters
- Add URL: Same as above

---

## ✅ What This List BLOCKS

### Streaming Services (DNS-Level Effective)
| Service | Coverage | Status |
|---------|----------|--------|
| **HBO Max/Max** ⭐ | 20 verified rules | ✅ **FULLY BLOCKABLE** (GitHub-verified) |
| **Disney+** | disneyadvertising.com regex | ✅ **FULLY BLOCKABLE** |
| **Apple TV+** | 9 rules | ✅ **FULLY BLOCKABLE** |
| **Roku** | 37 rules (extended) | ✅ **FULLY BLOCKABLE** |
| **Sky Glass** | 21 ad network rules | ✅ **FULLY BLOCKABLE** |
| **Peacock/NBC** | 12 rules (fragile) | ⚠️ **PARTIAL** (CDN patterns change weekly) |

### Tracking & Analytics (~150 rules)
- **Meta/Facebook** (70+ rules) — All third-party Facebook/Instagram tracking
- **Google** (15+ rules) — Google Analytics, AdSense, DoubleClick
- **Apple** (16 rules) — iCloud Feedback, Weather analytics
- **Microsoft** (Copilot blocking)
- **OpenAI, Anthropic, Gemini** — AI service blocking

### Ad Networks & CDNs (50+ rules)
- General ad servers, attribution networks, SSAI services
- Smart TV ad frameworks
- Video ad insertion services

---

## ❌ What This List CANNOT BLOCK (Technical Limitations)

### Services Using SSAI (Server-Side Ad Insertion)
**These services CANNOT be blocked at DNS level** because ads are embedded in the video stream itself:

| Service | Why? | Workaround |
|---------|------|-----------|
| **Netflix** | Self-hosted SSAI | Pay for ad-free tier or use browser extension |
| **Hulu** | Google DynamicAdInsertion | Pay for ad-free tier |
| **Amazon Prime Video** | SSAI | Pay for ad-free tier |
| **Paramount+** | Google DynamicAdInsertion (most devices) | Roku version partially works; browser won't |

**Why SSAI blocks DNS filtering:**
- Ads & content come from **same domain/CDN**
- Blocking the domain blocks everything (videos won't play)
- DNS can't distinguish between ad segments and content segments

**Solution:** Use browser-level ad blocking (uBlock Origin, AdGuard extension) which can intercept at the DOM level.

---

## 📊 Filter List Organization

The list is organized into 5 sections for easy auditing:

1. **General Deny List** (28 rules)
   - Common trackers, Apple/Spotify/Twitter tracking

2. **Allow List / Whitelists** (145 rules)
   - Critical infrastructure to prevent false positives
   - Netflix, Paramount+, Sky Glass, WhatsApp, Shopify, IPTV

3. **Privacy & Tracking** (35+ rules)
   - Network-level tracker blocks (third-party only for safety)
   - Meta AI, Google Analytics, OpenAI, etc.

4. **Streaming Services** (110+ rules)
   - Netflix, Paramount+, Disney+, HBO Max, Apple TV+, Hulu, Amazon Prime
   - Peacock, Roku, Tubi, Pluto TV
   - Sky Glass/Smart TV networks

5. **Meta/Facebook Tracking** (70+ rules)
   - Aggressive third-party blocking (safe for WhatsApp Web)
   - Instagram, Messenger, WhatsApp, Oculus

---

## 🔧 Installation Details

### AdGuard Home Setup
```bash
# Typically runs on:
- Raspberry Pi (most common)
- Docker container
- NAS devices
- Home Assistant

# Add this URL to: Filters > DNS Blocklists > Add blocklist
https://gist.githubusercontent.com/darthvader666uk/ccfdab18b9d59830876c373db8b4210d/raw/filterlist.txt

# List Priority: Set to HIGH (overrides other lists for accuracy)
```

### Syncing Updates
This list is updated regularly. To keep it fresh:
- Check GitHub Gist for new versions monthly
- Most ad blockers auto-refresh URLs daily

---

## 📈 Effectiveness Estimates

| Category | Blocked | Notes |
|----------|---------|-------|
| **Website Ads** | 95%+ | Google Ads, EasyList covers remainder |
| **Streaming Ads** | 30-60% | Depends on SSAI usage |
| **Meta/Facebook Tracking** | 98%+ | Third-party only (FB itself still works) |
| **Smart TV Ads (Roku/Sky)** | 85%+ | Verified on Roku, Sky Glass |
| **Tracking/Analytics** | 98%+ | DNS-level blocks most common services |

---

## 🔗 Sources & Credits

### Primary Sources
- **HBO Max/Max Domains** — [GitHub AdguardTeam issue #215201](https://github.com/AdguardTeam/AdguardFilters/issues/215201) (user `ajstrick81` verified)
- **Streaming Service Lists** — [ozankiratli/PiHoleStreamingLists](https://gist.github.com/ozankiratli/801ba17705e7f2a904d2e443af5a64f8) (137★)
- **Sky Glass Rules** — Community testing on Comcast/Sky Glass devices
- **Peacock Blocking** — [ozankiratli Peacock discussion](https://gist.github.com/ozankiratli/801ba17705e7f2a904d2e443af5a64f8#peacock)

### Compatible With
✓ AdGuard Home  
✓ AdGuard browser extension  
✓ uBlock Origin  
✓ Adblock Plus  
✓ Pi-hole (via hosts import)  

---

## ⚠️ Important Notes

### Compatibility
- **Format:** AdBlock Plus syntax (`||domain.com^`)
- **Regex:** Includes some regex patterns (AdGuard Home converts to rules internally)
- **Third-Party Only Blocks:** Safe for first-party functionality
- **Whitelist Rules:** ~145 whitelists prevent false positives on critical services

### Performance
- **Size:** ~585 rules (~25KB)
- **Impact:** Negligible on modern hardware
- **CPU:** AdGuard Home typically <2% CPU overhead with this list

### Updates
- This is a **living filter list** — rules may change based on:
  - Streaming service changes (Peacock CDN patterns update frequently)
  - Community feedback
  - New threats discovered

---

## 🆘 Troubleshooting

**Streaming service not working?**
- Check **Allow List** section — may need to whitelist critical domains
- Check AdGuard Home **Query Logs** to see what's being blocked
- Temporarily disable this list to isolate the problem

**Peacock videos don't start?**
- Peacock changes CDN patterns weekly — see LIMITATIONS section
- Try whitelisting `bff-ext.clients.peacocktv.com`

**Paramount+ on browser doesn't work?**
- Paramount+ uses SSAI on most browsers — can't block ads at DNS level
- Works better on Roku with limited ads

---

## 📚 Additional Documentation

See `/docs` folder for deeper analysis:
- `STREAMING_AD_BLOCKING_ANALYSIS.md` — Technical breakdown of each service
- `ADGUARD_HOME_OPTIMIZATION.md` — Best practices for AdGuard Home
- `FILTER_LIST_INVENTORY.md` — Rule organization reference

---

## 📄 License & Attribution

This filter list combines rules from:
- Community GitHub discussions (⭐ credits to ozankiratli, ajstrick81, community testers)
- Original research on Sky Glass/Smart TV ad networks
- Verified blocking rules from AdGuard Team repos

**Use freely.** Share improvements via GitHub Gist comments.

---

**Last Updated:** 2026-03-26  
**Maintained by:** [darthvader666uk](https://gist.github.com/darthvader666uk)
