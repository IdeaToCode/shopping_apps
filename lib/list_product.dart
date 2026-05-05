class Product {
  final String name;
  final String price;
  final String imageUrl;
  final String description;
  final String category;

  const Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.category,
  });
}

List<Product> allProducts = [
  Product(
    name: "iPhone 15 Pro",
    price: "999",
    imageUrl:
        "https://images.unsplash.com/photo-1696446701796-da61225697cc?q=80&w=500",
    description: "أحدث هاتف من آبل مع معالج A17 Pro.",
    category: "إلكترونيات",
  ),
  Product(
    name: "Samsung S24 Ultra",
    price: "1199",
    imageUrl:
        "https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?q=80&w=500",
    description: "هاتف ذكي مع قلم وشاشة مذهلة.",
    category: "إلكترونيات",
  ),
  Product(
    name: "MacBook Air M2",
    price: "1099",
    imageUrl:
        "https://images.unsplash.com/photo-1517336712461-481bf7916b4b?q=80&w=500",
    description: "لابتوب نحيف وقوي جداً للعمل والدراسة.",
    category: "إلكترونيات",
  ),
  Product(
    name: "Sony WH-1000XM5",
    price: "350",
    imageUrl:
        "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=500",
    description: "أفضل سماعات عازلة للضوضاء.",
    category: "إلكترونيات",
  ),
  Product(
    name: "Apple Watch Series 9",
    price: "399",
    imageUrl:
        "https://images.unsplash.com/photo-1544117518-30dd5f4844bf?q=80&w=500",
    description: "ساعة ذكية لمراقبة الصحة والرياضة.",
    category: "إلكترونيات",
  ),
  Product(
    name: "لوحة مفاتيح ميكانيكية",
    price: "80",
    imageUrl:
        "https://images.unsplash.com/photo-1511467687858-23d96c32e4ae?q=80&w=500",
    description: "لوحة مفاتيح مخصصة للألعاب والبرمجة.",
    category: "إلكترونيات",
  ),
  Product(
    name: "شاشة ألعاب 4K",
    price: "450",
    imageUrl:
        "https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?q=80&w=500",
    description: "شاشة منحنية بتردد 144 هرتز.",
    category: "إلكترونيات",
  ),
  Product(
    name: "كاميرا كانون EOS R5",
    price: "3500",
    imageUrl:
        "https://images.unsplash.com/photo-1516035069371-29a1b244cc32?q=80&w=500",
    description: "كاميرا احترافية للتصوير السينمائي.",
    category: "إلكترونيات",
  ),
  Product(
    name: "جهاز آيباد برو",
    price: "799",
    imageUrl:
        "https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?q=80&w=500",
    description: "أقوى جهاز تابلت مع شاشة Liquid Retina.",
    category: "إلكترونيات",
  ),
  Product(
    name: "طائرة درون (Drone)",
    price: "600",
    imageUrl:
        "https://images.unsplash.com/photo-1473968512647-3e44a224fe8f?q=80&w=500",
    description: "طائرة تصوير جوي بدقة 4K.",
    category: "إلكترونيات",
  ),

  // --- فئة الملابس ---
  Product(
    name: "قميص قطني أزرق",
    price: "25",
    imageUrl:
        "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?q=80&w=500",
    description: "قميص مريح مصنوع من القطن الطبيعي 100%.",
    category: "ملابس",
  ),
  Product(
    name: "بنطال جينز كلاسيك",
    price: "40",
    imageUrl:
        "https://images.unsplash.com/photo-1541099649105-f69ad21f3246?q=80&w=500",
    description: "جينز متين وعصري يناسب جميع المناسبات.",
    category: "ملابس",
  ),
  Product(
    name: "سترة شتوية ثقيلة",
    price: "85",
    imageUrl:
        "https://images.unsplash.com/photo-1591047134402-234122d1feaa?q=80&w=500",
    description: "سترة دافئة جداً لمواجهة البرد القارس.",
    category: "ملابس",
  ),
  Product(
    name: "حذاء رياضي نايك",
    price: "120",
    imageUrl:
        "https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=500",
    description: "حذاء مخصص للجري لمسافات طويلة.",
    category: "ملابس",
  ),
  Product(
    name: "قبعة رياضية",
    price: "15",
    imageUrl:
        "https://images.unsplash.com/photo-1588850561407-ed78c282e89b?q=80&w=500",
    description: "قبعة خفيفة لحماية الرأس من الشمس.",
    category: "ملابس",
  ),
  Product(
    name: "حقيبة ظهر جلدية",
    price: "55",
    imageUrl:
        "https://images.unsplash.com/photo-1548036328-c9fa89d128fa?q=80&w=500",
    description: "حقيبة أنيقة للعمل والسفر.",
    category: "ملابس",
  ),
  Product(
    name: "ساعة يد كلاسيكية",
    price: "150",
    imageUrl:
        "https://images.unsplash.com/photo-1524592094714-0f0654e20314?q=80&w=500",
    description: "ساعة جلدية فاخرة للمناسبات الرسمية.",
    category: "ملابس",
  ),
  Product(
    name: "نظارة شمسية ريبان",
    price: "130",
    imageUrl:
        "https://images.unsplash.com/photo-1511499767350-a1590fdb7351?q=80&w=500",
    description: "حماية كاملة من الأشعة فوق البنفسجية.",
    category: "ملابس",
  ),
  Product(
    name: "حزام جلد طبيعي",
    price: "20",
    imageUrl:
        "https://images.unsplash.com/photo-1614164185128-e4ec99c436d7?q=80&w=500",
    description: "حزام أسود متين عالي الجودة.",
    category: "ملابس",
  ),
  Product(
    name: "فستان صيفي",
    price: "45",
    imageUrl:
        "https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?q=80&w=500",
    description: "فستان خفيف مريح للأجواء الحارة.",
    category: "ملابس",
  ),

  // --- فئة المنزل ---
  Product(
    name: "ماكينة قهوة إكسبريسو",
    price: "200",
    imageUrl:
        "https://images.unsplash.com/photo-1517668808822-9ebb02f2a0e6?q=80&w=500",
    description: "استمتع بقهوة احترافية في منزلك كل صباح.",
    category: "منزل",
  ),
  Product(
    name: "خلاط كهربائي سريع",
    price: "45",
    imageUrl:
        "https://images.unsplash.com/photo-1570197711457-027f101d5292?q=80&w=500",
    description: "مثالي لتحضير العصائر والشوربات.",
    category: "منزل",
  ),
  Product(
    name: "قلاية هوائية (Air Fryer)",
    price: "130",
    imageUrl:
        "https://images.unsplash.com/photo-1626074353765-517a681e40be?q=80&w=500",
    description: "لطبخ طعام صحي بدون زيت.",
    category: "منزل",
  ),
  Product(
    name: "طقم أواني طبخ",
    price: "150",
    imageUrl:
        "https://images.unsplash.com/photo-1584990344111-a396ec2ca9ec?q=80&w=500",
    description: "طقم مكون من 10 قطع غير لاصقة.",
    category: "منزل",
  ),
  Product(
    name: "مكنسة كهربائية ذكية",
    price: "300",
    imageUrl:
        "https://images.unsplash.com/photo-1527515545081-5db817172677?q=80&w=500",
    description: "مكنسة روبوت تنظف المنزل تلقائياً.",
    category: "منزل",
  ),
  Product(
    name: "مصباح مكتبي ذكي",
    price: "35",
    imageUrl:
        "https://images.unsplash.com/photo-1534073828943-f801091bb18c?q=80&w=500",
    description: "إضاءة قابلة للتعديل عبر الهاتف.",
    category: "منزل",
  ),
  Product(
    name: "ميزان رقمي",
    price: "25",
    imageUrl:
        "https://images.unsplash.com/photo-1594331853235-97e3681436cc?q=80&w=500",
    description: "ميزان دقيق لقياس الوزن ونسبة الدهون.",
    category: "منزل",
  ),
  Product(
    name: "وسادة طبية",
    price: "30",
    imageUrl:
        "https://images.unsplash.com/photo-1632102911657-d3570685968d?q=80&w=500",
    description: "وسادة مريحة جداً لآلام الرقبة.",
    category: "منزل",
  ),
  Product(
    name: "طقم أكواب سيراميك",
    price: "18",
    imageUrl:
        "https://images.unsplash.com/photo-1514228742587-6b1558fbed20?q=80&w=500",
    description: "طقم من 6 أكواب بتصميم عصري.",
    category: "منزل",
  ),
  Product(
    name: "ساعة حائط خشبية",
    price: "40",
    imageUrl:
        "https://images.unsplash.com/photo-1563861826100-9cb868fdbe1c?q=80&w=500",
    description: "ساعة صامتة تضيف لمسة جمالية للمنزل.",
    category: "منزل",
  ),
];
