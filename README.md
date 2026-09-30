# usefull_scripts

Twelve commands consolidated out of four years of one-off scripts.

## Install

```
cp config.example.env ~/.config/usefull_scripts/config.env   # then edit it
ln -s "$PWD"/bin/* ~/.local/bin/
```

Every command prints its own help with `-h`. A command run with no arguments
where a choice exists opens fzf instead of failing.

## Commands

| Command | Does |
|---|---|
| `vidconv` | transcode video: `720p`, `tg` for messengers, `to EXT` for the container |
| `extract` | extract any archive into the working directory or `-d DIR` |
| `rec` | record the screen with sound, or the microphone, on X11 and Wayland |
| `dr` | drag files out of the terminal, matching partial names |
| `relink` | replace every symlink under a directory with a hard link |
| `archfix` | Arch upkeep: `cache`, `kernel`, `reinstall`, `time`, `clamav` |
| `nvidia` | driver packages: `install`, `remove`, `downgrade`, `reload`, `xtoggle` |
| `check_iommu` | list the IOMMU groups and the devices in them |
| `netcheck` | public IP, country, ASN, resolvers, and `-l` for a DNS leak test |
| `novpn` | run a browser as a second user whose traffic bypasses the VPN |
| `pcap` | capture on a remote host over ssh, straight into wireshark |
| `focus` | block distracting domains in unbound and kill distracting programs |
| `whisper` | transcribe into `.srt` and `.txt` with whisper.cpp, or faster-whisper with `-c` |

## Checking it

```
./test.sh
```

## What was left behind

`~/scree` keeps the launcher wrappers (`sd`, `rvc`, `xc`, `ttm`, `java*`, …),
which are three-line paths into `~/docs` on one machine, and the dead scripts:
`parse_films` does not parse, `film_random` uses a Selenium API that was
removed, `gitint` writes two files into the working directory.

`bak/claim_games` is not here on purpose. It holds a plaintext password and a
TOTP seed.
