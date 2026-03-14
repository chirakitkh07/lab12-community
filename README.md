# travel
## จิรกิตติ์ คำป่าตัน 67543210014-6

แอปนี้เป็น คู่มือท่องเที่ยวและสินค้า OTOP จังหวัดเชียงใหม่

โครงสร้าง
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

แอปนี้จะเป็นการแนะนำและสินค้า otop ของจังหวัดเชียงใหม่
แอปจะนำเสนอสถานที่สำคัญในจังหวัดเชียงใหม่พร้อมข้อมูลเชิงลึก ทั้งรายละเอียดและประวัติความเป็นมา เพื่อให้นักท่องเที่ยวและผู้สนใจสามารถศึกษาและวางแผนการเที่ยวได้

<img src="images/สถานที่.png">
<img src="images/รายละเอียดสถานที่.png">
<img src="images/สินค้า.png">
<img src="images/รายละเอียดสินค้า.png">