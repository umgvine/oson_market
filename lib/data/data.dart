const List<String> banners = [
  // Use local banner assets provided in the repo
  'assets/banners/summer_sale_banner.png',
  'assets/banners/shoes_banner.png',
  'assets/banners/watches_banner.png',
];

List<Map<String, dynamic>> products = [];
List<Map<String, dynamic>> categories = [];
List<Map<String, dynamic>> users = [];
List<Map<String, dynamic>> orders = [];

void initData() {
  products = [
    // Five demo products for the "Вау-цены" section — all use demo_product.png
    {
      'id': 101,
      'name': 'Брелок-слот машина',
      'cat': 'Odejda',
      'desc': 'Демонстрационный товар',
      'price': 69713,
      'oldPrice': 181664,
      'discount': 61,
      'rating': 4.7,
      'reviews': 535,
      'deliveryDate': '8 октября',
      'seller': 'Demo Seller',
      'isOfficial': false,
      'img': 'assets/demo/demo_product.png',
      'gallery': ['assets/demo/demo_product.png'],
      'sizes': ['S', 'M', 'L'],
    },
    {
      'id': 102,
      'name': 'Капучинатор электрический',
      'cat': 'Dom i sad',
      'desc': 'Демонстрационный товар',
      'price': 89005,
      'oldPrice': 27519,
      'discount': 67,
      'rating': 4.9,
      'reviews': 28009,
      'deliveryDate': '10 октября',
      'seller': 'Demo Seller',
      'isOfficial': false,
      'img': 'assets/demo/demo_product.png',
      'gallery': ['assets/demo/demo_product.png'],
      'sizes': ['One Size'],
    },
    {
      'id': 103,
      'name': 'Ватные палочки (1000 шт)',
      'cat': 'Apteka',
      'desc': 'Демонстрационный товар',
      'price': 51737,
      'oldPrice': 142642,
      'discount': 63,
      'rating': 4.3,
      'reviews': 412,
      'deliveryDate': '5 октября',
      'seller': 'Demo Seller',
      'isOfficial': false,
      'img': 'assets/demo/demo_product.png',
      'gallery': ['assets/demo/demo_product.png'],
      'sizes': ['200 шт', '500 шт', '1000 шт'],
    },
    {
      'id': 104,
      'name': 'Рюкзак универсальный 20L',
      'cat': 'Mebel',
      'desc': 'Демонстрационный товар',
      'price': 135188,
      'oldPrice': 90480,
      'discount': 85,
      'rating': 4.6,
      'reviews': 1290,
      'deliveryDate': '12 октября',
      'seller': 'Demo Seller',
      'isOfficial': false,
      'img': 'assets/demo/demo_product.png',
      'gallery': ['assets/demo/demo_product.png'],
      'sizes': ['20L'],
    },
    {
      'id': 105,
      'name': 'Доп. товар демонстрация',
      'cat': 'Elektronika',
      'desc': 'Демонстрационный товар',
      'price': 74900,
      'oldPrice': 99900,
      'discount': 25,
      'rating': 4.4,
      'reviews': 340,
      'deliveryDate': '3 октября',
      'seller': 'Demo Seller',
      'isOfficial': false,
      'img': 'assets/demo/demo_product.png',
      'gallery': ['assets/demo/demo_product.png'],
      'sizes': ['M', 'L'],
    },
  ];

  categories = [
    {
      'name': 'Аптека',
      'img': 'assets/categories/apteka.png',
      'subcategories': [
        {'name': 'Лекарства', 'img': 'assets/subcategories/men.png'},
      ],
    },
    {
      'name': 'Бытовая техника',
      'img': 'assets/categories/bytovaya_tehnika.png',
      'subcategories': [
        {'name': 'Мелкая техника', 'img': 'assets/subcategories/tv.png'},
      ],
    },
    {
      'name': 'Детские товары',
      'img': 'assets/categories/detskiya_tovary.png',
      'subcategories': [
        {'name': 'Игрушки', 'img': 'assets/subcategories/kids.png'},
      ],
    },
    {
      'name': 'Для животных',
      'img': 'assets/categories/dlya_jivotnyh.png',
      'subcategories': [
        {'name': 'Корма и товары', 'img': 'assets/subcategories/men.png'},
      ],
    },
    {
      'name': 'Дом и сад',
      'img': 'assets/categories/dom_i_sad.png',
      'subcategories': [
        {'name': 'Мебель', 'img': 'assets/subcategories/men.png'},
      ],
    },
    {
      'name': 'Электроника',
      'img': 'assets/categories/elektronika.png',
      'subcategories': [
        {'name': 'Смартфоны', 'img': 'assets/subcategories/phones.png'},
        {'name': 'Ноутбуки', 'img': 'assets/subcategories/laptops.png'},
      ],
    },
    {
      'name': 'Книги',
      'img': 'assets/categories/knigi.png',
      'subcategories': [
        {
          'name': 'Художественная литература',
          'img': 'assets/subcategories/men.png',
        },
      ],
    },
    {
      'name': 'Красота',
      'img': 'assets/categories/krasota.png',
      'subcategories': [
        {'name': 'Косметика', 'img': 'assets/subcategories/women.png'},
      ],
    },
    {
      'name': 'Мебель',
      'img': 'assets/categories/mebel.png',
      'subcategories': [
        {'name': 'Столы', 'img': 'assets/subcategories/men.png'},
      ],
    },
    {
      'name': 'Одежда',
      'img': 'assets/categories/odejda.png',
      'subcategories': [
        {'name': 'Мужская', 'img': 'assets/subcategories/men.png'},
        {'name': 'Женская', 'img': 'assets/subcategories/women.png'},
      ],
    },
    {
      'name': 'Спорт',
      'img': 'assets/categories/sport.png',
      'subcategories': [
        {'name': 'Фитнес', 'img': 'assets/subcategories/men.png'},
      ],
    },
    {
      'name': 'Строительство и ремонт',
      'img': 'assets/categories/stroitelstvo_i_remont.png',
      'subcategories': [
        {'name': 'Инструменты', 'img': 'assets/subcategories/men.png'},
      ],
    },
  ];

  users = [
    {
      'id': '1',
      'name': 'Azizbek Xamcs39anov',
      'email': 'azizbek@example.com',
      'phone': '+998901234567',
      'orders': 12,
      'joined': '2023-01-15',
      'status': 'Aktiv',
    },
  ];

  orders = [
    {
      'id': '#OS12345',
      'customer': 'Azizbek Xasanov',
      'date': '15 Okt, 2023',
      'amount': '1,249,000 so\'m',
      'status': 'Yangi',
      'items': 3,
    },
  ];
}
