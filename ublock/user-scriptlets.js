/// user-tweet-video.js
// Shows the video or photos inside a Twitter/X embed that never loaded (blocked, or held back behind a
// cookie-consent wall), without loading anything from x.com or twitter.com.
// The media list comes from FxTwitter's API (api.fxtwitter.com), the files from X's own file servers
// (video.twimg.com, pbs.twimg.com): plain files, no X scripts, cookies or login.
// Use: thepoke.com##+js(user-tweet-video.js) for one site, *##+js(user-tweet-video.js) for every site
// NO BLANK LINES inside a scriptlet: uBO's resource parser ends the resource at the first empty line.
(function() {
	'use strict';
	const done = new WeakSet();
	const style = 'display:block;max-width:100%;max-height:80vh;margin:.6em 0;border-radius:8px;background:#000';
	// X's file servers answer 403 when the referrer is another site. Each video sits in its own small frame
	// that sends no referrer, so the page's own referrer policy (and any form that relies on it) is untouched.
	const attr = function(s) {
		return String(s).replace(/&/g, '&amp;').replace(/"/g, '&quot;').replace(/</g, '&lt;');
	};
	const videoFrame = function(v) {
		const el = document.createElement('iframe');
		// No scripts run inside. Native video controls (and fullscreen) still work.
		el.setAttribute('sandbox', '');
		el.setAttribute('allowfullscreen', '');
		el.allow = 'fullscreen';
		el.referrerPolicy = 'no-referrer';
		// preload="none" so a page of tweets does not download every video up front.
		el.srcdoc = '<!doctype html><meta name="referrer" content="no-referrer">' +
			'<style>html,body{margin:0;height:100%;background:#000}video{width:100%;height:100%;object-fit:contain}</style>' +
			'<video controls playsinline preload="none" src="' + attr(v.url) + '"' +
			(v.thumbnail_url ? ' poster="' + attr(v.thumbnail_url) + '"' : '') + '></video>';
		el.style.cssText = style + ';width:100%;border:0;aspect-ratio:' +
			((v.width > 0 && v.height > 0) ? v.width + '/' + v.height : '16/9');
		return el;
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
		fetch('https://api.fxtwitter.com/status/' + id, { credentials: 'omit', referrerPolicy: 'no-referrer' })
			.then(function(r) { return r.ok ? r.json() : null; })
			.then(function(d) {
				const media = d && d.tweet && d.tweet.media;
				if (!media) {
					return;
				}
				const box = document.createElement('div');
				for (const v of media.videos || []) {
					box.appendChild(videoFrame(v));
				}
				for (const p of media.photos || []) {
					const el = document.createElement('img');
					el.referrerPolicy = 'no-referrer';
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
