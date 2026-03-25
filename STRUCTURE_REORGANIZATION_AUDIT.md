# Munday Structure Reorganization Audit

Date: 2026-03-24
Scope: `/Users/bewsunattha/MundayGEN/munday`
Goal: สรุปภาพรวมโครงสร้างปัจจุบันของระบบ, ชี้ว่าทำไมมันยังมีกลิ่นแบบ FlutterFlow, และเสนอกรอบจัดระบบใหม่ให้เข้าใจง่าย ดูแลง่าย และลดความงง โดยยังไม่แก้โค้ด

## 1. Executive Summary

โปรเจกต์นี้ไม่ได้มีปัญหาเพราะมี feature มากเกินไป แต่มีปัญหาเพราะ feature เดียวกันถูกกระจายข้ามหลายกองตามรูปแบบ generated code ของ FlutterFlow มากกว่าตาม domain ของธุรกิจจริง

ในมุมธุรกิจ ระบบจริงมีแกนหลักประมาณ 5 กลุ่มเท่านั้น:

1. Auth / Account
2. Discovery / Venue / Event / Promotion
3. Venue Detail / Review / Media
4. Booking / Ticket / Table Layout / Checkout
5. Social / Chat / Profile Interaction

แต่โครงสร้างปัจจุบันกระจายสิ่งเหล่านี้ไปอยู่ใน:

- `pages_chat/`
- `p_a_g_e_main/`
- `components/`
- `custom_code/`
- `flutter_flow/`
- `backend/`

ผลคือเวลาอ่านระบบจะรู้สึกว่า:

- ไม่รู้ว่าอะไรคือ feature หลัก
- ไม่รู้ว่า widget ไหน reusable จริง
- ไม่รู้ว่า state ไหนเป็น global state ที่จำเป็น และ state ไหนเป็น state เฉพาะหน้า
- ไม่รู้ว่า data access ควรเริ่มดูจากตรงไหน
- ไม่รู้ว่าอะไรคือ generated layer และอะไรคือ business layer

สรุปสั้นที่สุดคือ:

- โครงสร้างตอนนี้ "ทำงานได้"
- แต่ยัง "อ่านยากและจัดลำดับความสำคัญยาก"
- ถ้าจะทำให้หลุดจากรูปแบบ FlutterFlow ต้องเปลี่ยนจาก "folder ตาม screen/output" ไปเป็น "folder ตาม domain และ responsibility"

## 2. Current Shape Of The Codebase

### 2.1 Top-level reality

root ของ `munday` ตอนนี้มีทั้ง:

- source code ของแอป
- local build artifacts
- local Python environments
- Firebase functions
- internal dependencies
- preview/builder metadata
- backup folder

กล่าวง่ายๆ คือ root ปัจจุบันเป็นทั้ง:

- app repository
- developer workstation state
- generated output store
- migration playground

สิ่งนี้ทำให้ boundary ของระบบไม่ชัดตั้งแต่ระดับแรกสุด

### 2.2 High-level code distribution

การนับแบบหยาบใน `lib/` ให้ภาพนี้:

| Area | Files | Approx. Lines | Meaning |
| --- | ---: | ---: | --- |
| `components` | 120 | 44,322 | UI ก้อนกลางขนาดใหญ่ แต่ไม่ได้ reusable ทั้งหมด |
| `p_a_g_e_main` | 20 | 45,431 | หน้าหลักฝั่ง discovery / venue / booking |
| `pages_chat` | 16 | 37,799 | หน้าฝั่ง auth / social / chat / profile |
| `backend` | 65 | 11,704 | schema, repository, shim, API integrations |
| `flutter_flow` | 20 | 12,117 | generated runtime layer |
| `custom_code` | 30 | 6,134 | custom widgets/actions ที่เสริมจาก FlutterFlow |

ความหมายของตัวเลขนี้ชัดมาก:

- logic หลักไม่ได้อยู่ใน backend
- logic หลักไม่ได้แยกตาม domain
- logic ส่วนใหญ่ไปกองอยู่ใน screen และ component

## 3. What The Real Product Domains Are

ถ้ามองแบบ business-first แทน FlutterFlow-first ระบบนี้ควรถูกมองเป็น domain เหล่านี้

### 3.1 Auth

สิ่งที่อยู่ใน domain นี้:

- login
- sign up
- phone login
- OTP verify
- auth session
- secure token storage

ไฟล์ที่เกี่ยวข้องในปัจจุบัน:

