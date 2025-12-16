#!/usr/bin/env python3
"""Overlap analysis: fetch lists, normalize entries, compute per-list unique contribution
and combined unique count. Writes `filter_overlap.csv` and prints a short summary.
"""
import urllib.request
import ssl
import csv
import os
from datetime import datetime

CSV_IN = os.path.join(os.path.dirname(__file__), "filter_counts.csv")
CSV_OUT = os.path.join(os.path.dirname(__file__), "filter_overlap.csv")

ssl_ctx = ssl.create_default_context()
headers = {"User-Agent": "Mozilla/5.0 (compatible; overlap-analyzer/1.0)"}

def load_urls_from_counts(path):
    urls = []
    if not os.path.exists(path):
        raise FileNotFoundError(path)
    with open(path, encoding='utf-8') as f:
        # skip header
        next(f)
        for line in f:
            parts = line.strip().split(',')
            if parts:
                urls.append(parts[0])
    return urls

def fetch_text(url):
    req = urllib.request.Request(url, headers=headers)
    with urllib.request.urlopen(req, timeout=60, context=ssl_ctx) as r:
        data = r.read()
        try:
            return data.decode('utf-8')
        except Exception:
            return data.decode('utf-8', errors='replace')

def normalize_line(line):
    s = line.strip()
    if not s:
        return None
    # comments / metadata
    if s.startswith('!') or s.startswith('#') or s.startswith('[') or s.startswith('//'):
        return None
    # hostfile lines like "127.0.0.1 example.com" or "0.0.0.0 example.com"
    parts = s.split()
    if parts and (parts[0].startswith('127.') or parts[0].startswith('0.0.0.0')) and len(parts) >= 2:
        host = parts[1].lower()
        return host
    # plain domain-like lines (no special adblock chars)
    special = set('^*|$#@+=/[](),:')
    if not any((c in special) for c in s):
        return s.lower()
    # adblock-style rules: strip leading/trailing whitespace and keep canonical form
    return s

def process_url(url):
    print(f"Fetching: {url}")
    text = fetch_text(url)
    lines = text.splitlines()
    normalized = []
    for ln in lines:
        n = normalize_line(ln)
        if n:
            normalized.append(n)
    return normalized

def main():
    urls = load_urls_from_counts(CSV_IN)
    per_list_sets = {}
    stats = {}

    # fetch and normalize
    for url in urls:
        try:
            norms = process_url(url)
        except Exception as e:
            print(f"ERROR fetching {url}: {e}")
            norms = []
        s = set(norms)
        per_list_sets[url] = s
        stats[url] = {'non_comment': len(norms)}

    # compute union and unique contributions
    all_union = set().union(*per_list_sets.values()) if per_list_sets else set()
    per_url_unique = {}
    for url, s in per_list_sets.items():
        others_union = set().union(*(v for k,v in per_list_sets.items() if k != url)) if len(per_list_sets) > 1 else set()
        unique = s - others_union
        per_url_unique[url] = len(unique)

    # write CSV
    with open(CSV_OUT, 'w', newline='', encoding='utf-8') as csvf:
        w = csv.writer(csvf)
        w.writerow(['url','non_comment_lines','unique_contribution','percent_unique','timestamp'])
        for url in urls:
            nonc = stats.get(url, {}).get('non_comment', 0)
            uniq = per_url_unique.get(url, 0)
            pct = (uniq / nonc * 100.0) if nonc else 0.0
            w.writerow([url, nonc, uniq, f"{pct:.2f}", datetime.utcnow().isoformat() + 'Z'])

    # summary print
    total_unique = len(all_union)
    print('\nOverlap analysis complete')
    print(f"Combined unique normalized entries: {total_unique}")
    # top contributors by unique count
    ranked = sorted(per_url_unique.items(), key=lambda kv: kv[1], reverse=True)
    print('\nTop unique contributors:')
    for url, uniq in ranked[:10]:
        nonc = stats[url]['non_comment']
        print(f"- {url}: {uniq} unique of {nonc} ({uniq/nonc*100:.2f}% unique)")
    print(f"\nWrote overlap CSV: {CSV_OUT}")

if __name__ == '__main__':
    main()
