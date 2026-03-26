# 📊 Filter List Organization Summary

## 🎯 Quick Stats
- **Total entries:** ~375 rules
- **Deny List entries:** ~205 rules
- **Allow List (whitelists):** ~135 rules  
- **Privacy/Tracking blocks:** ~35 rules

---

## 📺 STREAMING SERVICES (Block List)

### HBO Max / Max ⭐ NEW (21 rules)
- `akm.emea-free.prd.media.max.com` (EMEA ad delivery - your issue!)
- `cf.emea-free.prd.media.max.com` (CloudFront CDN)
- `gcp.emea-free.prd.media.max.com` (Google Cloud)
- `akm.amer-free.prd.media.max.com`, `cf.amer-free.prd.media.max.com`, `gcp.amer-free.prd.media.max.com` (Americas)
- `fly.amer-free.prd.media.max.com` (Americas)
- `akm.apac-free.prd.media.max.com`, `cf.apac-free.prd.media.max.com` (APAC)
- `litix.io`, `*.litix.io` (Litix SSAI telemetry) ⭐ CRITICAL
- `fwmrm.net`, `*.fwmrm.net` (FreeWheel SSAI ad server) ⭐ CRITICAL
- Status: **✅ Verified working (GitHub issue #215201)**

### Paramount+ (8 rules)
- Ad networks & tracking domains
- Status: ❌ **Uses SSAI (Server-Side Ad Insertion) - Cannot block at DNS level**

### Disney+ (1 rule)
- `disneyadvertising.com`

### Peacock (2 rules)
- `mt.ssai.peacocktv.com`
- `bff-ext.clients.peacocktv.com`

### Netflix (3 rules - candidate filters)
- Third-party ad networks: `adsrvr.org`, `adsafeprotected.com`, `adsrvr.com`
- Additional telemetry rules (commented out - risky)

### Sky Glass / Smart TV Ad Networks (21 rules)
- Alphonso, Ravm, TVInteractive, SpotX, SmartClip, 2mdn, GoogleAds, etc.

### Roku (2 rules)
- `roku.admeasurement.com`, `ravm.tv`

---

## 🛑 GENERAL DENY LIST (28 rules)

### Apple Tracking (8 rules)
- iCloud feedback, iAds SDK, App analytics, DNS over HTTPS

### Meta/Facebook (1 rule - extended blocking in section below)
- `facebook.com` 3rd-party blocking (60+ additional rules)

### Twitter (1 rule)
- `syndication.twitter.com`

### Spotify (2 rules)
- `wl.spotify.com`, `adeventtrackermonitoring.spotify.com`

### NVIDIA (1 rule)
- `events.gfe.nvidia.com`

### Other Trackers (15 rules)
- Russian tracker, StartPage ads, various privacy trackers

---

## ✅ ALLOW LIST / CRITICAL WHITELISTS (135+ rules)

### Paramount+ (11 rules)
- Playback servers, analytics, CDN nodes

### Netflix (3 rules)
- `assets.nflxext.com` (critical)
- `help.nflxext.com`, `occ.a.nflxso.net`

### Streaming Infrastructure (7 rules)
- Facebook/WhatsApp Web, Comcast, Conviva, Sky TV

### Services That Need Whitelisting (40+ rules)
- **Currys** (`*.currys.biz`, `*.omtrdc.net`)
- **WWE Supercard** (`bobcatwweproduction.cdgsrv.com`)
- **Wisdom App** (Azure insights, chartboost, Unity mediation)
- **WhatsApp Web** (4 rules)
- **Shopify** (`*.shopifycloud.com`)
- **Canva** (`cdn.metadata.io`)
- **IPTV** (`clickwork7secure.com`)
- **Streaming** (thehoppers.life, gohyperspeed.com, webplayer.online)
- **Various Tracking Services** (PostHog, Amplitude, Talkable, etc.)

### Generic Wildcards (60+ rules)
- `*.shop`, `*.help`, `*.site`, `*.games`, `*.biz`, `*.email`, `*.wedding`, etc.

---

## 🔍 PRIVACY & TRACKING BLOCKS (35 rules)

### Google Services (8 rules)
- Google Analytics, Tag Manager, Syndication, Double Click

### Network-Level Trackers (19 rules)
- Segment, Mixpanel, Hotjar, FullStory, Amplitude, Matomo, StatCounter, etc.

### Meta / Facebook / WhatsApp (70+ rules with modifiers)
- Blocks Facebook tracking across web as 3rd-party (safe for WhatsApp Web)
- Instagram, Messenger, Workplace, Oculus

### AI Service Blocking (6 rules)
- OpenAI, Anthropic, Gemini, Copilot, Palm (script-only)

---

## 📋 ORGANIZATION ISSUES TO FIX

1. **Redundancy**: Some entries appear in multiple sections
2. **Order**: Rules not grouped logically (deny, then allow, then privacy)
3. **Comments**: Some inline comments could be clearer
4. **Missing descriptions**: Some Roku/Tubi/Pluto rules mentioned in docs but not in list

---

## 🚀 RECOMMENDED CLEANUP

### Priority 1: Reorganize into sections
1. Deny List (Block)
2. Allow List (Whitelist)
3. Privacy & Tracking
4. Streaming Services (by name)

### Priority 2: Add missing entries
- Tubi, Pluto TV, Apple TV+, Hulu blocks (mentioned in docs, missing here?)

### Priority 3: Remove/consolidate redundancy
- Merge duplicate Facebook rules
- Move generic wildcards to their own section
