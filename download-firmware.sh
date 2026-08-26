#!/usr/bin/env bash
set -euo pipefail

DEST="$(cd "$(dirname "$0")" && pwd)/firmware"

RUN_ID=$(gh run list --workflow "Build ZMK firmware" --limit 1 --json databaseId --jq '.[0].databaseId')

if [ -z "$RUN_ID" ]; then
    echo "No run found" >&2
    exit 1
fi

echo "Watching run $RUN_ID"
gh run watch "$RUN_ID" --exit-status

rm -rf "$DEST"
mkdir -p "$DEST"

echo "Downloading firmware from run $RUN_ID"
gh run download "$RUN_ID" -n firmware -D "$DEST"
ls "$DEST"
