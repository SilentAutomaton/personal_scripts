# Sourced by every command in bin/.

CONFIG_FILE="${USEFULL_SCRIPTS_CONFIG:-$HOME/.config/usefull_scripts/config.env}"
[ -r "$CONFIG_FILE" ] && . "$CONFIG_FILE"

die() {
  echo "$*" >&2
  exit 1
}

need_config() {
  local key
  for key in "$@"; do
    [ -n "${!key:-}" ] || die "Missing setting $key. It is not set in $CONFIG_FILE. Copy config.example.env there and fill in $key."
  done
}

need_command() {
  local cmd
  for cmd in "$@"; do
    command -v "$cmd" >/dev/null || die "$cmd is not installed. It is required here. Install it and run this again."
  done
}

session_type() {
  loginctl show-session "${XDG_SESSION_ID:-}" -p Type --value 2>/dev/null \
    || echo "${XDG_SESSION_TYPE:-unknown}"
}

clipboard() {
  case "$(session_type)" in
    wayland) wl-paste ;;
    x11) xclip -o ;;
    *) die "Cannot read the clipboard. The session is neither X11 nor Wayland. Pass the value as an argument instead." ;;
  esac
}

# Prints the chosen line, or fails when fzf is absent or nothing is picked.
pick() {
  command -v fzf >/dev/null || die "Nothing to choose from. No arguments were given and fzf is not installed. Pass the arguments explicitly."
  fzf --prompt="$1 > " --height=40% --reverse "${@:2}"
}

confirm() {
  local answer
  read -r -p "$* [y/N] " answer
  [ "$answer" = y ] || [ "$answer" = Y ]
}
