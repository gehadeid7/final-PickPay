// import 'package:pickpay/features/categories_pages/models/product_model.dart';

// class ProductData {
//   static List<ProductsViewsModel> getElectronicsProducts() {
//     return [
//       // Mobile & Tablet
//       ProductsViewsModel(
//         id: 'elec1',
//         title: 'Samsung Galaxy Tab A9',
//         price: 9399.00,
//         brand: 'Samsung',
//         rating: 4.5,
//         reviewCount: 46,
//         imagePaths: [
//           'assets/electronics_products/mobile_and_tablet/mobile_and_tablet1/1.png'
//         ],
//       ),
//       ProductsViewsModel(
//         id: 'elec2',
//         title: 'Apple iPhone 15 Pro Max',
//         price: 89999.00,
//         brand: 'Apple',
//         rating: 4.0,
//         reviewCount: 19,
//         imagePaths: [
//           'assets/electronics_products/mobile_and_tablet/mobile_and_tablet2/1.png'
//         ],
//       ),
//       ProductsViewsModel(
//         id: 'elec3',
//         title: 'Samsung Galaxy S24 Ultra',
//         price: 49999.00,
//         brand: 'Samsung',
//         rating: 4.0,
//         reviewCount: 19,
//         imagePaths: [
//           'assets/electronics_products/mobile_and_tablet/mobile_and_tablet3/1.png'
//         ],
//       ),
//       ProductsViewsModel(
//         id: 'elec4',
//         title: 'CANSHN iPhone Case',
//         price: 110.00,
//         brand: 'CANSHN',
//         rating: 4.7,
//         reviewCount: 237,
//         imagePaths: [
//           'assets/electronics_products/mobile_and_tablet/mobile_and_tablet4/1.png'
//         ],
//       ),
//       ProductsViewsModel(
//         id: 'elec5',
//         title: 'Oraimo Fast Charger',
//         price: 199.00,
//         brand: 'Oraimo',
//         rating: 4.7,
//         reviewCount: 380,
//         imagePaths: [
//           'assets/electronics_products/mobile_and_tablet/mobile_and_tablet5/1.png'
//         ],
//       ),

//       // TVs
//       ProductsViewsModel(
//         id: 'elec6',
//         title: 'Samsung 55 Inch QLED Smart TV',
//         price: 18499.00,
//         brand: 'Samsung',
//         rating: 4.5,
//         reviewCount: 46,
//         imagePaths: ['assets/electronics_products/tvscreens/tv1/1.png'],
//       ),
//       ProductsViewsModel(
//         id: 'elec7',
//         title: 'Xiaomi TV A 43',
//         price: 9999.00,
//         brand: 'Xiaomi',
//         rating: 4.0,
//         reviewCount: 19,
//         imagePaths: ['assets/electronics_products/tvscreens/tv2/1.png'],
//       ),
//       ProductsViewsModel(
//         id: 'elec8',
//         title: 'Samsung 50 Inch TV Crystal Processor 4K LED',
//         price: 16299.00,
//         brand: 'Samsung',
//         rating: 4.0,
//         reviewCount: 19,
//         imagePaths: ['assets/electronics_products/tvscreens/tv3/1.png'],
//       ),
//       ProductsViewsModel(
//         id: 'elec9',
//         title: 'SHARP 4K Smart Frameless TV 55 Inch',
//         price: 16999.00,
//         brand: 'SHARP',
//         rating: 4.7,
//         reviewCount: 4,
//         imagePaths: ['assets/electronics_products/tvscreens/tv4/1.png'],
//       ),
//       ProductsViewsModel(
//         id: 'elec10',
//         title: 'LG UHD 4K TV 60 Inch UQ7900 Series',
//         price: 18849.00,
//         brand: 'LG',
//         rating: 4.5,
//         reviewCount: 19,
//         imagePaths: ['assets/electronics_products/tvscreens/tv5/1.png'],
//       ),

//       // Laptops
//       ProductsViewsModel(
//         id: 'elec11',
//         title: 'LENOVO ideapad slim3',
//         price: 24313.00,
//         brand: 'Lenovo',
//         rating: 5.0,
//         reviewCount: 2,
//         imagePaths: ['assets/electronics_products/Laptop/Laptop1/1.png'],
//       ),
//       ProductsViewsModel(
//         id: 'elec12',
//         title: 'Lenovo Legion 5 Gaming Laptop',
//         price: 36999.00,
//         brand: 'Lenovo',
//         rating: 3.4,
//         reviewCount: 14,
//         imagePaths: ['assets/electronics_products/Laptop/Laptop2/1.png'],
//       ),
//       ProductsViewsModel(
//         id: 'elec13',
//         title: 'HP Victus Gaming Laptop',
//         price: 30999.00,
//         brand: 'HP',
//         rating: 4.0,
//         reviewCount: 19,
//         imagePaths: ['assets/electronics_products/Laptop/Laptop3/1.png'],
//       ),
//     ];
//   }