- `lib/auth/`
- `lib/pages_chat/authentication/`
- `lib/pages_chat/phone_auth/`
- `lib/services/auth_manager.dart`

หมายเหตุ:

- `phone_login_widget.dart` ดูเป็นโค้ดที่เริ่มหลุดจากรูปแบบ FlutterFlow แล้ว และควรเป็นตัวอย่างของ style ใหม่
- `authentication_widget.dart` ยังเป็น generated-heavy flow แบบ FlutterFlow ชัดเจน

### 3.2 Account

สิ่งที่อยู่ใน domain นี้:

- profile
- edit profile
- avatar/image management
- privacy
- support
- blocklist
- password / recovery

ไฟล์ที่เกี่ยวข้องในปัจจุบัน:

- `lib/pages_chat/profile/`
- `lib/profile06/`
- `lib/blocklist/`
- `lib/privacy_policy/`
- `lib/support/`
- `lib/forgetpassword/`

### 3.3 Discovery

สิ่งที่อยู่ใน domain นี้:

- venue list
- event list
- promotion list
- search
- filters
- map/list switch
- distance-based discovery

ไฟล์ที่เกี่ยวข้องในปัจจุบัน:

- `lib/p_a_g_e_main/venues/`
- `lib/p_a_g_e_main/events/`
- `lib/p_a_g_e_main/promotion/`
- ส่วนหนึ่งของ `components/filter_*`
- ส่วนหนึ่งของ map widgets

### 3.4 Venue Detail

สิ่งที่อยู่ใน domain นี้:

- venue detail page
- gallery / photos
- review
- story / media
- popup map
- share page
- venue-specific presentation widgets

ไฟล์ที่เกี่ยวข้องในปัจจุบัน:

- `lib/p_a_g_e_main/in_venuse/`
- `lib/p_a_g_e_main/sharepage/`
- `lib/showallphoto/`
- `components/showphoto_*`
- `components/review_*`
- `components/poster_present_*`
- `components/popupmap_*`
- `components/story_view_*`
- `components/part_header_in_venuse_active_*`
- `components/part_option_in_venuse_active_*`

### 3.5 Booking

สิ่งที่อยู่ใน domain นี้:

- booking flow
- ticket flow
- table/seat selection
- floor layout
- checkout links
- payment-related UI

ไฟล์ที่เกี่ยวข้องในปัจจุบัน:

- `lib/p_a_g_e_main/booking/`
- `lib/p_a_g_e_main/ticket/`
- `lib/payreservenormday/`
- `lib/bookng/`
- `lib/booking2/`
- `lib/booking2c/`
- `components/table_*`
- `components/stage_*`
- `components/checkout1_products_*`
- `custom_code/widgets/layout_preview_widget.dart`

### 3.6 Social / Chat

สิ่งที่อยู่ใน domain นี้:

- chat rooms
- user interaction
- profile popup
- feed-like social surface
- join room
- story-like features

ไฟล์ที่เกี่ยวข้องในปัจจุบัน:

- `lib/pages_chat/home/`
- `lib/pages_chat/home_page/`
- `lib/pages_chat/chats/`
- `components/joinroom_*`
- `components/popupuser_*`
- `components/profilepopup_*`
- `components/card33_user_grid_*`
- `components/item_*`
- `components/delchat_*`
- `components/story_view_*`

## 4. Why It Still Feels Like FlutterFlow

### 4.1 Foldering follows generation, not business

`pages_chat` และ `p_a_g_e_main` เป็นชื่อที่สะท้อน "ตอนถูกสร้าง" มากกว่า "มันทำหน้าที่อะไร"

อาการ:

- auth ไปอยู่ `pages_chat/authentication`
- profile ไปอยู่ `pages_chat/profile`
- venue discovery ไปอยู่ `p_a_g_e_main/venues`
- booking ไปอยู่ `p_a_g_e_main/booking`

ปัญหา:

- คนใหม่ในทีมไม่รู้ว่าต้องเริ่มอ่านจาก domain ไหน
- ชื่อ folder ไม่ช่วยอธิบาย intent

### 4.2 `components/` กลายเป็น dump bucket

`components/` ตอนนี้มีทั้ง:

- shared widgets จริง
- feature-specific widgets
- experimental widgets
- giant business widgets

ตัวอย่างชัด:

- `part_option_in_venuse_active_widget.dart` เป็นของ venue detail โดยตรง ไม่ใช่ shared UI ทั่วไป

