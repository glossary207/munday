# รัน munday บน iPhone (เครื่องจริง + Simulator)

คู่มือหลังย้ายโปรเจกต์มาจากเครื่องอื่น สภาพเครื่องปัจจุบันจาก `flutter doctor`:
Flutter 3.44.7 · Xcode 16.2 · CocoaPods 1.17.0 — iOS toolchain ผ่านหมด ✓

## 0. สิ่งที่ต้องทำครั้งแรก (สำคัญหลังย้ายเครื่อง)

รันสคริปต์เตรียมระบบ ทำครั้งเดียว:

```bash
cd /Users/munday/ProjectMunday/MundayGEN/munday
chmod +x setup_ios.sh
./setup_ios.sh
```

สคริปต์นี้จะ: ตรวจ toolchain → `flutter clean` → `flutter pub get` →
ลบ `Pods/` + `Podfile.lock` เก่าแล้ว `pod install` ใหม่ → แสดง device list

เหตุผลที่ต้องลบ Pods ใหม่: โฟลเดอร์ `Pods/` และ `Podfile.lock` ที่ติดมากับโปรเจกต์
ผูกกับ path/เครื่องเดิม ต้อง regenerate ให้ตรงกับเครื่องนี้

## 1. iPhone Simulator

```bash
open -a Simulator          # เปิด simulator (สร้าง/เลือกรุ่นได้จาก Xcode > Window > Devices and Simulators)
flutter devices            # ยืนยันว่าเห็น simulator
flutter run                # ถ้าเปิด simulator ไว้ตัวเดียว จะเลือกให้อัตโนมัติ
# หรือระบุชื่อรุ่น
flutter run -d "iPhone 16 Pro"
```

Simulator ไม่ต้องเซ็น signing และไม่ต้องมี Apple Developer account — เร็วที่สุดสำหรับ dev
(ข้อจำกัด: ปลั๊กอินที่ใช้ฮาร์ดแวร์จริง เช่น กล้อง/GPS บางตัว จะจำลองได้จำกัด)

## 2. iPhone เครื่องจริง (เสียบสาย USB)

1. เสียบสาย → ปลดล็อกเครื่อง → กด **Trust This Computer** บน iPhone
2. เปิด Developer Mode: **Settings > Privacy & Security > Developer Mode > On** แล้ว restart เครื่อง
   (iOS 16 ขึ้นไปบังคับ; ถ้าไม่เปิด `flutter devices` จะไม่เห็นเครื่อง)
3. ตรวจว่ามองเห็น:
   ```bash
   flutter devices
   ```
4. รัน (ใส่ device id ที่ได้จากขั้นบน):
   ```bash
   flutter run -d <device_id>
   ```

Signing ตั้งไว้ให้แล้วในโปรเจกต์:
- `DEVELOPMENT_TEAM = 4FPJT6W3SJ`, `CODE_SIGN_STYLE = Automatic`
- Bundle id: `com.mycompany.mundayone` (+ extension `.ImageNotification`)
- Deployment target: iOS 15.0

ถ้าเจอ error เรื่อง signing/provisioning ให้เปิด `ios/Runner.xcworkspace` ด้วย Xcode →
เลือก target **Runner** > **Signing & Capabilities** > ติ๊ก *Automatically manage signing*
และเลือก Team ให้ถูก (ทำครั้งเดียว) จากนั้นกลับมา `flutter run` ได้เลย

ครั้งแรกที่ลงเครื่องจริง อาจต้องไปที่ **Settings > General > VPN & Device Management** บน iPhone
แล้วกด Trust โปรไฟล์ developer ก่อนแอปจะเปิดได้

## 3. เรื่องสำคัญ: error ใน flutter_01.log ไม่ใช่ปัญหา iOS

Crash ล่าสุดคือ `flutter run` ที่ไม่ได้ระบุ device แล้ว **default ไปลง Chrome (web)**
จึงพังตอน compile shader ของ `liquid_glass_easy`
(สังเกตใน stack: `ResidentWebRunner`, `WebDevFS` = web ล้วนๆ)

วิธีเลี่ยง: **ระบุ `-d` เสมอ** ให้ลง iOS/simulator ไม่ปล่อยให้มันเดา
```bash
flutter run -d <device_id>     # อย่ารัน 'flutter run' เปล่าๆ ตอนไม่มี iOS device เปิดอยู่
```
ถ้าจะรัน web จริงๆ แล้วยังติด shader ตัวนี้ ค่อยแยกไปแก้ทีหลัง — ไม่กระทบการลง iPhone

## Cheat sheet

```bash
flutter devices                 # ดู device ทั้งหมด + id
flutter run -d <id>             # รันลงเครื่องที่เลือก
r                               # (ระหว่างรัน) hot reload
R                               # hot restart
q                               # quit
flutter run -d <id> --release   # โหมด release
```
