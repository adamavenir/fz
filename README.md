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

# Link a directory to a board
cd your-project
fz board --link myboard
```

Or use the interactive setup:

```bash
fz init
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

fz mv <card#> <column>     Triage into column
fz mb <card#>              Send to Maybe (aliases: maybe, triage)
fz nn <card#>              Send to Not Now (aliases: notnow, later)
fz close <card#>           Close card
fz open <card#>            Reopen card

fz comment <card#> [text]  Add comment (or pipe stdin)
fz assign <card#> <user>   Toggle assignment
fz tag <card#> <tag>       Toggle tag

fz whoami                  Show identity/accounts
fz boards                  List boards
fz cols [board]            List columns
fz users                   List users
```

## Aliases

Create shortcuts for boards, columns, and users:

```bash
fz board --alias f              # Alias current board as "f"
fz col --alias ip "In Progress"
fz user --alias k kevin

# Then use them
fz mv 42 ip
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

**Local** (per-project, searches parent dirs):
- `.fz/config.json` - account, board, token, url, aliases, filters, cached metadata

## Output

Cards grouped by column with colorized output:

```
     Triage
  76 Docs structure -- #docs #m
  75 RLM in mlld

     In Progress
  42 Some card -- #tag
```

When viewing multiple boards, shows `Column (Board)`:

```
     Triage (mlld)
  76 Docs structure

     Backlog (other-board)
  42 Some card
```

## Requirements

- `jq`
- `curl`
- `bash` 4+

## License

MIT
