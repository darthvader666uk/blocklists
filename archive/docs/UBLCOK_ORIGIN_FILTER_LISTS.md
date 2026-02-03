# uBlock Origin Filter Lists - Ready to Copy & Paste

Copy and paste these URLs into uBlock Origin to match your AdGuard Home setup.

## How to Add to uBlock Origin:

1. Click **uBlock Origin icon** → **Dashboard** (or open `about:addons` → uBlock Origin → Preferences)
2. Go to **Filter lists** tab
3. Scroll to **Custom** section
4. **Paste each URL below** into the text field
5. Click **Apply changes**

---

## 📋 FILTER LISTS TO ADD

### Core Ad Blocking
```
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/tif.txt
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/popupads.txt
```

### Threat Intelligence
```
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/tif-ips.txt
```

### Tracking Protection
```
https://filters.adtidy.org/extension/chromium/filters/3.txt
```

### Social Media Blocking
```
https://filters.adtidy.org/extension/chromium/filters/4.txt
```

### Annoyances
```
https://secure.fanboy.co.nz/fanboy-annoyance.txt
https://secure.fanboy.co.nz/fanboy-cookiemonster.txt
```

### Privacy
```
https://filters.adtidy.org/extension/chromium/filters/17.txt
```

### Fingerprinting
```
https://filters.adtidy.org/extension/chromium/filters/11.txt
```

### Badware & Phishing
```
https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt
https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt
https://phishing.army/download/phishing_army_blocklist_extended.txt
```

### URL Shorteners & Security
```
https://urlhaus.abuse.ch/downloads/hostfile/
```

### CNAME Trackers
```
https://filters.adtidy.org/extension/chromium/filters/15.txt
```

### Device-Specific Trackers (Optional)
```
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.amazon.txt
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.apple.txt
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.microsoft.txt
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.samsung.txt
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/native.tiktok.txt
```

### Twitter Cleanup (Optional)
```
https://raw.githubusercontent.com/robonxt/CleanYourTwitter/master/CleanYourTwitter.txt
```

---

## 🎯 MINIMUM SETUP (Fastest)

If you want just the essentials, copy-paste these 4:

```
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/tif.txt
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/popupads.txt
https://filters.adtidy.org/extension/chromium/filters/3.txt
```

---

## ✅ FULL SETUP (Complete Protection)

Copy everything above for maximum coverage matching your AdGuard Home.

---

## 📌 IMPORTANT NOTES

1. **Already built into uBlock Origin:**
   - EasyList
   - EasyPrivacy
   - Malware Domain List
   - Peter Lowe's Ad Server list
   
   These are already enabled by default, so DON'T add them again.

2. **Order doesn't matter** - Add in any order

3. **Wait for sync** - Each list takes 5-30 seconds to load

4. **uBlock + AdGuard Home = Double blocking**
   - Your DNS is already blocking these at network level
   - uBlock will double-check at browser level
   - This catches ads that slip through DNS (like YouTube ads)

5. **If something breaks:**
   - Uncheck the list that's causing issues
   - Or use uBlock's "My filters" tab to whitelist specific domains
   - Example: `@@||youtube.com^` to whitelist YouTube

---

## 🧪 TESTING

After adding all lists:

1. Visit a site with lots of ads (e.g., news site)
2. Open uBlock stats: Click uBlock icon → "Requests blocked today"
3. Should see 1000+ requests blocked
4. If too many things break, remove 1-2 lists at a time

---

## 💾 BACKUP YOUR SETTINGS

Before adding all lists, export your current uBlock settings:
1. uBlock Dashboard → Settings (gear icon)
2. Scroll to bottom → "Backup to file"
3. Save it as `ublock-backup.txt`

This way you can restore if something breaks.

