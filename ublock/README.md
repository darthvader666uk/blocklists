# uBlock Origin

| File | Purpose | Format |
|---|---|---|
| `ublock-main.txt` | Full uBlock Origin backup — settings, enabled lists, userFilters | **JSON** |
| `user-scriptlets.js` | Custom scriptlets, loaded via the `userResourcesLocation` advanced setting. `user-tweet-video.js` shows the video or photos in a Twitter/X embed that never loaded, via FxTwitter, nothing from x.com | uBO resources |
| `ublock-filters-lite.txt` | **Deprecated** — MV3-compatible subset for uBlock Origin Lite | ABP syntax |

`ublock-main.txt` is a settings *backup*, not a subscribable filter list —
restore it via uBlock Origin → Settings → Restore from file. The validator
JSON-checks it rather than parsing it as filters.

The **Trusted sites** list is stripped from the published copy (only uBlock's
built-in `-scheme` defaults remain), because it names personal accounts. The
full backup is kept locally as `my-ublock-backup_*.txt`, which is gitignored.

`ublock-filters-lite.txt` is **deprecated as of 2026-09-03** and frozen — the
maintainer moved back to full uBlock Origin on Firefox. It stays published so
existing subscribers do not get a 404, but it receives no new rules and no
breakage fixes. Use `ublock-main.txt` / the AdGuard lists instead.

It drops everything MV3 can't do: no scriptlet injection (`##+js()`), no
`:style()`, no `:has()` / `:has-text()` / `:matches-attr()` / `:upward()` /
`:if()`.

## Tweet videos without X (`user-tweet-video.js`)

This one came out of a news site where every embedded tweet showed up as a plain quote, no video. Some sites (The Poke is the one I hit) only load Twitter's embed script once you agree to personalised ads in their cookie pop-up. With uBlock's cookie lists on you never see the pop-up, so you never agree, and the tweets never load.

SO this is how it works:

1. It finds each tweet quote on the page (`blockquote.twitter-tweet`) and takes the tweet ID from its date link
2. It asks [FxTwitter](https://github.com/FixTweet/FxTwitter)'s API (`api.fxtwitter.com`) what video or photos the tweet has
3. It adds them under the quote, a video player for clips and the images for photos

Nothing loads from x.com or twitter.com. The files themselves come from X's file servers (`video.twimg.com`, `pbs.twimg.com`), as plain files with no X scripts, cookies or login.

You need full uBlock Origin (Firefox is what I use). uBlock Origin Lite cant load custom scriptlets.

### Setting it up:

1. In uBlock's dashboard go to Settings and tick I am an advanced user, then press the cogs icon next to it
2. Find `userResourcesLocation` and set it to:
   ```
   https://raw.githubusercontent.com/darthvader666uk/blocklists/main/ublock/user-scriptlets.js
   ```
   then press Apply changes
3. In My filters, add one line per site you want it on, then press Apply changes:
   ```
   thepoke.com##+js(user-tweet-video.js)
   ```
4. In Filter lists, click the clock icon next to any list (EasyList is fine) so it shows as out of date, then press Update now. uBlock only fetches the scriptlet file when a list updates, and newer versions dropped the Purge all caches button
5. Reload the page. The video should be sitting under the tweet quote

### Adding more sites:

Put them in front of the same line, comma separated:

```
thepoke.com,example.co.uk##+js(user-tweet-video.js)
```

Or put a `*` in front to run it on every site. A line with nothing in front gets ignored by uBlock:

```
*##+js(user-tweet-video.js)
```

### Good to know:

- Videos only start downloading when you press play, so a page with 10 tweets doesnt pull 10 videos
- X's file servers refuse requests that say they came from another site (a 403), so each video plays in its own small frame that doesn't send the page's address. The page itself is left alone, so logins and comment forms on it work as normal
- FxTwitter sees the IDs of the tweets you load, and X's file servers see you download the file. That's the trade-off for not loading X itself
- If the site's own Twitter embed DOES load (you accepted the pop-up), Twitter's script replaces the quote and this does nothing

### If it doesnt work:

- Nothing at all → check `userResourcesLocation` saved, then force an update again (step 4). GitHub can take about 5 minutes to serve a new version of the file
- Quote shows but no video → open the uBlock logger on that tab and look for `api.fxtwitter.com`. If FxTwitter is down or has changed, nothing gets added
- The site doesnt use the standard `twitter-tweet` quote → it wont be picked up, open an issue with the page link

It runs code on the pages you pick, so have a read of [`user-scriptlets.js`](user-scriptlets.js) first (it's about 100 lines). If you'd rather not depend on my copy, fork the repo and point `userResourcesLocation` at your own.

Full documentation lives in the [root README](../README.md).