เมื่อทุกอย่างไปกองใน `components/` จะเกิดปัญหา:

- reusable กับ feature-local แยกไม่ออก
- ย้าย feature ออกมาทำยาก
- dependency graph อ่านยาก

### 4.3 หน้าหลักแต่ละหน้าเป็น super-screen

หลายหน้ามีอาการ:

- import เยอะมาก
- ดึงทั้ง backend, state, popup, custom widgets, generated utils
- มี side effects ใน `initState`
- มี business logic ติดอยู่ใน widget

ผลคือ widget แต่ละหน้าไม่ใช่แค่ view แต่เป็นทั้ง:

- orchestrator
- state coordinator
- integration point
- business rule container

### 4.4 `FFAppState` เป็น global state dump

`FFAppState` ปัจจุบันเก็บ state หลาย domain ปนกัน เช่น:

- discovery filters
- venue selection
- booking data
- popup flags
- language
- API URLs
- UI navigation helpers
- media-related flags

ตัวอย่าง field:

- `dateclick`
- `locationsearch`
- `Filterdistance`
- `VenuseSelection`
- `StyleVenuse`
- `storedoc`
- `SeatSelect`
- `Totlepricebooking`
- `readyshowcheers`
- `ActivePromotion`

ปัญหาหลัก:

- state ที่ควรเป็น local ไปอยู่ global
- state ที่ควรเป็น domain-specific ไม่มีขอบเขตชัด
- dependency แอบเชื่อมกันข้าม feature

### 4.5 `custom_functions.dart` รวมทุกอย่างไว้ในไฟล์เดียว

ไฟล์นี้เป็นอีกตัวอย่างของโครงสร้างแบบ FlutterFlow:

- utility function
- math helpers
- string helpers
- collection helpers
- business helpers
- location/distance logic
- domain logic ที่ไม่ควรอยู่ใน generic bucket

ปัญหา:

- อ่านยาก
- test ยาก
- หาจุดแก้ยาก
- ไม่มี semantic grouping

### 4.6 generated layer กับ handwritten layer ยังไม่ถูกแยกให้ชัด

ปัจจุบัน handwritten code และ generated code อยู่ใกล้กันมาก:

- `lib/flutter_flow/`
- `lib/backend/schema/`
- `lib/index.dart`
- `lib/main.dart`
- handwritten screens
- handwritten custom code

เมื่อทุกอย่างอยู่ level ใกล้กัน คนอ่านจะไม่รู้ว่า:

- ไฟล์ไหนแตะได้อย่างมั่นใจ
- ไฟล์ไหนควรถือว่า generated
- ไฟล์ไหนควรค่อยๆ replace

## 5. What Is Important And What Is Not

การจัดใหม่ให้เข้าใจง่ายต้องเริ่มจากการประกาศว่าอะไรสำคัญจริง

### 5.1 Core business areas

สิ่งที่เป็นหัวใจของ product:

- authentication
- user account / profile
- venue discovery
- event / promotion discovery
- venue detail
- booking / table / ticket
- chat / social interaction

สิ่งเหล่านี้ควรกลายเป็น top-level feature modules

### 5.2 Supporting technical areas

สิ่งที่สำคัญแต่ไม่ควรนำสายตา:

- repositories
- backend clients
- schema mapping
- storage access
- push notification integration
- auth/session adapters

สิ่งเหล่านี้ควรอยู่ใน `data/` หรือ `core/`

### 5.3 Generated / transitional areas

สิ่งที่ยังอาจจำเป็น แต่ไม่ควรเป็นโครงหลักที่ทีมมองเห็นก่อน:

- `flutter_flow/`
- generated schema records
- shim layers
- barrel exports แบบ generated
- route registry แบบ generated

แนวคิดคือ:

- ไม่ต้องลบก่อน
- แต่ต้องย้ายไปชั้น `generated/` หรือ `legacy/` ให้ชัด

### 5.4 Archive candidates

สิ่งที่ไม่ควรอยู่ในแกนระบบ:

- `*_copy`
- `test`
- `testui`
- `mapdum`
- `aut`
- `booking2`
- `booking2c`
- `lib_save1`
- preview/dev-only code
- builder metadata

สิ่งเหล่านี้ไม่จำเป็นต้องลบทันที แต่ควรถูกจัดชั้นว่า:

- archive
- sandbox
- legacy
- experimental

## 6. What Should Be Merged

### 6.1 Auth should be one feature

ควรรวม:

