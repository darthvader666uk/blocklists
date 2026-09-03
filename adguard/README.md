# AdGuard Home filter lists

DNS-level blocking lists for AdGuard Home (and AdGuard DNS cloud).

| File | Purpose |
|---|---|
| `filterlist.txt` | Master cross-service list — trackers, ad networks, CDNs |
| `streaming/filterlist.streaming.*.txt` | Per-service streaming lists (13) |

Subscribe by raw URL:

```
https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/filterlist.txt
https://raw.githubusercontent.com/darthvader666uk/blocklists/main/adguard/streaming/filterlist.streaming.hbo.txt
```

## Conventions

- `!` starts a comment. Document **risk level** and **regional targeting** on
  anything non-obvious.
- Keep `filterlist.txt` and the per-service files in sync — a domain belongs in
  one or the other, not both.
- **Verify a domain before adding it.** Wildcard-optimised on purpose: AdGuard
  DNS (cloud) caps custom rules at 1,000, so this is not one-domain-per-line.
- AdGuard Home **does** support regex, whatever older comments in these files say.

Run `bash scripts/validate-filters.sh` from the repo root before committing.

Full documentation, per-service status and the change log live in the
[root README](../README.md).
