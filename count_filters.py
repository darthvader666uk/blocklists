#!/usr/bin/env python3
import urllib.request
import urllib.error
import ssl
import csv
import os
from datetime import datetime

urls = [
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://filters.adtidy.org/extension/chromium/filters/4.txt",
    "https://filters.adtidy.org/extension/chromium/filters/11.txt",
    "https://secure.fanboy.co.nz/fanboy-annoyance.txt",
    "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt",
    "https://phishing.army/download/phishing_army_blocklist_extended.txt",
    "https://raw.githubusercontent.com/robonxt/CleanYourTwitter/master/CleanYourTwitter.txt",
    "https://gist.githubusercontent.com/darthvader666uk/ccfdab18b9d59830876c373db8b4210d/raw/filterlist.txt",
    "https://filters.adtidy.org/extension/chromium/filters/15.txt",
    "https://urlhaus.abuse.ch/downloads/hostfile/",
    "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=adblockrules&showintro=0&mimetype=plaintext",
]

out_path = os.path.join(os.path.dirname(__file__), "filter_counts.csv")

ssl_ctx = ssl.create_default_context()
ssl_ctx.check_hostname = True

headers = {"User-Agent": "Mozilla/5.0 (compatible; filter-counter/1.0)"}

results = []

for url in urls:
    print(f"Fetching: {url}")
    req = urllib.request.Request(url, headers=headers)
    total_lines = 0
    non_comment = 0
    size_bytes = 0
    note = ""
    try:
        with urllib.request.urlopen(req, timeout=30, context=ssl_ctx) as r:
            data = r.read()
            size_bytes = len(data)
            try:
                text = data.decode('utf-8')
            except UnicodeDecodeError:
                text = data.decode('utf-8', errors='replace')
            lines = text.splitlines()
            for ln in lines:
                total_lines += 1
                s = ln.strip()
                if not s:
                    continue
                if s.startswith('!') or s.startswith('#') or s.startswith('//'):
                    continue
                non_comment += 1
    except Exception as e:
        note = f"ERROR: {e}"
        print(note)
    results.append({
        'url': url,
        'non_comment_lines': non_comment,
        'total_lines': total_lines,
        'bytes': size_bytes,
        'note': note,
    })

with open(out_path, 'w', newline='', encoding='utf-8') as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow(["url","non_comment_lines","total_lines","bytes","note","timestamp"])
    for r in results:
        writer.writerow([r['url'], r['non_comment_lines'], r['total_lines'], r['bytes'], r['note'], datetime.utcnow().isoformat() + 'Z'])

print('\nDone. Wrote:', out_path)
