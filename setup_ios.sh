#!/usr/bin/env bash
#
# setup_ios.sh — เตรียมโปรเจกต์ munday ให้พร้อมรันบน iPhone (เครื่องจริง) และ Simulator
# เวอร์ชันนี้: ตรวจ + ซ่อม CocoaPods อัตโนมัติ (สำหรับเคส Xcode อัปเวอร์ชันแล้ว pod พัง)
#
# วิธีใช้:
#   cd /Users/munday/ProjectMunday/MundayGEN/munday
#   chmod +x setup_ios.sh
#   ./setup_ios.sh
#
# หมายเหตุ: ไม่ใช้ `set -e` เพื่อให้เห็น error ครบทุกขั้น ไม่ตัดจบเงียบๆ

BOLD="\033[1m"; GREEN="\033[32m"; YELLOW="\033[33m"; RED="\033[31m"; RESET="\033[0m"
step() { echo -e "\n${BOLD}==> $1${RESET}"; }
ok()   { echo -e "${GREEN}✓ $1${RESET}"; }
warn() { echo -e "${YELLOW}! $1${RESET}"; }
err()  { echo -e "${RED}✗ $1${RESET}"; }

[ -f pubspec.yaml ] || { err "ไม่พบ pubspec.yaml — cd เข้าโฟลเดอร์โปรเจกต์ munday ก่อน"; exit 1; }

# ---------------------------------------------------------------------------
step "1/6 ตรวจ toolchain (flutter / xcode / cocoapods)"
command -v flutter >/dev/null || { err "ไม่พบ flutter ใน PATH"; exit 1; }
command -v xcodebuild >/dev/null || { err "ไม่พบ Xcode"; exit 1; }
flutter --version | head -1
xcodebuild -version 2>/dev/null | head -1

# --- ตรวจ CocoaPods อย่างละเอียด (จุดที่สคริปต์เดิมค้าง) ---
POD_OK=0
if command -v pod >/dev/null; then
  if POD_VER="$(pod --version 2>/tmp/pod_err.txt)"; then
    echo "CocoaPods ${POD_VER}"
    POD_OK=1
  else
    err "pod ติดตั้งอยู่แต่รันไม่ผ่าน — error:"
    sed 's/^/    /' /tmp/pod_err.txt
  fi
else
  warn "ไม่พบคำสั่ง pod ใน PATH"
fi

# --- ซ่อม CocoaPods อัตโนมัติถ้าพัง ---
if [ "$POD_OK" -ne 1 ]; then
  step "1b/6 พยายามซ่อม CocoaPods อัตโนมัติ"

  # 1) รับ Xcode license (สาเหตุพบบ่อยหลังอัป Xcode)
  warn "รับ Xcode license (อาจถามรหัสผ่าน sudo)"
  sudo xcodebuild -license accept 2>/dev/null

  # 2) ติดตั้ง/อัปเดต CocoaPods — เลือกวิธีตามที่มีในเครื่อง
  if command -v brew >/dev/null && brew list cocoapods >/dev/null 2>&1; then
    warn "พบ CocoaPods จาก Homebrew → reinstall ผ่าน brew"
    brew reinstall cocoapods
  else
    warn "ติดตั้ง/อัปเดต CocoaPods ผ่าน gem (อาจถามรหัสผ่าน sudo)"
    sudo gem install cocoapods
  fi

  # 3) ตรวจซ้ำ
  if POD_VER="$(pod --version 2>/tmp/pod_err.txt)"; then
    ok "ซ่อมสำเร็จ — CocoaPods ${POD_VER}"
    POD_OK=1
  else
    err "ยังซ่อมไม่สำเร็จ — error:"
    sed 's/^/    /' /tmp/pod_err.txt
    echo
    warn "แนะนำลองแบบ manual: 'brew install cocoapods' หรือดู https://guides.cocoapods.org"
    warn "จะข้าม pod install ไปก่อน (simulator อาจยัง build ได้ด้วย Pods เดิม)"
  fi
fi

# ---------------------------------------------------------------------------
step "2/6 flutter clean + ล้าง build cache เก่าจากเครื่องเดิม"
flutter clean
rm -rf build ios/build
ok "ล้าง build เก่าแล้ว"

# ---------------------------------------------------------------------------
step "3/6 flutter pub get (ดึง dependencies)"
flutter pub get && ok "pub get เสร็จ" || err "pub get มีปัญหา — ดู error ด้านบน"

# ---------------------------------------------------------------------------
step "4/6 regenerate CocoaPods"
if [ "$POD_OK" -eq 1 ]; then
  ( cd ios && rm -rf Pods Podfile.lock && pod install --repo-update ) \
    && ok "pod install เสร็จ" \
    || err "pod install ล้มเหลว — ดู error ด้านบน"
else
  warn "ข้าม pod install เพราะ CocoaPods ยังใช้ไม่ได้ (แก้ pod ให้ได้ก่อนค่อยรันซ้ำ)"
fi

# ---------------------------------------------------------------------------
step "5/6 รายชื่อ device ที่ต่ออยู่"
flutter devices

# ---------------------------------------------------------------------------
step "6/6 วิธีรัน"
cat <<'EOF'

  # --- iPhone Simulator ---
  open -a Simulator
  flutter run -d "iPhone 16 Pro"      # เปลี่ยนชื่อรุ่นตามที่มี

  # --- iPhone เครื่องจริง (เสียบสาย) ---
  # เสียบสาย > Trust > เปิด Developer Mode (Settings > Privacy & Security)
  flutter run -d <device_id>          # เอา id จาก 'flutter devices'

  * อย่ารัน 'flutter run' เปล่าๆ ไม่งั้นอาจ default ไปลง Chrome(web) แล้ว crash ที่ shader
EOF
echo
ok "setup_ios.sh จบการทำงาน"
