# Neovim config

Personal Neovim 0.12 config using native `vim.pack`, `vim.lsp.enable()`, Snacks, Conform, and a small set of focused plugins.

## Environment variables

This config uses Mason for installing LSPs, linters, DAP adapters, and other tools.

Mason will automatically install them unless `NEOVIM_MASON_AUTO_INSTALL` is set to `false`.

It also supports an HTTP proxy URL to be set via the `NEOVIM_HTTP_PROXY` environment variable. This allows the same config to be used on corporate machines that require an HTTP proxy for any web fetch requests, such as for fetching schemas for YAML LS and JSON LS.

## JS / TS: Biome vs ESLint vs Prettier

Decision tree used by [`lua/lsp/init.lua`](lua/lsp/init.lua), [`lsp/biome.lua`](lsp/biome.lua), [`lsp/eslint.lua`](lsp/eslint.lua), and [`lua/plugins/conform.lua`](lua/plugins/conform.lua):

```text
Open a JS/TS buffer
│
├─ biome.json or biome.jsonc in the project?
│  ├─ YES
│  │  ├─ Lint:     Biome LSP (eslint does not attach)
│  │  └─ Format:   Conform `biome-check` (format + safe fixes + import sort)
│  │
│  └─ NO
│     ├─ Lint:     ESLint LSP (only if an ESLint config exists)
│     └─ Format:
│        ├─ Prettier available? → Conform `prettier`
│        └─ Else                → LSP format from `tsc` or `vtsls`
│
└─ Types / navigation: always `tsc` (or `vtsls` if enabled)
```

### Summary

| Project setup            | Diagnostics | Format                                    |
| ------------------------ | ----------- | ----------------------------------------- |
| Biome                    | Biome LSP   | `biome-check`                             |
| ESLint + Prettier        | ESLint LSP  | Prettier                                  |
| ESLint, no Prettier      | ESLint LSP  | `tsc` / `vtsls`                           |
| Neither Biome nor ESLint | `tsc` only  | Prettier if present, else `tsc` / `vtsls` |

Neither Biome nor ESLint is used as a Conform/LSP **formatter** when the other path owns formatting: both servers have formatting capabilities disabled so Conform (or `tsc` fallback) is the single format path.

### Related filetypes

JSON / HTML / CSS use the same Biome-vs-Prettier split for **formatting** (`biome-check` vs `prettier`). YAML and Markdown stay Prettier-only.
