/// user-tweet-video.js
// Shows the video or photos inside a Twitter/X embed that never loaded (blocked, or held back behind a
// cookie-consent wall), without loading anything from x.com or twitter.com.
// The media list comes from FxTwitter's API (api.fxtwitter.com), the files from X's own file servers
// (video.twimg.com, pbs.twimg.com): plain files, no X scripts, cookies or login.
// Use: thepoke.com##+js(user-tweet-video.js)
(function() {
	'use strict';
	const done = new WeakSet();
	const style = 'display:block;max-width:100%;max-height:80vh;margin:.6em 0;border-radius:8px;background:#000';

	// X's file servers answer 403 when the referrer is another site, so this page sends none.
	// Only added once a tweet is actually found, so pages without tweets are untouched.
	const noReferrer = function() {
		if (document.querySelector('meta[name="referrer"][content="no-referrer"]')) {
			return;
		}
		const meta = document.createElement('meta');
		meta.name = 'referrer';
		meta.content = 'no-referrer';
		(document.head || document.documentElement).appendChild(meta);
	};

	const convert = function(bq) {
		if (done.has(bq)) {
			return;
		}
		done.add(bq);
		// The status link is the date link at the end of the quote. The t.co links are the tweet's own.
		let id = '';
		for (const a of bq.querySelectorAll('a[href]')) {
			const m = a.href.match(/(?:twitter|x)\.com\/[^/]+\/status(?:es)?\/(\d+)/);
			if (m) {
				id = m[1];
			}
		}
		if (id === '') {
			return;
		}
		noReferrer();
		fetch('https://api.fxtwitter.com/status/' + id, { credentials: 'omit' })
			.then(function(r) { return r.ok ? r.json() : null; })
			.then(function(d) {
				const media = d && d.tweet && d.tweet.media;
				if (!media) {
					return;
				}
				const box = document.createElement('div');
				for (const v of media.videos || []) {
					const el = document.createElement('video');
					el.controls = true;
					el.playsInline = true;
					// "none" so a page of tweets does not download every video up front.
					el.preload = 'none';
					el.src = v.url;
					if (v.thumbnail_url) {
						el.poster = v.thumbnail_url;
					}
					el.style.cssText = style;
					box.appendChild(el);
				}
				for (const p of media.photos || []) {
					const el = document.createElement('img');
					el.src = p.url;
					el.loading = 'lazy';
					el.alt = '';
					el.style.cssText = style;
					box.appendChild(el);
				}
				if (box.firstChild) {
					bq.appendChild(box);
				}
			})
			.catch(function() {});
	};

	const scan = function(root) {
		if (root.matches && root.matches('blockquote.twitter-tweet')) {
			convert(root);
		} else if (root.querySelectorAll) {
			root.querySelectorAll('blockquote.twitter-tweet').forEach(convert);
		}
	};

	const start = function() {
		scan(document);
		// Sites that load more articles as you scroll add new quotes later.
		new MutationObserver(function(list) {
			for (const m of list) {
				m.addedNodes.forEach(scan);
			}
		}).observe(document.documentElement, { childList: true, subtree: true });
	};

	if (document.readyState === 'loading') {
		document.addEventListener('DOMContentLoaded', start, { once: true });
	} else {
		start();
	}
})();
