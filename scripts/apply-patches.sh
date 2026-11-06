#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
upstream="${1:-$repo_root/../camunda-bpm-platform}"

if [[ ! -d "$upstream/.git" ]]; then
  echo "Cloning Camunda BPM Platform into $upstream"
  git clone https://github.com/camunda/camunda-bpm-platform.git "$upstream"
  git -C "$upstream" checkout 7.24.0
fi

if [[ "$(git -C "$upstream" describe --tags --exact-match 2>/dev/null || true)" != "7.24.0" ]]; then
  echo "Warning: $upstream is not checked out at tag 7.24.0."
  echo "Expected upstream commit 43f5c7f41c46af2e2b7e35ed85290b117400b939."
fi

for patch in "$repo_root"/patches/*.patch; do
  echo "Applying $(basename "$patch")"
  git -C "$upstream" apply --check "$patch"
  git -C "$upstream" apply "$patch"
done

echo
echo "Patches applied. Build and install the patched artifacts with:"
echo "  cd \"$upstream\" && ./mvnw -DskipTests install"
