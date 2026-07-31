#!/usr/bin/env bash
set -euo pipefail

APP_DIR="mayu_flutter_source"
FLUTTER_DIR="/tmp/flutter"

rm -rf "$APP_DIR" public
mkdir -p "$APP_DIR" public

unzip -q mayu_flutter_source.zip -d "$APP_DIR"

if [ ! -x "$FLUTTER_DIR/bin/flutter" ]; then
  git clone https://github.com/flutter/flutter.git -b stable --depth 1 "$FLUTTER_DIR"
fi

export PATH="$FLUTTER_DIR/bin:$PATH"

flutter config --enable-web
cd "$APP_DIR"
flutter pub get
flutter build web --release
cp -R build/web/. ../public/
