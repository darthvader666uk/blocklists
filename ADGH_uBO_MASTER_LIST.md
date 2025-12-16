# AdGuard Home & uBlock Origin — Master Checklist

This file is a concise master list of subscriptions and actions to keep your AdGuard Home (DNS-level) and uBlock Origin (browser-level) configurations lean, fast, and non-overlapping.

> Location: `c:\Users\darth\Documents\scripts\gist\ADGH_uBO_MASTER_LIST.md`

---

## 1 — Overview
- Keep heavy DNS-level protections (CNAME, TIF, Hagezi Pro) in AdGuard Home.
- Keep UI/annoyance and fingerprinting rules in the browser (uBlock Origin).
- Keep your custom `filterlist.txt` in AdGuard Home with top priority to preserve whitelists.

---

## 2 — AdGuard Home (DNS-level) — URLs to KEEP (add these)
Add these in AdGuard Home → Settings → DNS blocklists (one per line). Keep your gist/custom list at top priority.

- `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt`  # Hagezi Multi PRO
- `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/tif.txt`  # Hagezi TIF (malware/phishing)
- `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/tif-ips.txt`  # Hagezi TIF IPs (optional)
- `https://filters.adtidy.org/extension/chromium/filters/15.txt`  # AdGuard CNAME Disguised Trackers
- `https://phishing.army/download/phishing_army_blocklist_extended.txt`  # Phishing Army Extended
- `https://urlhaus.abuse.ch/downloads/hostfile/`  # URLHaus hosts
- `https://gist.githubusercontent.com/darthvader666uk/ccfdab18b9d59830876c373db8b4210d/raw/filterlist.txt`  # Your custom filterlist (keep first)
- `https://secure.fanboy.co.nz/fanboy-annoyance.txt`  # Fanboy Annoyances
- `https://secure.fanboy.co.nz/fanboy-cookiemonster.txt`  # Cookie dialog helper

### Hagezi native/device trackers (keep if you want device telemetry blocked)
- `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.amazon.txt`
- `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.apple.txt`
- `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.huawei.txt`
- `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.winoffice.txt`
- `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.samsung.txt`
- `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.tiktok.txt`  # standard TikTok
- `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.lgwebos.txt`
- `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.roku.txt`
- `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.xiaomi.txt`

---

## 3 — AdGuard Home — URLs we REMOVED (for reference)
(You already removed these to reduce duplication.)

- `https://raw.githubusercontent.com/DandelionSprout/adfilt/refs/heads/master/Dandelion%20Sprout's%20Anti-Malware%20List.txt`
- `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/spam-tlds.txt`
- `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/dyndns.txt`
- `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/hoster.txt`
- `https://adguardteam.github.io/HostlistsRegistry/assets/filter_61.txt`  # Samsung duplicate
- `https://adguardteam.github.io/HostlistsRegistry/assets/filter_60.txt`  # Xiaomi duplicate
- `https://adguardteam.github.io/HostlistsRegistry/assets/filter_63.txt`  # Windows/Office duplicate
- `https://secure.fanboy.co.nz/fanboy-social.txt`
- `https://www.fanboy.co.nz/fanboy-antifacebook.txt`
- `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.tiktok.extended.txt`  # aggressive TikTok (removed)
- `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.vivo.txt`  # removed
- `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.oppo-realme.txt`  # removed

---

## 4 — AdGuard Home — Steps (order)
1. Add your custom gist filter first: `https://gist.githubusercontent.com/......filterlist.txt` (so whitelists override others).
2. Add the core Hagezi/TIF/CNAME/Phishing/URLHaus entries.
3. Add Fanboy annoyance/cookie lists.
4. Click **Update filters** / **Refresh** in AdGuard Home (Settings → General or Filtering → Refresh depending on UI).
5. Verify: Settings → Filtering → Filters or Dashboard shows each list and rule counts. Use Query Log to validate real traffic hits.
6. Clear client DNS cache / browsers to test sites.

---

## 5 — uBlock Origin (browser-level) — Subscriptions to ADD
Open uBO → Dashboard → Filter lists → "Import" or add subscriptions by URL.

- `https://easylist.to/easylist/easylist.txt`  # EasyList (primary)
- `https://easylist.to/easylist/easyprivacy.txt`  # EasyPrivacy (primary privacy)
- `https://filters.adtidy.org/extension/chromium/filters/4.txt`  # AdGuard Social Media
- `https://filters.adtidy.org/extension/chromium/filters/11.txt`  # AdGuard Fingerprinting
- `https://secure.fanboy.co.nz/fanboy-annoyance.txt`  # Fanboy Annoyances
- `https://secure.fanboy.co.nz/fanboy-cookiemonster.txt`  # Cookie helper
- `https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt`  # uBO Badware
- `https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt`  # uBO Privacy
- `https://phishing.army/download/phishing_army_blocklist_extended.txt`  # Phishing Army (browser-level)
- `https://raw.githubusercontent.com/robonxt/CleanYourTwitter/master/CleanYourTwitter.txt`  # optional: Twitter cleanup

