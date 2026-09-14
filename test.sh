#!/bin/bash
# One check per non-trivial decision. Run it from the repository root.
set -uo pipefail

cd "$(dirname "$(readlink -f "$0")")"
failures=0

check() {
  if [ "$2" = "$3" ]; then
    echo "ok   $1"
  else
    echo "FAIL $1: expected '$3', got '$2'"
    failures=$((failures + 1))
  fi
}

work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT

export USEFULL_SCRIPTS_CONFIG="$work/config.env"
cat > "$USEFULL_SCRIPTS_CONFIG" <<EOF
FOCUS_DOMAINS="blocked.example other.example"
FOCUS_PROGRAMS="nothing-runs-by-this-name"
FOCUS_BLACKLIST="$work/blacklist.conf"
EOF

if command -v shellcheck >/dev/null; then
  if shellcheck -x bin/* lib/common.sh test.sh; then
    echo "ok   shellcheck"
  else
    echo "FAIL shellcheck"
    failures=$((failures + 1))
  fi
else
  echo "skip shellcheck (not installed)"
fi

# relink: a link that can be hard linked becomes one file with two names.
mkdir -p "$work/tree/sub"
echo payload > "$work/tree/target"
ln -s ../target "$work/tree/sub/link"
./bin/relink "$work/tree" >/dev/null
check "relink converts" "$(stat -c %h "$work/tree/target")" "2"
check "relink keeps content" "$(cat "$work/tree/sub/link")" "payload"

# relink: a link whose target cannot be hard linked must survive untouched.
ln -s /proc/self/status "$work/tree/unlinkable"
./bin/relink "$work/tree" >/dev/null 2>&1
check "relink keeps what it cannot convert" "$([ -L "$work/tree/unlinkable" ] && echo yes)" "yes"

# relink -n changes nothing.
ln -s ../target "$work/tree/sub/dry"
./bin/relink -n "$work/tree" >/dev/null
check "relink -n is a dry run" "$([ -L "$work/tree/sub/dry" ] && echo yes)" "yes"

# extract: both archive shapes land the same file.
mkdir -p "$work/arch"
echo content > "$work/arch/file.txt"
(cd "$work/arch" && tar czf ../sample.tar.gz file.txt && zip -q ../sample.zip file.txt)
./bin/extract -d "$work/out-tar" "$work/sample.tar.gz" >/dev/null
./bin/extract -d "$work/out-zip" "$work/sample.zip" >/dev/null
check "extract tar.gz" "$(cat "$work/out-tar/file.txt" 2>/dev/null)" "content"
check "extract zip" "$(cat "$work/out-zip/file.txt" 2>/dev/null)" "content"

# vidconv: the 720p preset converts what is too large and skips what is not.
if command -v ffmpeg >/dev/null; then
  ffmpeg -loglevel quiet -y -f lavfi -i testsrc=size=1920x1080:duration=1 "$work/big.mp4"
  ffmpeg -loglevel quiet -y -f lavfi -i testsrc=size=640x480:duration=1 "$work/small.mp4"
  check "vidconv converts 1080p" \
    "$(./bin/vidconv -n 720p "$work/big.mp4" | head -1 | cut -d: -f1)" "convert"
  check "vidconv skips 480p" \
    "$(./bin/vidconv -n 720p "$work/small.mp4" | head -1 | cut -d: -f1)" "skip"
  check "vidconv to mkv" \
    "$(./bin/vidconv -n to mkv "$work/small.mp4" | head -1 | cut -d: -f1)" "convert"
else
  echo "skip vidconv (ffmpeg not installed)"
fi

# focus: blocking and lifting leaves the blacklist as it was found.
printf 'local-zone: "keep.example" always_refuse\n' > "$work/blacklist.conf"
before=$(md5sum < "$work/blacklist.conf")
./bin/focus block >/dev/null
check "focus blocks" "$(grep -c always_refuse "$work/blacklist.conf")" "3"
./bin/focus block >/dev/null
check "focus blocks once" "$(grep -c always_refuse "$work/blacklist.conf")" "3"
./bin/focus unblock >/dev/null
check "focus restores" "$(md5sum < "$work/blacklist.conf")" "$before"
check "focus status" "$(./bin/focus status)" "focus is off"

echo
[ "$failures" -eq 0 ] && echo "all checks passed" || echo "$failures check(s) failed"
[ "$failures" -eq 0 ]