- `auth/`
- `pages_chat/authentication/`
- `pages_chat/phone_auth/`
- `services/auth_manager.dart`

เป้าหมาย:

- มีจุดเข้าใจเรื่อง auth แค่ที่เดียว
- แยก session, login methods, OTP, storage ออกจาก UI

### 6.2 Account should be one feature

ควรรวม:

- `pages_chat/profile/`
- `profile06/`
- `blocklist/`
- `forgetpassword/`
- `privacy_policy/`
- `support/`

เป้าหมาย:

- account settings และ user identity อยู่ในโซนเดียวกัน

### 6.3 Discovery should be one feature

ควรรวม:

- `p_a_g_e_main/events/`
- `p_a_g_e_main/venues/`
- `p_a_g_e_main/promotion/`
- filter/map/list controls ที่ใช้ในบริบท discovery

เป้าหมาย:

- search, list, filters, results อยู่ด้วยกัน

### 6.4 Venue detail should be one feature

ควรรวม:

- `p_a_g_e_main/in_venuse/`
- `p_a_g_e_main/sharepage/`
- `showallphoto/`
- venue-specific components ทั้งหมด

เป้าหมาย:

- ทุกอย่างที่เกิดหลังจาก "คลิกเข้า venue หนึ่งแห่ง" ต้องอยู่ใน module เดียว

### 6.5 Booking should be one feature

ควรรวม:

- `p_a_g_e_main/booking/`
- `p_a_g_e_main/ticket/`
- `bookng/`
- `booking2/`
- `booking2c/`
- `payreservenormday/`
- layout/table widgets

เป้าหมาย:

- booking flow อ่านแล้วเห็นครบทั้ง journey

### 6.6 Social should be one feature

ควรรวม:

- `pages_chat/home/`
- `pages_chat/home_page/`
- `pages_chat/chats/`
- social popup widgets
- join room widgets
- story/social presentation widgets

เป้าหมาย:

- คนอ่านรู้ทันทีว่า "นี่คือ social/chat side ของแอป"

## 7. What Should Be Separated

### 7.1 Separate shared UI from feature UI

`shared/ui` ควรมีเฉพาะสิ่งที่:

- ใช้หลาย feature จริง
- ไม่มี business context เฉพาะ
- เปลี่ยนแล้วไม่กระทบ semantics ของ feature เดียว

ตัวอย่างที่ควรแยกออกจาก shared:

- venue-specific header/option widgets
- booking-specific table widgets
- profile/social popups ที่ผูกกับ domain เดียว

### 7.2 Separate data access from screens

หน้าจอไม่ควรเป็นที่รวม:

- direct query
- write/update logic
- conversion helpers
- storage logic
- notification trigger logic

สิ่งเหล่านี้ควรไปอยู่ใน:

- repositories
- services
- use cases
- controllers/view-models

### 7.3 Separate generated code from canonical code

ควรมีหลักคิดว่า:

- generated code ยังอยู่ได้
- แต่ canonical code ของทีมต้องแยกชัดจาก generated code

ไม่งั้นทุกครั้งที่อ่านระบบจะเริ่มจากชั้นผิด

### 7.4 Separate dev-only artifacts from app runtime

ไม่ควรให้ preview, builder metadata, local env, backup folders ปะปนอยู่กับ runtime tree

## 8. Recommended Target Structure

โครงสร้างที่เหมาะกับการค่อยๆ ย้ายจาก FlutterFlow ไปสู่ระบบที่อ่านง่าย:

```text
lib/
  app/
    bootstrap/
    routing/
    navigation/

  core/
    config/
    constants/
    errors/
    utils/
    types/

  data/
    models/
    repositories/
    services/
    sources/
      supabase/
      firebase/
      storage/

  features/
    auth/
      presentation/
      application/
      domain/
      data/

    account/
      presentation/
      application/
      domain/
      data/

    discovery/
      presentation/
      application/
      domain/
      data/

    venue_detail/
      presentation/
      application/
      domain/
      data/

    booking/
      presentation/
      application/
      domain/
      data/

    social/
      presentation/
      application/
      domain/
      data/

  shared/
    ui/
    widgets/
    formatters/
    extensions/

  generated/
    flutterflow/
    schema/
    routes/

  legacy/
    screens/
    components/

  devtools/
    preview/
```

หมายเหตุ:

- ไม่จำเป็นต้องย้ายทุกอย่างทันที
- โครงสร้างนี้ใช้ได้แม้จะย้ายแบบค่อยเป็นค่อยไป
- สามารถมี `legacy/` ชั่วคราวเพื่อรองรับของเก่าระหว่าง transition

