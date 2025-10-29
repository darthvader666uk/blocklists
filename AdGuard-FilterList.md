# AdGuard Home Filter List

A comprehensive DNS filter list for AdGuard Home with rules for blocking ads, trackers, and streaming service advertising.

## Features

- ✅ **AdGuard DNS syntax** compatible with AdGuard Home
- ✅ **Duplicate-free** - All redundant rules removed
- ✅ **Multiple blocklists** - Apple tracking, Spotify ads, Disney+, Paramount+, and more
- ✅ **Whitelist exceptions** - Carefully curated allowlist for legitimate services
- ✅ **Regex support** - Advanced pattern matching for complex rules

## How to Import

### In AdGuard Home:

1. Go to **Filters → DNS blocklists**
2. Click **Add blocklist**
3. Paste the raw URL from the Gist:
   ```
   https://gist.githubusercontent.com/[YOUR_USERNAME]/[GIST_ID]/raw
   ```
4. Click **Add** and enable the filter

### Manual Import:

1. Copy the raw content from the Gist
2. In AdGuard Home, go to **Filters → Custom filtering rules**
3. Paste the rules and click **Save**

## Filter Categories

### 1. **Deny List** (General Tracking & Spying)
Blocks known tracking and surveillance domains including:
- Apple analytics and feedback services
- Spotify event tracking
- NVIDIA telemetry
- Twitter syndication
- Various privacy-invasive domains

### 2. **Paramount+ Blacklist**
Comprehensive ad network blocking for Paramount+ streaming:
- Google Ad services (DoubleClick, AdSense)
- Programmatic advertising networks (OpenX, PubMatic, Criteo, Rubicon)
- Video ad services (FreeWheel)
- Analytics and measurement (Conviva, Moat)
- Platform-specific tracking

### 3. **Disney+ Blacklist**
Blocks Disney advertising domains

### 4. **Allow List (Whitelist)**
Critical exceptions for streaming services and legitimate services:
- Paramount+ CDN and infrastructure
- Disney+ streaming endpoints
- Shopify, Canva, and productivity services
- IPTV and entertainment platforms
- Shopping and affiliate networks
- DNS and analytics services (for specific clients)

## Rule Format

Rules follow the AdBlock-style syntax supported by AdGuard:

```
||domain.com^              # Block domain and subdomains
@@||domain.com^            # Allow (whitelist) domain and subdomains
/regex_pattern/            # Regular expression matching
$client='Client Name'      # Client-specific rules
```

## Statistics

- **Total Rules**: 147+
- **Blocking Rules**: ~100
- **Whitelist Rules**: ~47
- **Regex Rules**: 1

## Notes

- Rules are regularly updated to maintain effectiveness
- Some rules may cause minor UI issues on whitelisted services (e.g., missing thumbnails)
- Test in "Safe Browsing" mode before applying to entire network
- For best results, pair with additional filter lists from AdGuard

## License

Public Domain - Use freely for any purpose

## Contributing

Found an issue or have a suggestion? Please report it or create a pull request.

---

**Last Updated**: October 29, 2025
