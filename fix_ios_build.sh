#!/bin/bash
set -e
echo ""
echo "════════════════════════════════════"
echo "  Flutter iOS Clean + Rebuild"
echo "════════════════════════════════════"
echo ""

if pgrep -x "Xcode" > /dev/null 2>&1; then
    echo "⚠ Close Xcode first, then press Enter."
    read -p ""
fi

echo "[1/6] flutter clean..."
flutter clean 2>&1 | tail -1

echo "[2/6] Removing Pods + build artifacts..."
rm -rf build/ ios/build/ ios/.symlinks ios/Pods ios/Podfile.lock

echo "[3/6] Clearing DerivedData + module cache..."
rm -rf ~/Library/Developer/Xcode/DerivedData/* 2>/dev/null || true
find ~/Library/Developer/Xcode -name "ModuleCache*" -type d -exec rm -rf {} + 2>/dev/null || true

echo "[4/6] flutter pub get..."
flutter pub get 2>&1 | tail -2

echo "[5/6] pod install..."
cd ios && pod install --repo-update 2>&1 | tail -5 && cd ..

echo "[6/6] Verifying GTMSessionFetcher fix..."
F="ios/Pods/Target Support Files/GTMSessionFetcher/GTMSessionFetcher.modulemap"
if [ -f "$F" ] && ! grep -q "module \*" "$F" && grep -q "umbrella" "$F"; then
    echo "  ✓ GTMSessionFetcher modulemap is flat (correct)"
else
    echo "  ✗ GTMSessionFetcher modulemap issue!"
fi

echo ""
echo "════════════════════════════════════"
echo "  Done! Run: flutter run"
echo "════════════════════════════════════"
