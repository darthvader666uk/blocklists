# Streaming & Tracking Blocklists for AdGuard Home

DNS filter lists for AdGuard Home that go after streaming service ads (HBO Max, Disney+, Roku, Peacock, Sky Glass, Channel 4 and more) plus the trackers the big lists miss.

They're built to sit on top of a big general list like HaGeZi Pro, and fix what it gets wrong for streaming boxes and smart TVs.

If these lists save you some hassle, a coffee keeps them maintained :)

<a href="https://www.buymeacoffee.com/darthvader666uk" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" style="height: 51px !important;width: 217px !important;" ></a>

---

## Quick start (AdGuard Home)

1. Open AdGuard Home and go to **Filters → DNS blocklists → Add blocklist → Add a custom list**
2. Paste the master list URL:
   ```
   https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/filterlist.txt
   ```
3. Add the streaming list for each service you use (URLs below), same way
4. Make sure you also have a big general list (HaGeZi Multi PRO is what I use)

That's it. AdGuard Home refreshes them on its own schedule (every 24 hours by default).

Also works in: AdGuard DNS (cloud), the AdGuard browser extension and app, NextDNS, uBlock Origin. A few rules use regex, which AdGuard Home and AdGuard extensions support.

---

## Streaming lists

| Service | Raw URL | Rules | How well it works |
|---|---|---|---|
| Roku | [`filterlist.streaming.roku.txt`](https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.roku.txt) | 32 (17 blocks, 15 allows, 2 regex) | 40%+ |
| Sky Glass | [`filterlist.streaming.skyglass.txt`](https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.skyglass.txt) | 21 (14 blocks, 7 allows) | around 40% |
| Disney+ | [`filterlist.streaming.disney.txt`](https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.disney.txt) | 6 (3 blocks, 3 allows, 1 regex) | 30-40% |
| HBO Max | [`filterlist.streaming.hbo.txt`](https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.hbo.txt) | 21 (13 blocks, 8 allows) | 20-30% |
| Peacock | [`filterlist.streaming.peacock.txt`](https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.peacock.txt) | 23 (6 blocks, 17 allows) | 5-40% (app v7.4.21+ broke a lot of it) |
| Channel 4 / My5 (UK) | [`filterlist.streaming.ukcatchup.txt`](https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.ukcatchup.txt) | 16 blocks | new, medium false-positive risk |
| Netflix | [`filterlist.streaming.netflix.txt`](https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.netflix.txt) | 9 (6 blocks, 3 allows) | tracking only, see below |
| Hulu (US) | [`filterlist.streaming.hulu.txt`](https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.hulu.txt) | 1 | stub, Disney's ad hosts are in the Disney list |
| Paramount+ | [`filterlist.streaming.paramount.txt`](https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.paramount.txt) | 23 (11 blocks, 12 allows) | 0%, ads are stitched into the stream |
| Amazon Prime Video | [`filterlist.streaming.amazon.txt`](https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.amazon.txt) | 8 (6 blocks, 2 allows) | 0%, ads are stitched into the stream |
| Apple TV+ | [`filterlist.streaming.appletv.txt`](https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.appletv.txt) | 2 | stub, no ad tier |
| Pluto TV | [`filterlist.streaming.pluto.txt`](https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.pluto.txt) | 2 allows | stub, the big lists cover it |
| Tubi | [`filterlist.streaming.tubi.txt`](https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.tubi.txt) | 0 | placeholder, the big lists cover it |

The percentages are rough, from my own testing and community reports. Your mileage WILL vary by device, region and app version.

### What DNS blocking can't do

Some services stitch the ads into the video stream on their own servers (SSAI / DAI). The ad and the show come from the same domain, so there is nothing for a DNS blocker to block. That's why Paramount+ and Prime Video sit at 0%, and why nobody's DNS list fixes them.

Netflix ads are the same. If you're getting ads on Netflix, check which plan you're on first (the Sky bundle defaults to the ad tier).

---

## The master list

[`adguard/filterlist.txt`](adguard/filterlist.txt) has 391 rules: 149 blocks and 242 allows.

Yes, it's mostly allows, and that's on purpose. The big third-party lists do the heavy lifting but, they also break things (iCloud, CarPlay, shopping sites on shared Cloudflare/Vercel IPs). This list un-breaks those and adds the trackers they miss: smart TV telemetry, Windows telemetry, analytics on AI chatbots, and so on.

It's wildcard-optimised to stay well under the 1,000 custom rule limit on AdGuard DNS (cloud).

---

## If something breaks

1. Open AdGuard Home → **Query Log** and filter by the device
2. Find the blocked domain and check which list blocked it
3. If it's one of mine, the comments in the file (lines starting `!`) explain why it's there and what's safe to allow
4. Add `@@||the-domain.com^` to your custom rules to unblock it

