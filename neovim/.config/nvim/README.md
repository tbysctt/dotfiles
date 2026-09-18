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
│        └─ Else                → TypeScript Language Server
│
└─ Types / navigation: TypeScript Language Server (see below)
```

### Summary

| Project setup            | Diagnostics                 | Format                                      |
| ------------------------ | --------------------------- | ------------------------------------------- |
| Biome                    | Biome LSP                   | `biome-check`                               |
| ESLint + Prettier        | ESLint LSP                  | Prettier                                    |
| ESLint, no Prettier      | ESLint LSP                  | TypeScript Language Server                  |
| Neither Biome nor ESLint | TypeScript Language Server  | Prettier if present, else TypeScript LSP    |

Neither Biome nor ESLint is used as a Conform/LSP **formatter** when the other path owns formatting: both servers have formatting capabilities disabled so Conform (or the TypeScript Language Server as fallback) is the single format path.

### Related filetypes

JSON / HTML / CSS use the same Biome-vs-Prettier split for **formatting** (`biome-check` vs `prettier`). YAML and Markdown stay Prettier-only.

### Which TypeScript Language Server (for now)

TypeScript 7 ships a native LSP (`tsc --lsp`). This config still uses **vtsls** (the VS Code TypeScript server wrapper) for JS/TS types, navigation, and format fallback.

Reason: project-wide diagnostics use [`workspace-diagnostics.nvim`](https://github.com/artemave/workspace-diagnostics.nvim), which opens workspace files via fake `textDocument/didOpen` and relies on **push** diagnostics (`publishDiagnostics`). That works with vtsls and servers like Tailwind.

The native TypeScript LSP is **pull-diagnostics only** and does not yet expose usable `workspace/diagnostic` pull for the whole project. With it, errors in files you have not opened never show up in `<leader>sd` / workspace diagnostic lists.

Keep [`lsp/tsc.lua`](lsp/tsc.lua) around and switch `enabled_servers` back to the native LSP once upstream workspace pull diagnostics work with Neovim.