## 9. Recommended Reclassification Of Current Folders

| Current | Proposed Home | Reason |
| --- | --- | --- |
| `lib/auth` | `features/auth` | auth domain โดยตรง |
| `lib/pages_chat/authentication` | `features/auth` | auth UI |
| `lib/pages_chat/phone_auth` | `features/auth` | OTP/login flow |
| `lib/services/auth_manager.dart` | `features/auth` หรือ `data/services` | auth support logic |
| `lib/pages_chat/profile` | `features/account` | account/profile |
| `lib/profile06` | `features/account` หรือ `legacy/account` | profile variant |
| `lib/blocklist` | `features/account` | account behavior |
| `lib/support` | `features/account` | support belongs to account/help |
| `lib/privacy_policy` | `features/account` หรือ `app/legal` | legal/account adjacent |
| `lib/p_a_g_e_main/events` | `features/discovery` | discovery flow |
| `lib/p_a_g_e_main/venues` | `features/discovery` | discovery flow |
| `lib/p_a_g_e_main/promotion` | `features/discovery` | discovery flow |
| `lib/p_a_g_e_main/in_venuse` | `features/venue_detail` | venue-specific flow |
| `lib/p_a_g_e_main/sharepage` | `features/venue_detail` | venue detail adjunct |
| `lib/showallphoto` | `features/venue_detail` | venue/media detail |
| `lib/p_a_g_e_main/booking` | `features/booking` | booking flow |
| `lib/p_a_g_e_main/ticket` | `features/booking` | booking/ticket flow |
| `lib/bookng` | `features/booking` หรือ `legacy/booking` | unclear duplicate |
| `lib/booking2` | `legacy/booking` | duplicate candidate |
| `lib/booking2c` | `legacy/booking` | duplicate candidate |
| `lib/payreservenormday` | `features/booking` | booking/payment related |
| `lib/pages_chat/home` | `features/social` | social surface |
| `lib/pages_chat/home_page` | `features/social` หรือ `legacy/social` | unclear duplicate |
| `lib/pages_chat/chats` | `features/social` | chat domain |
| `lib/components` | split into `shared/ui`, `features/*/widgets`, `legacy/components` | currently mixed |
| `lib/custom_code` | split into feature-local custom code + `shared/widgets` | currently mixed |
| `lib/backend` | `data/` + `generated/schema` | data layer |
| `lib/flutter_flow` | `generated/flutterflow` | generated runtime |
| `lib/preview` | `devtools/preview` | not runtime core |

## 10. State Strategy Recommendation

### 10.1 Current problem

ตอนนี้ `FFAppState` ทำหน้าที่เป็น global bag ของทุกอย่าง:

- UI flags
- domain data
- temporary values
- feature selection
- filters
- booking context

นี่คือ pattern ที่ควรเลิกพึ่งเป็นแกนหลัก

### 10.2 Recommended replacement direction

แทนที่จะมี state ก้อนเดียว ควรแยกเป็น:

- `SessionState`
  - auth status
  - current user
  - session-bound flags
- `DiscoveryState`
  - selected filters
  - current location
  - selected venue/event
- `BookingState`
  - selected date
  - selected seats/tables
  - current booking draft
- `SocialState`
  - room context
  - profile popup context
  - local social selection state
- `PreferencesState`
  - language
  - simple user preferences

หลักตัดสินใจ:

- ถ้า state ใช้แค่ในหน้าเดียวหรือ flow เดียว ให้เก็บ local ก่อน
- ถ้า state ใช้ข้ามหลายหน้าของ domain เดียว ให้เก็บใน domain state
- ถ้า state ใช้ข้ามทั้งแอปจริงๆ ค่อยเก็บ global

## 11. Data Layer Strategy Recommendation

### 11.1 Good direction that already exists

มีสัญญาณที่ดีแล้ว:

- มี `repositories/`
- มี `supabase_config.dart`
- มี data records/schema

แปลว่าระบบมีเมล็ดของ architecture ที่ดีอยู่แล้ว

### 11.2 Problem now

แต่ปัจจุบันยังเกิดสิ่งเหล่านี้พร้อมกัน:

- widget query data ตรง
- widget update data ตรง
- repository มีแต่ยังไม่ใช่จุดเข้าใช้งานหลัก
- schema generated และ custom repository อยู่ร่วมกันแบบยังไม่ชัดว่าใครเป็น canonical layer