Then please [open an issue](https://github.com/darthvader666uk/blocklists/issues) with the domain, the service and the device, so I can fix it for everyone.

---

## My full AdGuard Home setup

<details>
<summary>The 34 lists I run, checked against my live config on 13 October 2026</summary>

| # | Group | List | URL | Purpose |
|---|---|---|---|---|
| 1 | Core | HaGeZi Multi PRO | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt` | Main list: ads, trackers, malware, phishing, scam, popups |
| 2 | Core | AdGuard DNS filter | `https://filters.adtidy.org/extension/chromium/filters/15.txt` | ~107K domains not in Pro, mostly CNAME-cloaked first-party trackers |
| 3 | Core | OISD Small | `https://small.oisd.nl/` | 99% inside Pro. Kept as a second maintainer, optional |
| 4 | Security | HaGeZi TIF Mini | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/tif.mini.txt` | Threat intelligence, small build |
| 5 | Security | HaGeZi TIF - IPs | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/tif-ips.txt` | Blocks by IP (see the note below) |
| 6 | Security | Dandelion Sprout's Anti-Malware (AGH build) | `https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Alternate%20versions%20Anti-Malware%20List/AntiMalwareAdGuardHome.txt` | Malware. Use this build, AGH ignores the browser build's rules |
| 7 | Security | Phishing Army Extended | `https://phishing.army/download/phishing_army_blocklist_extended.txt` | Phishing domains |
| 8 | Security | URLHaus | `https://malware-filter.gitlab.io/malware-filter/urlhaus-filter-agh.txt` | Malicious URLs (AdGuard Home build) |
| 9 | Security | HaGeZi Badware Hoster | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/hoster.txt` | Free hosters that host badware |
| 10 | Security | HaGeZi Dynamic DNS | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/dyndns.txt` | Dynamic DNS abuse |
| 11 | Smart TV | Perflyst & Dandelion Sprout Smart-TV | `https://adguardteam.github.io/HostlistsRegistry/assets/filter_7.txt` | Smart TV ads |
| 12 | Smart TV | BlocklistProject Smart TV | `https://raw.githubusercontent.com/blocklistproject/Lists/master/smart-tv.txt` | Samsung/LG/Roku telemetry |
| 13 | Native OEM | HaGeZi Native Amazon (Fire TV) | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.amazon.txt` | Fire TV ad bidding |
| 14 | Native OEM | HaGeZi Native Roku | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.roku.txt` | Roku ACR |
| 15 | Native OEM | HaGeZi Native Apple | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.apple.txt` | Apple TV analytics |
| 16 | Native OEM | HaGeZi Native Windows/Office | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.winoffice.txt` | Windows/Office telemetry |
| 17 | Native OEM | HaGeZi Native Samsung | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.samsung.txt` | Inside Pro, optional |
| 18 | Native OEM | HaGeZi Native LG webOS | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.lgwebos.txt` | Inside Pro, optional |
| 19 | Native OEM | HaGeZi Native TikTok | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.tiktok.txt` | Inside Pro, optional |
| 20 | Native OEM | HaGeZi Native Vivo | `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.vivo.txt` | Optional |
| 21-34 | Mine | The master list plus the 13 streaming lists above | | |

Heads up on TIF-IPs: it blocks by resolved IP, so any site on a shared Cloudflare/Vercel/Netlify address can get caught. AdGuard Home shows these as "Blocked by CNAME or IP". The fix is an `@@||domain^` allow, which is why a lot of the allows in the master list exist.

Tried and dropped: StreamNoAds, FTPrivacy Smart TV, HaGeZi spam-tlds (blocks every `.shop` / `.store` / `.online` site), 1Hosts Lite. Reasons are in the [CHANGELOG](CHANGELOG.md).

</details>

---

## What else is in here

- [`ublock/`](ublock/) is my uBlock Origin settings backup (restore it from uBO's settings page, it's not a filter list)
- [`plugblock/`](plugblock/) is a plug-in-and-go blocking box I'm designing. No code yet
- [`CHANGELOG.md`](CHANGELOG.md) has every dated change
- [`MIGRATION.md`](MIGRATION.md) is for anyone still on the old gist

### Coming from the old gist?

These lists used to live in a GitHub Gist. The gist copies are frozen and no longer get updates. Same filenames, new URLs: swap `gist.githubusercontent.com/...` for the URLs above, or see [MIGRATION.md](MIGRATION.md) for the full old → new table.

---

## Contributing

Spotted an ad getting through, or something broken? [Open an issue](https://github.com/darthvader666uk/blocklists/issues) with the domain, the service and the device. PRs welcome too. Run `bash scripts/validate-filters.sh` before sending one (CI runs it anyway).

Thanks to HaGeZi, Dandelion Sprout, OISD, AdGuard, EasyList, Perflyst and the ozankiratli and ajstrick81 streaming research, which a lot of this builds on.
