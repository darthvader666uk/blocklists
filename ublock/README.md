# uBlock Origin

| File | Purpose | Format |
|---|---|---|
| `ublock-main.txt` | Full uBlock Origin backup — settings, enabled lists, userFilters | **JSON** |
| `ublock-filters-lite.txt` | **Deprecated** — MV3-compatible subset for uBlock Origin Lite | ABP syntax |

`ublock-main.txt` is a settings *backup*, not a subscribable filter list —
restore it via uBlock Origin → Settings → Restore from file. The validator
JSON-checks it rather than parsing it as filters.

`ublock-filters-lite.txt` is **deprecated as of 2026-09-03** and frozen — the
maintainer moved back to full uBlock Origin on Firefox. It stays published so
existing subscribers do not get a 404, but it receives no new rules and no
breakage fixes. Use `ublock-main.txt` / the AdGuard lists instead.

It drops everything MV3 can't do: no scriptlet injection (`##+js()`), no
`:style()`, no `:has()` / `:has-text()` / `:matches-attr()` / `:upward()` /
`:if()`.

Full documentation lives in the [root README](../README.md).