//   static List<ProductsViewsModel> getFashionProducts() {
//     return [
//       // Women's Fashion
//       ProductsViewsModel(
//         id: 'fashion_women_1',
//         title: "Women's Chiffon Dress",
//         price: 850.00,
//         brand: 'Generic',
//         rating: 4.2,
//         reviewCount: 156,
//         imagePaths: [
//           'assets/Fashion_products/Women_Fashion/women_fashion1/1.png'
//         ],
//       ),
//       ProductsViewsModel(
//         id: 'fashion_women_2',
//         title: "adidas womens ULTIMASHOW Shoes",
//         price: 1456.53,
//         brand: 'Adidas',
//         rating: 4.5,
//         reviewCount: 892,
//         imagePaths: [
//           'assets/Fashion_products/Women_Fashion/women_fashion2/1.png'
//         ],
//       ),

//       // Men's Fashion
//       ProductsViewsModel(
//         id: 'fashion_men_1',
//         title: "DeFacto Man Polo T-Shirt",
//         price: 599.00,
//         brand: 'DeFacto',
//         rating: 4.1,
//         reviewCount: 324,
//         imagePaths: ['assets/Fashion_products/Men_Fashion/men_fashion1/1.png'],
//       ),
//       ProductsViewsModel(
//         id: 'fashion_men_2',
//         title: "DOTT JEANS WEAR Men's Jeans",
//         price: 718.30,
//         brand: 'DOTT',
//         rating: 4.3,
//         reviewCount: 567,
//         imagePaths: ['assets/Fashion_products/Men_Fashion/men_fashion2/1.png'],
//       ),

//       // Kids' Fashion
//       ProductsViewsModel(
//         id: 'fashion_kids_1',
//         title: "LC WAIKIKI Kids Pajama Set",
//         price: 261.00,
//         brand: 'LC WAIKIKI',
//         rating: 4.6,
//         reviewCount: 234,
//         imagePaths: [
//           'assets/Fashion_products/Kids_Fashion/kids_fashion1/1.png'
//         ],
//       ),
//       ProductsViewsModel(
//         id: 'fashion_kids_2',
//         title: "Kidzo Boys Pajamas",
//         price: 580.00,
//         brand: 'Kidzo',
//         rating: 4.4,
//         reviewCount: 178,
//         imagePaths: [
//           'assets/Fashion_products/Kids_Fashion/kids_fashion2/1.png'
//         ],
//       ),
//     ];
//   }

//   static List<ProductsViewsModel> getBeautyProducts() {
//     return [
//       // Makeup
//       ProductsViewsModel(
//         id: '68132a95ff7813b3d47f9da1',
//         title: 'L\'Oréal Paris Volume Million Lashes Panorama Mascara',
//         price: 401.00,
//         brand: 'L\'Oréal Paris',
//         rating: 5.0,
//         reviewCount: 88,
//         imagePaths: ['assets/beauty_products/makeup_1/1.png'],
//       ),
//       ProductsViewsModel(
//         id: '68132a95ff7813b3d47f9da2',
//         title: 'L\'Oréal Paris Infaillible 24H Matte Cover Foundation',
//         price: 509.00,
//         brand: 'L\'Oréal Paris',
//         rating: 5.0,
//         reviewCount: 88,
//         imagePaths: ['assets/beauty_products/makeup_2/1.png'],
//       ),
//       ProductsViewsModel(
//         id: '68132a95ff7813b3d47f9da3',
//         title: 'Cybele Smooth N`Wear Powder Blush',
//         price: 227.20,
//         brand: 'Cybele',
//         rating: 5.0,
//         reviewCount: 88,
//         imagePaths: ['assets/beauty_products/makeup_3/1.png'],
//       ),
//       ProductsViewsModel(
//         id: '68132a95ff7813b3d47f9da4',
//         title: 'Eva Makeup Remover Wipes',
//         price: 63.00,
//         brand: 'Eva',
//         rating: 5.0,
//         reviewCount: 92,
//         imagePaths: ['assets/beauty_products/makeup_4/1.png'],
//       ),
//       ProductsViewsModel(
//         id: '68132a95ff7813b3d47f9da5',
//         title: 'Maybelline New York Lifter Lip Gloss',
//         price: 300.00,
//         brand: 'Maybelline',
//         rating: 5.0,
//         reviewCount: 88,
//         imagePaths: ['assets/beauty_products/makeup_5/1.png'],
//       ),