### uBO Notes
- Choose ONE primary ad/base list: `EasyList` recommended here. Avoid adding both EasyList and AdGuard Base to reduce overlaps.
- Keep `EasyPrivacy` as main privacy list. If you keep AdGuard Tracking in uBO, expect overlap.
- Keep `AdGuard Fingerprinting` and `uBO Privacy` for additional protection.

---

## 6 — uBlock Origin — Steps
1. Dashboard → Filter lists → paste or import each URL above.
2. Click **Apply changes**.
3. Test sites; use uBO logger (element picker / logger) to verify blocking and to detect overblocking.

---

## 7 — Bulk paste lists (easy copy/paste)
### AdGuard Home bulk (one per line)
```
https://gist.githubusercontent.com/darthvader666uk/ccfdab18b9d59830876c373db8b4210d/raw/filterlist.txt
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/tif.txt
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/tif-ips.txt
https://filters.adtidy.org/extension/chromium/filters/15.txt
https://phishing.army/download/phishing_army_blocklist_extended.txt
https://urlhaus.abuse.ch/downloads/hostfile/
https://secure.fanboy.co.nz/fanboy-annoyance.txt
https://secure.fanboy.co.nz/fanboy-cookiemonster.txt
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.amazon.txt
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.apple.txt
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.huawei.txt
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.winoffice.txt
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.samsung.txt
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.tiktok.txt
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.lgwebos.txt
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.roku.txt
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.xiaomi.txt
```

### uBlock Origin bulk (one per line)
```
https://easylist.to/easylist/easylist.txt
https://easylist.to/easylist/easyprivacy.txt
https://filters.adtidy.org/extension/chromium/filters/4.txt
https://filters.adtidy.org/extension/chromium/filters/11.txt
https://secure.fanboy.co.nz/fanboy-annoyance.txt
https://secure.fanboy.co.nz/fanboy-cookiemonster.txt
https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt
https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt
https://phishing.army/download/phishing_army_blocklist_extended.txt
https://raw.githubusercontent.com/robonxt/CleanYourTwitter/master/CleanYourTwitter.txt
```

---

## 8 — Optional: quick Bash script (uses AdGuard Home API) to add the AdGuard Home URLs
> Only run if you want API automation. `ADMIN_PASS` must be exported safely. This example logs in, adds URLs, and refreshes filters.

```bash
# Export these first (use single quotes if password contains backticks)
# export ADMIN_PASS='wW,@`D8L;Ls6Yq1K:ihGV(Ii?u:lJ5'
# export ADMIN_USER='darthvader666uk'
# export ADGH='http://192.168.4.124'

# Login
curl -sS -X POST "$ADGH/control/login" -H 'Content-Type: application/json' -c cookies.txt --data-binary @- <<'JSON'
{"name":"'$ADMIN_USER'","password":"'$ADMIN_PASS'"}
JSON

# Example add (repeat for each URL)
curl -sS -X POST "$ADGH/control/filtering/add_url" -H 'Content-Type: application/json' --cookie cookies.txt \
  --data-binary '{"url":"https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt","name":"Hagezi Pro"}'

# Refresh
curl -sS -X POST "$ADGH/control/filtering/refresh" --cookie cookies.txt

# List filters (verify)
curl -sS "$ADGH/control/filtering/list" --cookie cookies.txt | jq '.filters[] | {id,url,enabled}'
```

---

## 9 — Notes & Troubleshooting
- Keep the custom gist filter at top priority to enforce whitelists. If a site breaks, check the gist first.
- CNAME-tracker protections are only effective at DNS-level (AdGuard Home). uBO cannot fully emulate CNAME rewrites in Chromium/MV3.
- `tif-ips.txt` blocks IPs — it is aggressive. Only enable if you accept possible collateral blocking of some services.
- After major changes: clear browser DNS cache (or restart browser) and flush local DNS caches on devices.
- Use Query Log (AdGuard Home) and uBO logger to verify real-world hits and adjust.

---

If you want, I can:
- produce a single-line-per-URL `adgh_urls.txt` and `ubo_urls.txt` files in this folder for easy copy/paste;
- or attempt to add the AdGuard Home URLs via API using your env vars (I will not run any destructive removals).

Finished generating this master checklist. Let me know which of the two actions you want next.
