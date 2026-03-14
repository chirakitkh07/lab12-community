import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/attraction.dart';
import '../models/otop_product.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('chiangmai_community.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE attractions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        history TEXT NOT NULL,
        image_url TEXT NOT NULL,
        location TEXT NOT NULL,
        category TEXT NOT NULL,
        is_favorite INTEGER NOT NULL DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE otop_products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        history TEXT NOT NULL,
        image_url TEXT NOT NULL,
        district TEXT NOT NULL,
        price TEXT NOT NULL,
        is_favorite INTEGER NOT NULL DEFAULT 0
      )
    ''');

    // Pre-populate attractions
    await _insertInitialAttractions(db);
    // Pre-populate OTOP products
    await _insertInitialOtopProducts(db);
  }

  Future _insertInitialAttractions(Database db) async {
    final attractions = [
      {
        'name': 'วัดพระธาตุดอยสุเทพ',
        'description':
            'วัดสำคัญคู่เมืองเชียงใหม่ ตั้งอยู่บนยอดดอยสุเทพ สูงจากระดับน้ำทะเล 1,676 เมตร เป็นวัดที่มีพระธาตุเจดีย์สีทองอร่ามงดงามเป็นสัญลักษณ์ของจังหวัดเชียงใหม่',
        'history':
            'สร้างขึ้นเมื่อ พ.ศ. 1926 ในสมัยพระเจ้ากือนา กษัตริย์แห่งอาณาจักรล้านนา โดยอัญเชิญพระบรมสารีริกธาตุมาประดิษฐานไว้บนยอดดอยสุเทพ ตำนานเล่าว่าช้างมงคลได้อัญเชิญพระธาตุขึ้นไปบนดอยและเดินวนรอบ 3 รอบก่อนหยุดลง ณ จุดที่สร้างวัดในปัจจุบัน',
        'image_url':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/Wat_Phra_That_Doi_Suthep_-_Chiang_Mai.jpg/1280px-Wat_Phra_That_Doi_Suthep_-_Chiang_Mai.jpg',
        'location': 'ตำบลสุเทพ อำเภอเมืองเชียงใหม่',
        'category': 'วัด',
        'is_favorite': 0,
      },
      {
        'name': 'อุทยานแห่งชาติดอยอินทนนท์',
        'description':
            'ยอดเขาที่สูงที่สุดในประเทศไทย สูง 2,565 เมตร มีธรรมชาติที่สวยงาม น้ำตก ป่าดิบเขา และเส้นทางเดินศึกษาธรรมชาติ รวมถึงพระมหาธาตุนภเมทนีดลและพระมหาธาตุนภพลภูมิสิริ',
        'history':
            'ชื่อ "ดอยอินทนนท์" ตั้งตามพระนามของพระเจ้าอินทวิชยานนท์ เจ้าผู้ครองนครเชียงใหม่องค์สุดท้าย ผู้ทรงห่วงใยป่าไม้บนดอยหลวง ได้รับการประกาศเป็นอุทยานแห่งชาติลำดับที่ 6 ของประเทศไทย เมื่อ พ.ศ. 2515',
        'image_url':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Doi_Inthanon_summit.jpg/1280px-Doi_Inthanon_summit.jpg',
        'location': 'อำเภอจอมทอง จังหวัดเชียงใหม่',
        'category': 'ธรรมชาติ',
        'is_favorite': 0,
      },
      {
        'name': 'คุ้มเจ้าบุรีรัตน์ (มหาอินทร์)',
        'description':
            'เรือนไม้สักโบราณสไตล์ล้านนาผสมยุโรปที่สวยงาม ปัจจุบันเป็นพิพิธภัณฑ์จัดแสดงศิลปวัฒนธรรมล้านนา ตั้งอยู่ในเขตเมืองเก่าเชียงใหม่',
        'history':
            'สร้างขึ้นในสมัยรัชกาลที่ 5 โดยเจ้าบุรีรัตน์ (มหาอินทร์ ณ เชียงใหม่) เป็นตัวอย่างสถาปัตยกรรมล้านนาที่ผสมผสานกับศิลปะตะวันตก สะท้อนยุคเปลี่ยนแปลงของเชียงใหม่ในช่วงต้นรัตนโกสินทร์',
        'image_url':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3b/Khum_Chao_Burirat.jpg/1280px-Khum_Chao_Burirat.jpg',
        'location': 'ถนนพระปกเกล้า อำเภอเมืองเชียงใหม่',
        'category': 'ประวัติศาสตร์',
        'is_favorite': 0,
      },
      {
        'name': 'ถนนคนเดินท่าแพ',
        'description':
            'ตลาดนัดกลางคืนที่มีชื่อเสียงที่สุดในเชียงใหม่ เปิดทุกวันอาทิตย์ ขายสินค้าหัตถกรรมพื้นเมือง อาหารพื้นเมือง ของที่ระลึก และมีการแสดงศิลปวัฒนธรรมล้านนา',
        'history':
            'เริ่มต้นจากโครงการฟื้นฟูเศรษฐกิจชุมชนในย่านเมืองเก่า จัดครั้งแรกเมื่อ พ.ศ. 2544 จนกลายเป็นแหล่งท่องเที่ยวเชิงวัฒนธรรมที่สำคัญ ช่วยสร้างรายได้ให้ชุมชนและอนุรักษ์งานหัตถกรรมล้านนา',
        'image_url':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/Tha_Phae_Gate%2C_Chiang_Mai.jpg/1280px-Tha_Phae_Gate%2C_Chiang_Mai.jpg',
        'location': 'ถนนท่าแพ-ถนนราชดำเนิน อำเภอเมืองเชียงใหม่',
        'category': 'วัฒนธรรม',
        'is_favorite': 0,
      },
      {
        'name': 'สวนพฤกษศาสตร์สมเด็จพระนางเจ้าสิริกิติ์',
        'description':
            'สวนพฤกษศาสตร์ขนาดใหญ่ พื้นที่ 3,500 ไร่ รวบรวมพันธุ์ไม้หลากหลายชนิด มีเรือนกระจกเขตร้อน เส้นทางเดินศึกษาธรรมชาติ Canopy Walk และทัศนียภาพที่สวยงาม',
        'history':
            'จัดตั้งขึ้นเมื่อ พ.ศ. 2536 เพื่อเฉลิมพระเกียรติสมเด็จพระนางเจ้าสิริกิติ์ พระบรมราชินีนาถ ในวโรกาสพระชนมพรรษาครบ 60 พรรษา เปิดให้บริการอย่างเป็นทางการเมื่อ พ.ศ. 2537 เป็นแหล่งเรียนรู้และอนุรักษ์พันธุ์พืชที่สำคัญของภาคเหนือ',
        'image_url':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Queen_Sirikit_Botanic_Garden_-_Glasshouse_complex.jpg/1280px-Queen_Sirikit_Botanic_Garden_-_Glasshouse_complex.jpg',
        'location': 'อำเภอแม่ริม จังหวัดเชียงใหม่',
        'category': 'ธรรมชาติ',
        'is_favorite': 0,
      },
    ];

    for (var attraction in attractions) {
      await db.insert('attractions', attraction);
    }
  }

  Future _insertInitialOtopProducts(Database db) async {
    final otopProducts = [
      {
        'name': 'ร่มบ่อสร้าง',
        'description':
            'ร่มกระดาษสาทำมือแบบดั้งเดิม ตกแต่งด้วยลวดลายดอกไม้และสัตว์มงคลด้วยสีสันสวยงาม เป็นงานหัตถกรรมที่มีชื่อเสียงระดับโลก',
        'history':
            'การทำร่มบ่อสร้างมีมานานกว่า 200 ปี สืบทอดมาจากช่างฝีมือชาวพม่าที่อพยพมาตั้งถิ่นฐานที่บ้านบ่อสร้าง ชาวบ้านได้พัฒนาเทคนิคการทำร่มจนมีเอกลักษณ์เฉพาะตัว ใช้ไม้ไผ่เป็นโครง กระดาษสาเป็นผืนร่ม และวาดลวดลายด้วยมือทุกชิ้น',
        'image_url':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/5/55/Umbrella_making_in_Chiang_Mai_Thailand.jpg/1280px-Umbrella_making_in_Chiang_Mai_Thailand.jpg',
        'district': 'อำเภอสันกำแพง',
        'price': '200 - 1,500 บาท',
        'is_favorite': 0,
      },
      {
        'name': 'ผ้าทอจอมทอง',
        'description':
            'ผ้าทอมือลวดลายล้านนาดั้งเดิม ทอจากผ้าฝ้ายและผ้าไหม มีลวดลายเอกลักษณ์เฉพาะของอำเภอจอมทอง เหมาะทำเป็นเสื้อผ้า ผ้าพันคอ และของตกแต่งบ้าน',
        'history':
            'การทอผ้าที่จอมทองสืบทอดมายาวนานกว่า 100 ปี เริ่มจากกลุ่มแม่บ้านที่ทอผ้าใช้ในครัวเรือน ต่อมาได้มีการรวมกลุ่มจัดตั้งเป็นวิสาหกิจชุมชน พัฒนาลวดลายผสมผสานระหว่างลายดั้งเดิมกับลายร่วมสมัย จนได้รับรางวัล OTOP 5 ดาว',
        'image_url':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Thai_silk_-_Chiang_Mai.jpg/1280px-Thai_silk_-_Chiang_Mai.jpg',
        'district': 'อำเภอจอมทอง',
        'price': '300 - 3,000 บาท',
        'is_favorite': 0,
      },
      {
        'name': 'แกะสลักไม้บ้านถวาย',
        'description':
            'งานแกะสลักไม้ฝีมือประณีตจากช่างฝีมือบ้านถวาย ผลิตภัณฑ์มีตั้งแต่รูปสลักสัตว์ เฟอร์นิเจอร์ ของตกแต่งบ้าน จนถึงงานศิลปะชั้นสูง',
        'history':
            'หมู่บ้านถวายเป็นแหล่งแกะสลักไม้ที่มีชื่อเสียงมานานกว่า 200 ปี เริ่มจากการแกะสลักสิ่งของใช้ในวัดและบ้านเรือน ต่อมาพัฒนาเป็นอุตสาหกรรมส่งออก มีศูนย์หัตถกรรมบ้านถวายที่รวบรวมร้านค้ากว่า 200 ร้าน',
        'image_url':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d4/Wood_carving_Chiang_Mai.jpg/1280px-Wood_carving_Chiang_Mai.jpg',
        'district': 'อำเภอหางดง',
        'price': '100 - 50,000 บาท',
        'is_favorite': 0,
      },
      {
        'name': 'เซรามิกเชียงใหม่',
        'description':
            'ผลิตภัณฑ์เซรามิกคุณภาพสูง ทั้งเครื่องใช้บนโต๊ะอาหาร แจกัน โคมไฟ และของตกแต่ง ออกแบบด้วยลวดลายร่วมสมัยผสมผสานศิลปะล้านนา',
        'history':
            'อุตสาหกรรมเซรามิกในเชียงใหม่เริ่มต้นในช่วง พ.ศ. 2500 จากการนำดินขาวคุณภาพดีในท้องถิ่นมาผลิต ปัจจุบันเชียงใหม่เป็นศูนย์กลางการผลิตเซรามิกที่สำคัญของไทย มีโรงงานทั้งขนาดเล็กและใหญ่กว่า 30 แห่ง ส่งออกไปทั่วโลก',
        'image_url':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/Ceramic_products.jpg/1280px-Ceramic_products.jpg',
        'district': 'อำเภอสันกำแพง',
        'price': '150 - 5,000 บาท',
        'is_favorite': 0,
      },
      {
        'name': 'กาแฟดอยช้าง',
        'description':
            'กาแฟอาราบิก้าคุณภาพพรีเมียม ปลูกบนความสูง 1,200-1,600 เมตร มีกลิ่นหอมเฉพาะตัว รสชาติเข้มข้น มีความเป็นกรดต่ำ ได้รับการรับรอง GI (Geographical Indication)',
        'history':
            'ชาวเขาเผ่าลีซูและอาข่าบนดอยช้างเริ่มปลูกกาแฟทดแทนพืชเสพติดตั้งแต่ พ.ศ. 2526 ตามโครงการพระราชดำริ จนพัฒนาเป็นแบรนด์กาแฟชั้นนำ ได้รับรางวัลระดับโลก เป็นตัวอย่างความสำเร็จของการพัฒนาชุมชนอย่างยั่งยืน',
        'image_url':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Roasted_coffee_beans.jpg/1280px-Roasted_coffee_beans.jpg',
        'district': 'อำเภอแม่สรวย (ดอยช้าง)',
        'price': '250 - 800 บาท/ถุง',
        'is_favorite': 0,
      },
    ];

    for (var product in otopProducts) {
      await db.insert('otop_products', product);
    }
  }

  // Attraction CRUD
  Future<List<Attraction>> getAttractions() async {
    final db = await database;
    final result = await db.query('attractions');
    return result.map((map) => Attraction.fromMap(map)).toList();
  }

  Future<int> insertAttraction(Attraction attraction) async {
    final db = await database;
    return await db.insert('attractions', attraction.toMap());
  }

  Future<int> updateAttraction(Attraction attraction) async {
    final db = await database;
    return await db.update(
      'attractions',
      attraction.toMap(),
      where: 'id = ?',
      whereArgs: [attraction.id],
    );
  }

  Future<int> deleteAttraction(int id) async {
    final db = await database;
    return await db.delete('attractions', where: 'id = ?', whereArgs: [id]);
  }

  // OTOP CRUD
  Future<List<OtopProduct>> getOtopProducts() async {
    final db = await database;
    final result = await db.query('otop_products');
    return result.map((map) => OtopProduct.fromMap(map)).toList();
  }

  Future<int> insertOtopProduct(OtopProduct product) async {
    final db = await database;
    return await db.insert('otop_products', product.toMap());
  }

  Future<int> updateOtopProduct(OtopProduct product) async {
    final db = await database;
    return await db.update(
      'otop_products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> deleteOtopProduct(int id) async {
    final db = await database;
    return await db.delete('otop_products', where: 'id = ?', whereArgs: [id]);
  }
}