### 11.3 Recommended target

ให้กำหนดชั้นดังนี้:

- `generated/schema`
  - generated record wrappers
  - generated serialization helpers
- `data/repositories`
  - canonical entry points ของทีม
- `data/services`
  - API calls, storage, notifications
- `features/*/application`
  - orchestrate use case ระดับ feature

แนวคิดคือ:

- generated schema อยู่ได้
- แต่ feature ของทีมควรเรียกผ่าน repository/service ที่ทีมควบคุม

## 12. Backend Truth Needs To Be Clarified

ปัจจุบันระบบยังมีกลิ่น hybrid / transitional backend:

- แอปหลักใช้ Supabase
- มี shim layer เพื่อเลียนแบบ Firestore semantics
- ยังมี Firebase functions
- ยังมี Firebase config/platform files
- push notification ยังมีร่องรอย Firestore/FCM workflow เดิม

ในเชิงโครงสร้างจึงต้องประกาศให้ชัดว่า:

### Option A: Supabase is primary, Firebase is transitional support

เหมาะถ้ากำลังย้ายออกจาก Firebase จริง

สิ่งที่ต้องทำต่อในอนาคต:

- ย้าย integration ไปชั้น data/integrations
- แยก legacy Firebase flow ออกจาก canonical data flow

### Option B: App is intentionally hybrid

เหมาะถ้ายังต้องใช้ Firebase สำหรับ messaging/functions บางส่วนถาวร

ถ้าเป็นแบบนี้ต้องจัด folder ให้ explicit ว่า:

- `data/sources/supabase/`
- `data/sources/firebase/`

สิ่งที่ห้ามมีต่อคือสภาพ "เหมือน migrate ไม่เสร็จ แต่ก็ยังใช้อยู่"

## 13. Shared UI Policy Recommendation

`shared/ui` ควรมีเฉพาะ:

- button base
- modal shell
- app scaffold wrappers
- text styles/helpers
- generic card/list items
- generic loading/empty/error widgets

สิ่งที่ไม่ควรเข้า `shared/ui`:

- widgets ที่ชื่อผูกกับ venue, booking, chat, profile domain
- giant widgets ที่ใช้จริงแค่ feature เดียว
- widgets ที่รู้เรื่อง schema/business field โดยตรง

กฎง่ายๆ:

- ถ้าชื่อ widget ฟังแล้วรู้เลยว่ามาจาก domain ไหน มันไม่ควรอยู่ shared

## 14. What To Do With `components/`

ไม่ควรพยายาม rename `components/` ทั้งก้อนแล้วจบ เพราะปัญหาจริงไม่ใช่ชื่อโฟลเดอร์ แต่คือ mix of responsibilities

ควร audit ทุกไฟล์ใน `components/` เป็น 3 กลุ่ม:

### Group 1: Truly shared

เช่น:

- generic nav shell
- generic empty states
- generic image/video helpers

ย้ายไป:

- `shared/ui/`
- `shared/widgets/`

### Group 2: Feature-local

เช่น:

- venue-specific sections
- review sections
- booking table/stage
- chat item/popup widgets

ย้ายไป:

- `features/discovery/widgets`
- `features/venue_detail/widgets`
- `features/booking/widgets`
- `features/social/widgets`

### Group 3: Legacy / uncertain / duplicates

เช่น:

- `*_copy`
- `fromtest_*`
- ambiguous old variants

ย้ายไป:

- `legacy/components`
- หรือ `archive/`

## 15. What To Do With `custom_code/`

`custom_code/` ในโลก FlutterFlow มักแปลว่า "ของที่ generated system ทำไม่ไหว" แต่ใน architecture ที่ดี มันควรถูก reclassified ตามบทบาทจริง

ควรแยกเป็น:

- feature widgets
- shared widgets
- services/helpers
- actions/use cases

ตัวอย่าง:

- map widgets ควรไป domain discovery/venue detail
- layout preview ควรไป booking
- image crop/upload ควรไป account/media
- share-to-line ควรไป shared integration หรือ venue detail/social แล้วแต่ usage

## 16. Naming Problems That Should Be Corrected Over Time

ชื่อที่ทำให้ cognitive load สูง:

- `p_a_g_e_main`
- `in_venuse`
- `bookng`
- `mapdum`
- `aut`
- `payreservenormday`
- `home_copy2`
- `home_copy2_copy`
- `ticket_copy`
- `in_venuse_copy`

