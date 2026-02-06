# fz

Minimal CLI for [Fizzy](https://fizzy.do), the kanban tool by 37signals.

## Project Structure

```
fz/
├── fz           # Single bash script (~1600 lines)
├── Makefile     # install, uninstall, release
├── README.md    # User documentation
└── LICENSE      # MIT
```

## Development

```bash
make install     # Install to /usr/local/bin
make uninstall   # Remove from /usr/local/bin
make release     # Bump minor version, tag, push, update homebrew tap
```

Test locally without installing:
```bash
./fz help
./fz boards
```

## Architecture

**Single bash script** - No compilation, no dependencies beyond `jq`, `curl`, `bash 4+`.

**Config hierarchy:**
1. `.fz/config.json` (repo-specific, searches parent dirs like git)
2. `~/.config/fz/auth` (global token)
3. `~/.config/fz/config.json` (global account/url)

**API calls:**
- `api_get`, `api_post`, `api_put`, `api_delete` helpers
- All check auth token, handle errors, return JSON
- `get_auth_token`, `get_base_url`, `get_account`, `get_board` for config lookup

**Fuzzy matching:**
- Board/column/user names resolved via `resolve_*_alias` functions
- Check aliases first, then exact match, then case-insensitive partial match

**Output colors** (respect `NO_COLOR`):
- Use `printf` not `echo` for ANSI codes
- Card numbers: green
- Titles: bright
- Column names: bold blue
- Tags: dim
- Board names (when shown): dim

## Command Patterns

- Primary short names: `mv`, `col`, `mb`, `nn`
- Longer names as aliases: `move`, `column`, `maybe`, `notnow`
- Toggle semantics for `assign` and `tag`
- Stdin support for `add` and `comment`

## Adding New Commands

1. Add function `cmd_foo()`
2. Add to dispatch in `main()` case statement
3. Add to `RESERVED_WORDS` if it shouldn't be a filter name
4. Update `cmd_help()` text

## Release Process

```bash
make release
```

This bumps `v0.x.0` → `v0.x+1.0`, tags, pushes, and updates the homebrew formula at `~/dev/homebrew-tap/Formula/fz.rb`.
