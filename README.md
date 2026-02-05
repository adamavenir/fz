# fz

A minimal CLI for [Fizzy](https://app.fizzy.do), the kanban tool by 37signals.

## Install

```bash
brew install adamavenir/tap/fz
```

Or clone and install:

```bash
git clone https://github.com/adamavenir/fz.git
cd fz
make install
```

## Setup

```bash
# Login with your personal access token (from Profile → Personal access tokens)
fz login

# Initialize a project directory
cd your-project
fz init
```

For repo-specific config (e.g., local dev server):

```bash
fz init --token=YOUR_TOKEN --url=http://fizzy.localhost:3006
```

## Usage

```
fz                         List cards (default filter or active)
fz <number>                Show card details
fz cards [options]         List cards with filters
  --board=NAME               Filter by board
  --tag=TAG                  Filter by tag
  --assignee=NAME            Filter by assignee (or "me", "none")
  --status=X                 triage|active|closed|notnow
  --search=TERMS             Full-text search

fz show <card#>            Display card with comments
fz add [board] <title>     Create card
  -d, --description          Inline description (or pipe stdin)

fz move <card#> <column>   Triage into column
fz mb <card#>              Send to Maybe (aliases: maybe, triage)
fz nn <card#>              Send to Not Now (aliases: notnow, later)
fz close <card#>           Close card
fz open <card#>            Reopen card

fz comment <card#> [text]  Add comment (or pipe stdin)
fz assign <card#> <user>   Toggle assignment
fz tag <card#> <tag>       Toggle tag

fz whoami                  Show identity/accounts
fz boards                  List boards
fz columns [board]         List columns
fz users                   List users
```

## Aliases

Create shortcuts for boards, columns, and users:

```bash
fz board --alias f              # Alias current board as "f"
fz column --alias ip "In Progress"
fz user --alias k kevin

# Then use them
fz move 42 ip
fz assign 42 k
```

## Saved Filters

Save common queries:

```bash
fz save mine --assignee=me --status=active
fz save backlog --status=triage
fz save bugs --tag=bug

# Run them
fz mine
fz backlog
```

## Config

**Global** (all projects):
- `~/.config/fz/auth` - token
- `~/.config/fz/config.json` - url override, default account

**Local** (per-project):
- `.fz/config.json` - account, board, token, url, aliases, filters, cached metadata

Config lookup order:
1. `.fz/config.json` (repo-specific)
2. `~/.config/fz/*` (global)
3. Default URL: `https://app.fizzy.do`

## Output

Cards are grouped by `Board: Column` with colorized output:

```
Fizzy: In Progress

   1 Title of card
     #tag #othertag

1002 This is the title of this card
     #sometag #mytag

- - - - - - - - - - - - - - - - - - - - - - - - - - - -

Fizzy: Triage

  42 New card in triage
```

## Requirements

- `jq`
- `curl`
- `bash` 4+

## License

MIT
