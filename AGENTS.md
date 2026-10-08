# Working on usefull_scripts

Tier: 1

## What it is

Eleven shell commands for one Arch workstation: video transcoding,
archives, screen recording, driver and package upkeep, network
checks, and a focus blocker. They replace about thirty-five older one-off
scripts. Every machine-specific value lives in one config file, so the
repository itself is portable.

## Running it

```
ln -s "$PWD"/bin/* ~/.local/bin/
```

## Checking it

```
./test.sh
```

## Code

[`codestyle.md`](codestyle.md), the same standard at every
tier. `lib/common.sh` is the only shared module; a command imports it and
nothing else.

## Rules

1. A command never reads a machine-specific path, host or account from its own
   source. It comes from the config, through `need_config`, which fails saying
   which key is missing.
2. Nothing personal is committed. No keys, no home paths, no dumps. The
   repository ships `config.example.env` only.
3. A destructive command asks first: `confirm` before reinstalling packages,
   ending the session, or blocking DNS.
4. `sudo -A`, never bare `sudo`.
5. Borrowed code stays in `vendor/` with its original header.

## Commits

One step, one commit. A single line of plain English describing what the code
now does. No tool names, no attribution trailers.
