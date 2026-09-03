# Migration: Gist → repository

> ## ✅ COMPLETE — 3 September 2026
>
> Every step below has been carried out. This file is kept as the historical
> record of the cutover and the old → new URL mapping. **Nothing here still
> needs doing.** Current install URLs are in the [README](README.md); the dated
> write-up is in [CHANGELOG.md](CHANGELOG.md).

The remote was a **GitHub Gist**, which cannot hold directories. This repo is now
split into `adguard/`, `ublock/` and `plugblock/`, so the gist can no longer be
the publishing target.

**Chosen strategy: hard cutover.** New repo becomes the only source. The 14 live
subscription URLs must be updated by hand in AdGuard Home.

> ⚠️ **Do not push to the old gist remote after this restructure.** A push
> containing any directory is rejected. Re-point `origin` (step 2) before any
> push.

---

## Step 1 — Commit the restructure

Everything is staged. Review, then commit locally (nothing is pushed yet).

## Step 2 — Create the repo and re-point origin

```bash
gh repo create blocklists --public --description "AdGuard Home + uBlock Origin filter lists, and the plugblock appliance"
git remote set-url origin https://github.com/darthvader666uk/blocklists.git
git push -u origin main
```

If you want a different repo name, change it here **and** re-run the URL rewrite
in step 3 with the new name before pushing.

## Step 3 — Update AdGuard Home subscriptions

AdGuard Home → **Filters → DNS blocklists**. Each list keeps its name; only the
URL changes. AGH will not error loudly on a dead URL — it keeps serving the last
successful fetch and only logs a failure, so a missed entry goes stale silently.

| # | Old (gist) | New (repo) |
|---|---|---|
| 1 | `https://gist.githubusercontent.com/darthvader666uk/ccfdab18b9d59830876c373db8b4210d/raw/filterlist.txt` | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/filterlist.txt` |
| 2 | `https://gist.githubusercontent.com/darthvader666uk/ccfdab18b9d59830876c373db8b4210d/raw/filterlist.streaming.amazon.txt` | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.amazon.txt` |
| 3 | `https://gist.githubusercontent.com/darthvader666uk/ccfdab18b9d59830876c373db8b4210d/raw/filterlist.streaming.appletv.txt` | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.appletv.txt` |
| 4 | `https://gist.githubusercontent.com/darthvader666uk/ccfdab18b9d59830876c373db8b4210d/raw/filterlist.streaming.disney.txt` | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.disney.txt` |
| 5 | `https://gist.githubusercontent.com/darthvader666uk/ccfdab18b9d59830876c373db8b4210d/raw/filterlist.streaming.hbo.txt` | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.hbo.txt` |
| 6 | `https://gist.githubusercontent.com/darthvader666uk/ccfdab18b9d59830876c373db8b4210d/raw/filterlist.streaming.hulu.txt` | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.hulu.txt` |
| 7 | `https://gist.githubusercontent.com/darthvader666uk/ccfdab18b9d59830876c373db8b4210d/raw/filterlist.streaming.netflix.txt` | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.netflix.txt` |
| 8 | `https://gist.githubusercontent.com/darthvader666uk/ccfdab18b9d59830876c373db8b4210d/raw/filterlist.streaming.paramount.txt` | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.paramount.txt` |
| 9 | `https://gist.githubusercontent.com/darthvader666uk/ccfdab18b9d59830876c373db8b4210d/raw/filterlist.streaming.peacock.txt` | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.peacock.txt` |
| 10 | `https://gist.githubusercontent.com/darthvader666uk/ccfdab18b9d59830876c373db8b4210d/raw/filterlist.streaming.pluto.txt` | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.pluto.txt` |
| 11 | `https://gist.githubusercontent.com/darthvader666uk/ccfdab18b9d59830876c373db8b4210d/raw/filterlist.streaming.roku.txt` | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.roku.txt` |
| 12 | `https://gist.githubusercontent.com/darthvader666uk/ccfdab18b9d59830876c373db8b4210d/raw/filterlist.streaming.skyglass.txt` | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.skyglass.txt` |
| 13 | `https://gist.githubusercontent.com/darthvader666uk/ccfdab18b9d59830876c373db8b4210d/raw/filterlist.streaming.tubi.txt` | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.tubi.txt` |
| 14 | `https://gist.githubusercontent.com/darthvader666uk/ccfdab18b9d59830876c373db8b4210d/raw/filterlist.streaming.ukcatchup.txt` | `https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.ukcatchup.txt` |

**Verify afterwards** — every list should show a fresh "last updated" and a
non-zero rule count:

```bash
curl -sI https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/filterlist.txt | head -1
```

## Step 4 — Tombstone the gist

The gist stays alive as a frozen final snapshot so anyone else subscribed keeps
working (stale, but not 404). Clone it separately — it must stay flat:

```bash
git clone https://gist.github.com/ccfdab18b9d59830876c373db8b4210d.git /tmp/gist-tombstone
```

Then replace its `README.md` with a pointer to the new repo, and commit/push from
there.

**Recommended extra:** add a deprecation notice to each list still in the gist.
`!` is an ABP comment, so parsers ignore it, but anyone reading the list sees it.

> ⚠️ The notice must go **after** line 1. Every list starts with `[Adblock Plus]`,
> and that header has to stay first or parsers may not recognise the format — so
> insert at line 2 rather than prepending. (The original version of this snippet
> used `cat - "$f"`, which displaced the header. Fixed here.)

```bash
cd /tmp/gist-tombstone && for f in filterlist*.txt; do
  sed -i '1a ! MOVED: https://github.com/darthvader666uk/blocklists — this copy is frozen and no longer updated.' "$f"
done
```

Note this globs `filterlist*.txt` only. `ublock-filters-lite.txt` also wants the
notice; `ublock-main.txt` is JSON and cannot carry a comment, so the gist README
warns about it instead.

## Step 5 — Local cleanup

- `push-to-gist.sh` / `push-to-gist.bat` (gitignored, local only) are now
  obsolete — delete or repoint them.
- `/home/deathstar/plugblock/` is now duplicated inside this repo at
  `plugblock/`. Remove the original once you've confirmed the copy is complete.
- Update the **gist** section of `~/.claude/CLAUDE.md`: the repo is no longer
  flat, `scripts/validate-filters.sh` now genuinely exists, and the "gists are
  flat" constraint no longer applies.

## What changed in the repo

- 16 filter files moved into `adguard/` and `ublock/` — **filenames unchanged**,
  moved with `git mv` so history follows.
- `plugblock/` added as a third top-level area.
- `scripts/validate-filters.sh` restored from `archive/` (it could never be
  tracked in a flat gist), updated for the new paths, and extended to JSON-check
  `ublock/ublock-main.txt`.
- `.github/workflows/validate.yml` runs the validator on every push touching the
  lists.
- Root `README.md`: all 14 subscription URLs rewritten, File Structure section
  replaced with the repo layout.
