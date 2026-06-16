#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

export PKG_CONFIG_PATH="/home/vega/Coding/GameDev/duduplayground/third_party/install/lib/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
/home/vega/Coding/GameDev/dudu/build/dudu run
