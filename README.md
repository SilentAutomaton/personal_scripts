[Русская версия](README.ru.md)

# personal_scripts

Eleven commands for an Arch Linux desktop. They are reworked versions of
personal one-off scripts written over four years, the ones that passed a
personal filter of minimal usefulness. Most of them wrap ffmpeg, fzf, pacman,
unbound or ssh.

## Install

```
mkdir -p ~/.config/usefull_scripts
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
| `rec` | record the screen with the system sound and the microphone, or the microphone alone, on X11 and Wayland |
| `dr` | drag files out of the terminal, matching partial names |
| `relink` | replace every symlink under a directory with a hard link |
| `archfix` | Arch upkeep: `cache`, `kernel`, `reinstall`, `time`, `clamav` |
| `nvidia` | driver packages: `install`, `remove`, `downgrade`, `reload`, `xtoggle` |
| `netcheck` | public IP, country, ASN, resolvers, and `-l` for a DNS leak test |
| `pcap` | capture on a remote host over ssh, straight into wireshark |
| `focus` | block distracting domains in unbound and kill distracting programs |
| `whisper` | transcribe into `.srt` and `.txt` with whisper.cpp, or faster-whisper with `-c` |

## Tests

```
./test.sh
```

`vendor/dnsleaktest` is taken unchanged from
[macvk/dnsleaktest](https://github.com/macvk/dnsleaktest) (MIT).

## License

MIT