//       // Skincare
//       ProductsViewsModel(
//         id: '68132a95ff7813b3d47f9da6',
//         title: 'Care & More Soft Cream',
//         price: 31.00,
//         brand: 'Care & More',
//         rating: 4.0,
//         reviewCount: 19,
//         imagePaths: ['assets/beauty_products/skincare_1/1.png'],
//       ),
//       ProductsViewsModel(
//         id: '68132a95ff7813b3d47f9da7',
//         title: 'La Roche-Posay Anthelios XL',
//         price: 1168.70,
//         brand: 'La Roche-Posay',
//         rating: 4.0,
//         reviewCount: 19,
//         imagePaths: ['assets/beauty_products/skincare_2/1.png'],
//       ),
//       ProductsViewsModel(
//         id: '68132a95ff7813b3d47f9da8',
//         title: 'Eva Aloe Skin Clinic Toner',
//         price: 138.60,
//         brand: 'Eva',
//         rating: 4.0,
//         reviewCount: 19,
//         imagePaths: ['assets/beauty_products/skincare_3/1.png'],
//       ),
//       ProductsViewsModel(
//         id: '68132a95ff7813b3d47f9da9',
//         title: 'Eucerin DermoPurifyer Serum',
//         price: 658.93,
//         brand: 'Eucerin',
//         rating: 4.0,
//         reviewCount: 19,
//         imagePaths: ['assets/beauty_products/skincare_4/1.png'],
//       ),
//       ProductsViewsModel(
//         id: '68132a95ff7813b3d47f9da10',
//         title: 'L\'Oréal Paris Hyaluron Expert Eye Serum',
//         price: 429.00,
//         brand: 'L\'Oréal Paris',
//         rating: 4.8,
//         reviewCount: 19,
//         imagePaths: ['assets/beauty_products/skincare_5/1.png'],
//       ),
//     ];
//   }

//   static List<ProductsViewsModel> getHomeProducts() {
//     return [
//       // Furniture
//       ProductsViewsModel(
//         id: 'home1',
//         title: 'Golden Life Sofa Bed',
//         price: 7850.00,
//         brand: 'Golden Life',
//         rating: 5.0,
//         reviewCount: 88,
//         imagePaths: ['assets/Home_products/furniture/furniture1/1.png'],
//       ),
//       ProductsViewsModel(
//         id: 'home2',
//         title: 'Star Bags Bean Bag Chair',
//         price: 1699.00,
//         brand: 'Star Bags',
//         rating: 5.0,
//         reviewCount: 88,
//         imagePaths: ['assets/Home_products/furniture/furniture2/1.png'],
//       ),
//       ProductsViewsModel(
//         id: 'home3',
//         title: 'Generic Coffee Table',
//         price: 3600.00,
//         brand: 'Generic',
//         rating: 5.0,
//         reviewCount: 88,
//         imagePaths: ['assets/Home_products/furniture/furniture3/1.png'],
//       ),
//       ProductsViewsModel(
//         id: 'home4',
//         title: 'Gaming Chair',
//         price: 9696.55,
//         brand: 'Furgle',
//         rating: 5.0,
//         reviewCount: 92,
//         imagePaths: ['assets/Home_products/furniture/furniture4/1.png'],
//       ),
//       ProductsViewsModel(
//         id: 'home5',
//         title: 'Janssen Almany Mattress',
//         price: 5060.03,
//         brand: 'Janssen',
//         rating: 5.0,
//         reviewCount: 88,
//         imagePaths: ['assets/Home_products/furniture/furniture5/1.png'],
//       ),

//       // Home Decor
//       ProductsViewsModel(
//         id: 'home6',
//         title: 'Golden Lighting LED Lampshade',
//         price: 1128.00,
//         brand: 'Golden Lighting',
//         rating: 4.0,
//         reviewCount: 19,
//         imagePaths: ['assets/Home_products/home-decor/home_decor1/1.png'],
//       ),
//       ProductsViewsModel(
//         id: 'home7',
//         title: 'Luxury Bathroom Rug',
//         price: 355.00,
//         brand: 'Luxury',
//         rating: 4.0,
//         reviewCount: 19,
//         imagePaths: ['assets/Home_products/home-decor/home_decor2/1.png'],
//       ),
//       ProductsViewsModel(
//         id: 'home8',
//         title: 'Glass Vase',
//         price: 250.00,
//         brand: 'Generic',
//         rating: 4.0,
//         reviewCount: 19,
//         imagePaths: ['assets/Home_products/home-decor/home_decor3/1.png'],
//       ),
//       ProductsViewsModel(
//         id: 'home9',
//         title: 'Amotpo Wall Clock',
//         price: 549.00,
//         brand: 'Amotpo',
//         rating: 4.0,
//         reviewCount: 19,
//         imagePaths: ['assets/Home_products/home-decor/home_decor4/1.png'],
//       ),
//       ProductsViewsModel(
//         id: 'home10',
//         title: 'Oliruim Art Statue',
//         price: 650.00,
//         brand: 'Oliruim',
//         rating: 5.0,
//         reviewCount: 19,
//         imagePaths: ['assets/Home_products/home-decor/home_decor5/1.png'],
//       ),