ชื่อพวกนี้ทำให้:

- intent ไม่ชัด
- search/find ยาก
- refactor conversation ยาก
- onboarding ยาก

แนวทาง:

- เปลี่ยนเป็นชื่อ semantic ตาม use case
- อนุญาตให้มี `legacy_` หรือ `experimental_` ถ้ายังต้องเก็บไว้ชั่วคราว

## 17. Current High-Risk Complexity Hotspots

ไฟล์ขนาดใหญ่มากเป็นสัญญาณว่าควรแยก responsibility ในอนาคต:

- `components/part_option_in_venuse_active_widget.dart` ~12.7k lines
- `pages_chat/home/home_widget.dart` ~10.3k lines
- `pages_chat/home_copy2/home_copy2_widget.dart` ~9.7k lines
- `p_a_g_e_main/in_venuse/in_venuse_widget.dart` ~7.6k lines
- `p_a_g_e_main/booking/booking_widget.dart` ~6.4k lines
- `p_a_g_e_main/events/events_widget.dart` ~6.0k lines
- `flutter_flow/internationalization.dart` ~5.7k lines

ไฟล์ใหญ่ไม่ได้แปลว่าผิดเสมอไป แต่ในเคสนี้มันสอดคล้องกับอาการ:

- state ปนกัน
- dependency เยอะ
- side effects เยอะ
- feature boundary ไม่ชัด

## 18. Root Cleanup Policy Recommendation

ในระดับ project root ควรแยกให้ชัดว่าอะไรคือ:

- source of truth
- generated
- local-only
- dev-only

กลุ่มที่ควรออกจากสายตาหลัก:

- `.dart_tool`
- `build`
- `ios/Pods`
- `.venv`
- `.migration_env`
- `.munday_builder`
- `lib_save1`

กลุ่มที่ควรจัดชั้นให้ชัด:

- `firebase/`
- `dependencies/`
- preview/dev artifacts

## 19. Proposed Future Folder Priority

ถ้าต้องเลือกแค่ว่าทีมควรโฟกัสอะไรเป็น top-level first-class structure ในอนาคต ให้เหลือไม่เกินนี้:

1. `features/`
2. `data/`
3. `shared/`
4. `core/`
5. `app/`
6. `generated/`
7. `legacy/`

นี่คือชุดที่ทำให้ทีมตอบคำถามได้ง่าย:

- อยู่ feature ไหน
- ใช้ data จากไหน
- อะไรใช้ร่วมกัน
- อะไรเป็น generated
- อะไรเป็นของเก่า

## 20. Recommended Migration Philosophy

การย้ายโครงสร้างไม่ควรทำแบบ "ยกทั้งระบบแล้วค่อยให้ compile"

ควรใช้หลักนี้:

### Principle 1: Stop adding new complexity in old buckets

เมื่อประกาศโครงสร้างใหม่แล้ว:

- อย่าเพิ่ม feature ใหม่ใน `components/`
- อย่าเพิ่มหน้าใหม่ใน `p_a_g_e_main/` ถ้าไม่จำเป็น
- อย่าเติม field ใหม่ใน `FFAppState` ถ้าเลี่ยงได้

### Principle 2: Move by domain, not by file type

อย่าทำ:

- ย้าย widget ทั้งหมดก่อน
- ย้าย model ทั้งหมดก่อน

ควรทำ:

- ย้าย `auth` ทั้งชุด
- ย้าย `discovery` ทั้งชุด
- ย้าย `booking` ทั้งชุด

### Principle 3: Establish canonical homes first

ก่อนย้ายไฟล์เก่า ต้องประกาศว่า:

- auth ใหม่อยู่ที่ไหน
- discovery ใหม่อยู่ที่ไหน
- booking ใหม่อยู่ที่ไหน
- shared ใหม่อยู่ที่ไหน

### Principle 4: Keep generated code isolated, not eliminated

เป้าหมายไม่ใช่ลบ generated code ให้หมดทันที

เป้าหมายคือ:

- ทำให้ generated code อยู่ในชั้นที่คาดเดาได้
- ทำให้ handwritten business code อยู่ในชั้นที่ชัดกว่า

## 21. Recommended Refactor Order

ถ้าต้องทำทีละก้อน ลำดับที่เหมาะที่สุดคือ:

### Phase 0: Structural freeze

- หยุดเพิ่มของใหม่ลง bucket เก่าเท่าที่ทำได้
- ตั้ง naming policy ใหม่
- ประกาศ target structure

