[English version](README.md)

# personal_scripts

Одиннадцать команд для десктопа на Arch Linux. Это переработанные версии
личных одноразовых скриптов, написанных за четыре года: те, что прошли личный
фильтр минимальной полезности. Большинство из них обёртки над ffmpeg, fzf,
pacman, unbound или ssh.

## Установка

```
mkdir -p ~/.config/usefull_scripts
cp config.example.env ~/.config/usefull_scripts/config.env   # потом отредактируйте
ln -s "$PWD"/bin/* ~/.local/bin/
```

Каждая команда печатает свою справку по `-h`. Если команде без аргументов есть
из чего выбирать, она открывает fzf, а не падает с ошибкой.

## Команды

| Команда | Что делает |
|---|---|
| `vidconv` | перекодирует видео: `720p`, `tg` для мессенджеров, `to EXT` для смены контейнера |
| `extract` | распаковывает любой архив в рабочий каталог или в `-d DIR` |
| `rec` | записывает экран со звуком или микрофон, на X11 и Wayland |
| `dr` | перетаскивает файлы из терминала, имена можно писать не полностью |
| `relink` | заменяет все симлинки в каталоге на жёсткие ссылки |
| `archfix` | обслуживание Arch: `cache`, `kernel`, `reinstall`, `time`, `clamav` |
| `nvidia` | пакеты драйвера: `install`, `remove`, `downgrade`, `reload`, `xtoggle` |
| `netcheck` | внешний IP, страна, ASN, DNS-серверы, а с `-l` проверка утечки DNS |
| `pcap` | захват трафика на удалённой машине по ssh сразу в wireshark |
| `focus` | блокирует отвлекающие домены в unbound и закрывает отвлекающие программы |
| `whisper` | расшифровка в `.srt` и `.txt` через whisper.cpp, а с `-c` через faster-whisper |

## Тесты

```
./test.sh
```

`vendor/dnsleaktest` взят без изменений из
[macvk/dnsleaktest](https://github.com/macvk/dnsleaktest) (MIT).

## Лицензия

MIT
