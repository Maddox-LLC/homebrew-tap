#!/usr/bin/env bash
# Issue #560 PR6 — checksum-verified installer for the `maddox` CLI.
#
#   curl -fsSL https://maddoxapi.dev/install.sh | sh
#   # or pin a version / dir:
#   MADDOX_VERSION=cli-v0.1.0 ./install-maddox.sh --dir ~/.local/bin
#
# Env overrides:
#   MADDOX_VERSION        release tag (default: latest)
#   MADDOX_DOWNLOAD_BASE  base URL for assets (default: GitHub releases) — lets
#                         the local test harness point at a file:// or http dir
set -euo pipefail

# Distribution home: the public tap repo hosts the release binaries + SHA256SUMS
# (the MaddoxAPI monorepo is private, so its release assets aren't public-fetchable).
REPO="Maddox-LLC/homebrew-maddox"
VERSION="${MADDOX_VERSION:-latest}"
DIR="${HOME}/.local/bin"

while [ $# -gt 0 ]; do
  case "$1" in
    --dir) DIR="$2"; shift 2 ;;
    --dir=*) DIR="${1#*=}"; shift ;;
    *) echo "maddox-install: unknown argument '$1'" >&2; exit 1 ;;
  esac
done

die() { echo "maddox-install: $*" >&2; exit 1; }

# ── resolve the target triple from this host ─────────────────────────────────
os="$(uname -s)"
arch="$(uname -m)"
case "$arch" in
  x86_64 | amd64) arch="x86_64" ;;
  aarch64 | arm64) arch="aarch64" ;;
  *) die "unsupported architecture: $arch" ;;
esac
case "$os" in
  Darwin) target="${arch}-apple-darwin"; ext="" ;;
  Linux) target="${arch}-unknown-linux-musl"; ext="" ;;
  *) die "unsupported OS: $os (Windows: download the .exe from the Releases page)" ;;
esac
asset="maddox-${target}${ext}"

# ── download asset + checksums into a temp dir ───────────────────────────────
if [ -n "${MADDOX_DOWNLOAD_BASE:-}" ]; then
  base="$MADDOX_DOWNLOAD_BASE"
elif [ "$VERSION" = "latest" ]; then
  base="https://github.com/${REPO}/releases/latest/download"
else
  base="https://github.com/${REPO}/releases/download/${VERSION}"
fi

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

echo "maddox-install: fetching ${asset} (${VERSION})" >&2
fetch() { curl -fsSL "$1" -o "$2" || die "download failed: $1"; }
fetch "${base}/${asset}" "${tmp}/${asset}"
fetch "${base}/SHA256SUMS" "${tmp}/SHA256SUMS"

# ── verify checksum: compare the asset's computed sha to the EXPECTED one for
# this asset. An explicit equality check (not `shasum -c`) avoids the trap where
# a malformed/short checksum line is silently treated as "improperly formatted"
# and the tool still exits 0.
expected="$(awk -v a="$asset" '$2 == a { print $1 }' "${tmp}/SHA256SUMS")"
[ -n "$expected" ] || die "no checksum for ${asset} in SHA256SUMS"
if command -v sha256sum >/dev/null 2>&1; then
  actual="$(sha256sum "${tmp}/${asset}" | awk '{ print $1 }')"
else
  actual="$(shasum -a 256 "${tmp}/${asset}" | awk '{ print $1 }')"
fi
if [ "$actual" != "$expected" ]; then
  rm -f "${tmp:?}/${asset}"
  die "checksum verification FAILED for ${asset} — aborting (nothing installed)"
fi

# ── install ──────────────────────────────────────────────────────────────────
mkdir -p "$DIR"
install -m 0755 "${tmp}/${asset}" "${DIR}/maddox"
echo "maddox-install: installed maddox → ${DIR}/maddox" >&2

# ── PATH warning ─────────────────────────────────────────────────────────────
case ":${PATH}:" in
  *":${DIR}:"*) : ;;
  *)
    echo "" >&2
    echo "maddox-install: ${DIR} is not on your PATH. Add it:" >&2
    echo "    export PATH=\"${DIR}:\$PATH\"" >&2
    echo "  (append to your ~/.zshrc or ~/.bashrc to persist)" >&2
    ;;
esac
