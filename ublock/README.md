# uBlock Origin

| File | Purpose | Format |
|---|---|---|
| `ublock-main.txt` | Full uBlock Origin backup — settings, enabled lists, userFilters | **JSON** |
| `ublock-filters-lite.txt` | MV3-compatible subset (53 rules) for uBlock Origin Lite | ABP syntax |

`ublock-main.txt` is a settings *backup*, not a subscribable filter list —
restore it via uBlock Origin → Settings → Restore from file. The validator
JSON-checks it rather than parsing it as filters.

`ublock-filters-lite.txt` drops everything MV3 can't do: no scriptlet injection
(`##+js()`), no `:style()`, no `:has()` / `:has-text()` / `:matches-attr()` /
`:upward()` / `:if()`.

Full documentation lives in the [root README](../README.md).