//       // Kitchen
//       ProductsViewsModel(
//         id: 'home11',
//         title: 'Neoflam Cookware Set',
//         price: 15795.00,
//         brand: 'Neoflam',
//         rating: 4.8,
//         reviewCount: 19,
//         imagePaths: ['assets/Home_products/kitchen/kitchen1/1.png'],
//       ),
//       ProductsViewsModel(
//         id: 'home12',
//         title: 'Pasabahce Mug Set',
//         price: 495.00,
//         brand: 'Pasabahce',
//         rating: 4.9,
//         reviewCount: 1439,
//         imagePaths: ['assets/Home_products/kitchen/kitchen2/1.png'],
//       ),
//       ProductsViewsModel(
//         id: 'home13',
//         title: 'P&P CHEF Pizza Pan Set',
//         price: 276.00,
//         brand: 'P&P CHEF',
//         rating: 4.5,
//         reviewCount: 1162,
//         imagePaths: ['assets/Home_products/kitchen/kitchen3/1.png'],
//       ),
//       ProductsViewsModel(
//         id: 'home14',
//         title: 'LIANYU Silverware Set',
//         price: 50099.00,
//         brand: 'LIANYU',
//         rating: 4.6,
//         reviewCount: 1735,
//         imagePaths: ['assets/Home_products/kitchen/kitchen4/1.png'],
//       ),
//       ProductsViewsModel(
//         id: 'home15',
//         title: 'Dish Drying Rack',
//         price: 400.00,
//         brand: 'Generic',
//         rating: 4.6,
//         reviewCount: 4576,
//         imagePaths: ['assets/Home_products/kitchen/kitchen5/1.png'],
//       ),
//     ];
//   }

//   static List<ProductsViewsModel> getAppliancesProducts() {
//     return [
//       // Large Appliances
//       ProductsViewsModel(
//         id: 'appliances_large_1',
//         title: 'Koldair Water Dispenser',
//         price: 10499.00,
//         brand: 'Koldair',
//         rating: 3.1,
//         reviewCount: 9,
//         imagePaths: ['assets/appliances/product1/1.png'],
//       ),

//       // Small Appliances
//       ProductsViewsModel(
//         id: 'appliances_small_1',
//         title: 'Fresh Fan 50 Watts',
//         price: 3983.00,
//         brand: 'Fresh',
//         rating: 4.4,
//         reviewCount: 674,
//         imagePaths: ['assets/appliances/product11/1.png'],
//       ),
//     ];
//   }

//   static List<ProductsViewsModel> getVideoGamesProducts() {
//     return [
//       // Consoles
//       ProductsViewsModel(
//         id: 'games_console_1',
//         title: 'PlayStation 5 Digital Edition',
//         price: 22999.00,
//         brand: 'Sony',
//         rating: 4.8,
//         reviewCount: 1245,
//         imagePaths: ['assets/videogames_products/Consoles/console1/1.png'],
//       ),
//       ProductsViewsModel(
//         id: 'games_console_2',
//         title: 'Xbox Series X',
//         price: 21999.00,
//         brand: 'Microsoft',
//         rating: 4.7,
//         reviewCount: 892,
//         imagePaths: ['assets/videogames_products/Consoles/console2/1.png'],
//       ),

//       // Controllers
//       ProductsViewsModel(
//         id: 'games_controller_1',
//         title: 'PS5 DualSense Controller',
//         price: 2499.00,
//         brand: 'Sony',
//         rating: 4.6,
//         reviewCount: 567,
//         imagePaths: [
//           'assets/videogames_products/Controllers/controller1/1.png'
//         ],
//       ),
//       ProductsViewsModel(
//         id: 'games_controller_2',
//         title: 'Xbox Wireless Controller',
//         price: 2299.00,
//         brand: 'Microsoft',
//         rating: 4.5,
//         reviewCount: 432,
//         imagePaths: [
//           'assets/videogames_products/Controllers/controller2/1.png'
//         ],
//       ),

//       // Accessories
//       ProductsViewsModel(
//         id: 'games_accessories_1',
//         title: 'PS5 HD Camera',
//         price: 1999.00,
//         brand: 'Sony',
//         rating: 4.3,
//         reviewCount: 234,
//         imagePaths: [
//           'assets/videogames_products/Accessories/accessories1/1.png'
//         ],
//       ),
//       ProductsViewsModel(
//         id: 'games_accessories_2',
//         title: 'Gaming Headset',
//         price: 899.00,
//         brand: 'Generic',
//         rating: 4.2,
//         reviewCount: 178,
//         imagePaths: [
//           'assets/videogames_products/Accessories/accessories2/1.png'
//         ],
//       ),
//     ];
//   }
// }
