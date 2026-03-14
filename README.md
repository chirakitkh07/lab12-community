# travel
## จิรกิตติ์ คำป่าตัน 67543210014-6

แอปนี้เป็น คู่มือท่องเที่ยวและสินค้า OTOP จังหวัดเชียงใหม่

โครงสร้าง
```
main.dart
├── models/
│   ├── attraction.dart       → ข้อมูลสถานที่
│   └── otop_product.dart     → ข้อมูลสินค้า OTOP
├── database/
│   └── database_helper.dart  → SQLite (sqflite)
├── providers/
│   ├── attraction_provider.dart
│   └── otop_provider.dart
└── screens/
    ├── home_screen.dart
    ├── attraction_list/detail_screen.dart
    └── otop_list/detail_screen.dart
```
วัตถุประสงค์
แอปนี้ถูกสร้างขึ้นเพื่อ เผยแพร่และส่งเสริมอัตลักษณ์ท้องถิ่นของจังหวัดเชียงใหม่ ผ่านช่องทางดิจิทัล โดยครอบคลุม 2 มิติหลักคือ การท่องเที่ยวเชิงวัฒนธรรม และเศรษฐกิจชุมชน

<img src="images/สถานที่.png">
<img src="images/รายละเอียดสถานที่.png">
<img src="images/สินค้า.png">
<img src="images/รายละเอียดสินค้า.png">