### Phase 1: Auth and account

เหตุผล:

- boundary ชัด
- blast radius จำกัด
- ช่วยสร้าง pattern ใหม่ได้เร็ว

### Phase 2: Discovery and venue detail

เหตุผล:

- เป็น business core หลัก
- ตอนนี้กระจัดกระจายมาก

### Phase 3: Booking

เหตุผล:

- flow ชัด
- เหมาะกับการแยก domain/state

### Phase 4: Social and chat

เหตุผล:

- dependency เยอะ
- screen ใหญ่
- ควรย้ายหลังมี architecture pattern ชัดแล้ว

### Phase 5: Generated and legacy isolation

- ย้าย `flutter_flow` / schema / old screens ไปชั้นที่ชัด
- archive ของ duplicate/copy/test

## 22. Decision Checklist

ใช้ checklist นี้เวลาตัดสินว่าไฟล์หนึ่งควรไปอยู่ไหน

### ถ้าเป็น feature file

- [ ] มันผูกกับ use case หนึ่งชัดไหม
- [ ] ชื่อมันบอก domain ได้ไหม
- [ ] มันใช้แค่ feature เดียวหรือหลาย feature
- [ ] มันมี business semantics ในตัวไหม

ถ้าใช่ ให้ไป `features/<domain>/...`

### ถ้าเป็น shared file

- [ ] ไม่มีชื่อเฉพาะ domain
- [ ] ไม่รู้เรื่อง schema เฉพาะ
- [ ] ใช้ได้ข้ามหลาย feature จริง
- [ ] เปลี่ยนแล้วไม่เปลี่ยน business meaning

ถ้าใช่ ให้ไป `shared/...`

### ถ้าเป็น data file

- [ ] มัน access network/db/storage ไหม
- [ ] มัน map payload/schema ไหม
- [ ] มันเป็น integration adapter ไหม

ถ้าใช่ ให้ไป `data/...`

### ถ้าเป็น generated file

- [ ] มาจาก FlutterFlow หรือ generator โดยตรงไหม
- [ ] ทีมไม่ควรแก้บ่อยไหม
- [ ] มันเป็น infrastructure glue มากกว่า business logic ไหม

ถ้าใช่ ให้ไป `generated/...`

### ถ้าเป็น legacy file

- [ ] มี copy/duplicate variant ไหม
- [ ] ชื่อไม่ชัดไหม
- [ ] ยังไม่แน่ใจว่าใช้งานจริงไหม
- [ ] เป็น transitional code ไหม

ถ้าใช่ ให้ไป `legacy/...` หรือ `archive/...`

## 23. Final Recommendation

เป้าหมายของการจัดระบบใหม่ไม่ใช่แค่ "ย้ายไฟล์ให้สวย"

เป้าหมายจริงคือ:

- ทำให้ทีมรู้ว่า feature หลักคืออะไร
- ทำให้คนอ่านใหม่เริ่มต้นถูกที่
- ลด global coupling
- ทำให้ shared กับ feature-local แยกกันชัด
- ทำให้ generated code ไม่แย่งพื้นที่สายตาของ business code
- ทำให้โครงสร้างสะท้อน product จริง มากกว่าสะท้อนเครื่องมือที่ใช้ generate

ประโยคที่ใช้ตัดสินได้ง่ายที่สุดคือ:

> ถ้าคนไม่รู้จัก FlutterFlow เปิด repo นี้ขึ้นมา เขาควรยังเข้าใจโครงสร้างระบบได้จากชื่อ folder และขอบเขตความรับผิดชอบ

ตอนนี้ยังไม่ถึงจุดนั้น

แต่ฐานของระบบมีอยู่แล้ว และสามารถพาไปถึงจุดนั้นได้ถ้าย้ายโดยยึด domain เป็นศูนย์กลาง ไม่ใช่ยึด generated layout เดิม

## 24. Suggested Next Step

ขั้นต่อไปที่เหมาะที่สุดหลังเอกสารนี้ คือทำเอกสาร mapping ระดับไฟล์:

- `keep`
- `move`
- `merge`
- `split`
- `archive`

โดยแจกแจงทีละไฟล์หรือทีละกลุ่มไฟล์ว่าควรไปอยู่ home ใหม่ตรงไหน

เอกสารนี้จึงเป็นภาพรวมระดับ architecture และใช้เป็นฐานสำหรับแตกงานย้ายโครงสร้างในรอบถัดไป
