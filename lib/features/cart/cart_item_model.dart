import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'dart:developer' as dev;

class CartItemModel {
  final ProductsViewsModel product;
  final int quantity;

  CartItemModel({
    required this.product,
    required this.quantity,
  });

  CartItemModel copyWith({int? quantity}) {
    return CartItemModel(
      product: product,
      quantity: quantity ?? this.quantity,
    );
  }

  // Convert CartItemModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
    };
  }

  // Create CartItemModel from JSON
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    try {
      if (json == null) {
        throw Exception('Cart item data is null');
      }

      // If product is a String, wrap it as a Map
      dynamic productData = json['product'];
      if (productData is String) {
        productData = {'id': productData};
      } else if (productData == null) {
        productData = {};
      }

      // Get quantity from cart item or default to 1
      final quantity = json['quantity'] ?? 1;
      if (quantity == null) {
        throw Exception('Quantity is null');
      }

      // Ensure product data has required fields
      final productId = productData['_id'] ?? productData['id'];
      // Local mapping for productId to category if missing
      final Map<String, String> productCategoryMap = {
        // Example: '68252918a68b49cb06164210': 'appliances',
        // Add more mappings as needed
      };
      String? category = productData['category'];
      if ((category == null || category == 'unknown') && productId != null) {
        category = productCategoryMap[productId] ?? 'unknown';
      }
      if (productId == null) {
        throw Exception('Product ID is missing');
      }
      // Create static image paths similar to product detail view
      List<String> imagePaths = [];

      // Try to get the same image paths as in product detail
      if (productData['imagePaths'] != null &&
          productData['imagePaths'] is List) {
        imagePaths = List<String>.from(productData['imagePaths']);
      } else {
        // Get category and ID for static image path
        final category = productData['category']?.toString().toLowerCase();
        final id = productId;

        if (category != null && id != null) {
          String? staticPath;
          switch (category) {
            case 'fashion':
              if (id.startsWith('682b00c2')) {
                if (id == '682b00c26977bd89257c0e93') {
                  staticPath =
                      'assets/Fashion_products/Men_Fashion/men_fashion1/navy/1.png';
                } else if (id == '682b00c26977bd89257c0e94') {
                  staticPath =
                      'assets/Fashion_products/Men_Fashion/men_fashion2/light_blue/1.png';
                } else if (id == '682b00c26977bd89257c0e95') {
                  staticPath =
                      'assets/Fashion_products/Men_Fashion/men_fashion3/1.png';
                } else if (id == '682b00c26977bd89257c0e96') {
                  staticPath =
                      'assets/Fashion_products/Men_Fashion/men_fashion4/black/1.png';
                } else if (id == '682b00c26977bd89257c0e97') {
                  staticPath =
                      'assets/Fashion_products/Men_Fashion/men_fashion5/1.png';
                } else if (id == '682b00c26977bd89257c0e98') {
                  staticPath =
                      'assets/Fashion_products/Kids_Fashion/kids_fashion1/1.png';
                } else if (id == '682b00c26977bd89257c0e99') {
                  staticPath =
                      'assets/Fashion_products/Kids_Fashion/kids_fashion2/1.png';
                } else if (id == '682b00c26977bd89257c0e9a') {
                  staticPath =
                      'assets/Fashion_products/Kids_Fashion/kids_fashion3/1.png';
                } else if (id == '682b00c26977bd89257c0e9b') {
                  staticPath =
                      'assets/Fashion_products/Kids_Fashion/kids_fashion4/1.png';
                } else if (id == '682b00c26977bd89257c0e9c') {
                  staticPath =
                      'assets/Fashion_products/Kids_Fashion/kids_fashion5/1.png';
                } else if (id == '682b00c26977bd89257c0e8e') {
                  staticPath =
                      'assets/Fashion_products/Women_Fashion/women_fashion1/1.png';
                } else if (id == '682b00c26977bd89257c0e8f') {
                  staticPath =
                      'assets/Fashion_products/Women_Fashion/women_fashion2/1.png';
                } else if (id == '682b00c26977bd89257c0e90') {
                  staticPath =
                      'assets/Fashion_products/Women_Fashion/women_fashion3/1.png';
                } else if (id == '682b00c26977bd89257c0e91') {
                  staticPath =
                      'assets/Fashion_products/Women_Fashion/women_fashion4/1.png';
                } else if (id == '682b00c26977bd89257c0e92') {
                  staticPath =
                      'assets/Fashion_products/Women_Fashion/women_fashion5/1.png';
                }
              }
              break;
            case 'beauty':
              if (id.startsWith('682b00d1')) {
                if (id == '682b00d16977bd89257c0e9d') {
                  staticPath = 'assets/beauty_products/makeup_1/1.png';
                } else if (id == '682b00d16977bd89257c0e9e') {
                  staticPath = 'assets/beauty_products/makeup_2/1.png';
                } else if (id == '682b00d16977bd89257c0e9f') {
                  staticPath = 'assets/beauty_products/makeup_3/1.png';
                } else if (id == '682b00d16977bd89257c0ea0') {
                  staticPath = 'assets/beauty_products/makeup_4/1.png';
                } else if (id == '682b00d16977bd89257c0ea1') {
                  staticPath = 'assets/beauty_products/makeup_5/1.png';
                } else if (id == '682b00d16977bd89257c0ea2') {
                  staticPath = 'assets/beauty_products/skincare_1/1.png';
                } else if (id == '682b00d16977bd89257c0ea3') {
                  staticPath = 'assets/beauty_products/skincare_2/1.png';
                } else if (id == '682b00d16977bd89257c0ea4') {
                  staticPath = 'assets/beauty_products/skincare_3/1.png';
                } else if (id == '682b00d16977bd89257c0ea5') {
                  staticPath = 'assets/beauty_products/skincare_4/1.png';
                } else if (id == '682b00d16977bd89257c0ea6') {
                  staticPath = 'assets/beauty_products/skincare_5/1.png';
                } else if (id == '682b00d16977bd89257c0ea7') {
                  staticPath = 'assets/beauty_products/haircare_1/1.png';
                } else if (id == '682b00d16977bd89257c0ea8') {
                  staticPath = 'assets/beauty_products/haircare_2/1.png';
                } else if (id == '682b00d16977bd89257c0ea9') {
                  staticPath = 'assets/beauty_products/haircare_3/1.png';
                } else if (id == '682b00d16977bd89257c0eaa') {
                  staticPath = 'assets/beauty_products/haircare_4/1.png';
                } else if (id == '682b00d16977bd89257c0eab') {
                  staticPath = 'assets/beauty_products/haircare_5/1.png';
                }
              }
              break;
            case 'home':
              if (id.startsWith('681dab0d')) {
                if (id == '681dab0df9c9147444b452cd') {
                  staticPath =
                      'assets/Home_products/furniture/furniture1/1.png';
                } else if (id == '681dab0df9c9147444b452ce') {
                  staticPath =
                      'assets/Home_products/furniture/furniture2/1.png';
                } else if (id == '681dab0df9c9147444b452cf') {
                  staticPath =
                      'assets/Home_products/furniture/furniture3/1.png';
                } else if (id == '681dab0df9c9147444b452d0') {
                  staticPath =
                      'assets/Home_products/furniture/furniture4/1.png';
                } else if (id == '681dab0df9c9147444b452d1') {
                  staticPath =
                      'assets/Home_products/furniture/furniture5/1.png';
                } else if (id == '681dab0df9c9147444b452d2') {
                  staticPath =
                      'assets/Home_products/home-decor/home_decor1/1.png';
                } else if (id == '681dab0df9c9147444b452d3') {
                  staticPath =
                      'assets/Home_products/home-decor/home_decor2/1.png';
                } else if (id == '681dab0df9c9147444b452d4') {
                  staticPath =
                      'assets/Home_products/home-decor/home_decor3/1.png';
                } else if (id == '681dab0df9c9147444b452d5') {
                  staticPath =
                      'assets/Home_products/home-decor/home_decor4/1.png';
                } else if (id == '681dab0df9c9147444b452d6') {
                  staticPath =
                      'assets/Home_products/home-decor/home_decor5/1.png';
                } else if (id == '681dab0df9c9147444b452d7') {
                  staticPath = 'assets/Home_products/kitchen/kitchen1/1.png';
                } else if (id == '681dab0df9c9147444b452d8') {
                  staticPath = 'assets/Home_products/kitchen/kitchen2/1.png';
                } else if (id == '681dab0df9c9147444b452d9') {
                  staticPath = 'assets/Home_products/kitchen/kitchen3/1.png';
                } else if (id == '681dab0df9c9147444b452da') {
                  staticPath = 'assets/Home_products/kitchen/kitchen4/1.png';
                } else if (id == '681dab0df9c9147444b452db') {
                  staticPath = 'assets/Home_products/kitchen/kitchen5/1.png';
                } else if (id == '681dab0df9c9147444b452dc') {
                  staticPath =
                      'assets/Home_products/bath_and_bedding/bath1/1.png';
                } else if (id == '681dab0df9c9147444b452dd') {
                  staticPath =
                      'assets/Home_products/bath_and_bedding/bath2/1.png';
                } else if (id == '681dab0df9c9147444b452de') {
                  staticPath =
                      'assets/Home_products/bath_and_bedding/bath3/1.png';
                } else if (id == '681dab0df9c9147444b452df') {
                  staticPath =
                      'assets/Home_products/bath_and_bedding/bath4/1.png';
                } else if (id == '681dab0df9c9147444b452e0') {
                  staticPath =
                      'assets/Home_products/bath_and_bedding/bath5/1.png';
                }
              }
              break;
            case 'videogames':
              if (id.startsWith('682b00a4')) {
                if (id == '682b00a46977bd89257c0e80') {
                  staticPath =
                      'assets/videogames_products/Consoles/console1/1.png';
                } else if (id == '682b00a46977bd89257c0e81') {
                  staticPath =
                      'assets/videogames_products/Consoles/console2/1.png';
                } else if (id == '682b00a46977bd89257c0e82') {
                  staticPath =
                      'assets/videogames_products/Consoles/console3/1.png';
                } else if (id == '682b00a46977bd89257c0e83') {
                  staticPath =
                      'assets/videogames_products/Consoles/console4/1.png';
                } else if (id == '682b00a46977bd89257c0e84') {
                  staticPath =
                      'assets/videogames_products/Controllers/controller1/1.png';
                } else if (id == '682b00a46977bd89257c0e85') {
                  staticPath =
                      'assets/videogames_products/Controllers/controller2/1.png';
                } else if (id == '682b00a46977bd89257c0e86') {
                  staticPath =
                      'assets/videogames_products/Controllers/controller3/1.png';
                } else if (id == '682b00a46977bd89257c0e87') {
                  staticPath =
                      'assets/videogames_products/Controllers/controller4/1.png';
                } else if (id == '682b00a46977bd89257c0e88') {
                  staticPath =
                      'assets/videogames_products/Controllers/controller5/1.png';
                } else if (id == '682b00a46977bd89257c0e89') {
                  staticPath =
                      'assets/videogames_products/Accessories/accessories1/1.png';
                } else if (id == '682b00a46977bd89257c0e8a') {
                  staticPath =
                      'assets/videogames_products/Accessories/accessories2/1.png';
                } else if (id == '682b00a46977bd89257c0e8b') {
                  staticPath =
                      'assets/videogames_products/Accessories/accessories3/1.png';
                } else if (id == '682b00a46977bd89257c0e8c') {
                  staticPath =
                      'assets/videogames_products/Accessories/accessories4/1.png';
                } else if (id == '682b00a46977bd89257c0e8d') {
                  staticPath =
                      'assets/videogames_products/Accessories/accessories5/1.png';
                }
              }
              break;
            case 'appliances':
              if (id.startsWith('68252918')) {
                if (id == '68252918a68b49cb06164204') {
                  staticPath = 'assets/appliances/product1/1.png';
                } else if (id == '68252918a68b49cb06164205') {
                  staticPath = 'assets/appliances/product2/1.png';
                } else if (id == '68252918a68b49cb06164206') {
                  staticPath = 'assets/appliances/product3/1.png';
                } else if (id == '68252918a68b49cb06164207') {
                  staticPath = 'assets/appliances/product4/1.png';
                } else if (id == '68252918a68b49cb06164208') {
                  staticPath = 'assets/appliances/product5/1.png';
                } else if (id == '68252918a68b49cb06164209') {
                  staticPath = 'assets/appliances/product6/1.png';
                } else if (id == '68252918a68b49cb0616420a') {
                  staticPath = 'assets/appliances/product7/1.png';
                } else if (id == '68252918a68b49cb0616420b') {
                  staticPath = 'assets/appliances/product8/1.png';
                } else if (id == '68252918a68b49cb0616420c') {
                  staticPath = 'assets/appliances/product9/1.png';
                } else if (id == '68252918a68b49cb0616420d') {
                  staticPath = 'assets/appliances/product10/1.png';
                } else if (id == '68252918a68b49cb0616420e') {
                  staticPath = 'assets/appliances/product11/1.png';
                } else if (id == '68252918a68b49cb0616420f') {
                  staticPath = 'assets/appliances/product12/1.png';
                } else if (id == '68252918a68b49cb06164210') {
                  staticPath = 'assets/appliances/product13/1.png';
                } else if (id == '68252918a68b49cb06164211') {
                  staticPath = 'assets/appliances/product14/1.png';
                } else if (id == '68252918a68b49cb06164212') {
                  staticPath = 'assets/appliances/product15/1.png';
                }
              }
              break;
            case 'electronics':
              if (id.startsWith('6819e22b')) {
                if (id == '6819e22b123a4faad16613be') {
                  staticPath =
                      'assets/electronics_products/mobile_and_tablet/mobile_and_tablet1/1.png';
                } else if (id == '6819e22b123a4faad16613bf') {
                  staticPath =
                      'assets/electronics_products/mobile_and_tablet/mobile_and_tablet2/1.png';
                } else if (id == '6819e22b123a4faad16613c0') {
                  staticPath =
                      'assets/electronics_products/mobile_and_tablet/mobile_and_tablet3/1.png';
                } else if (id == '6819e22b123a4faad16613c1') {
                  staticPath =
                      'assets/electronics_products/mobile_and_tablet/mobile_and_tablet4/1.png';
                } else if (id == '6819e22b123a4faad16613c3') {
                  staticPath =
                      'assets/electronics_products/mobile_and_tablet/mobile_and_tablet5/1.png';
                } else if (id == '6819e22b123a4faad16613c4') {
                  staticPath =
                      'assets/electronics_products/tvscreens/tv1/1.png';
                } else if (id == '6819e22b123a4faad16613c5') {
                  staticPath =
                      'assets/electronics_products/tvscreens/tv2/1.png';
                } else if (id == '6819e22b123a4faad16613c6') {
                  staticPath =
                      'assets/electronics_products/tvscreens/tv3/1.png';
                } else if (id == '6819e22b123a4faad16613c7') {
                  staticPath =
                      'assets/electronics_products/tvscreens/tv4/1.png';
                } else if (id == '6819e22b123a4faad16613c8') {
                  staticPath =
                      'assets/electronics_products/tvscreens/tv5/1.png';
                } else if (id == '6819e22b123a4faad16613c9') {
                  staticPath =
                      'assets/electronics_products/Laptop/Laptop1/1.png';
                } else if (id == '6819e22b123a4faad16613ca') {
                  staticPath =
                      'assets/electronics_products/Laptop/Laptop2/1.png';
                } else if (id == '6819e22b123a4faad16613cb') {
                  staticPath =
                      'assets/electronics_products/Laptop/Laptop3/1.png';
                } else if (id == '6819e22b123a4faad16613cc') {
                  staticPath =
                      'assets/electronics_products/Laptop/Laptop4/1.png';
                } else if (id == '6819e22b123a4faad16613cd') {
                  staticPath =
                      'assets/electronics_products/Laptop/Laptop5/1.png';
                }
              }
              break;
            default:
              staticPath = 'assets/products/default.png';
          }
          if (staticPath != null) {
            imagePaths = [staticPath];
          }
        }
      }

      final product = ProductsViewsModel.fromJson({
        ...productData,
        'id': productId,
        'title':
            productData['title'] ?? productData['name'] ?? 'Unnamed Product',
        'price': productData['price'] ?? 0.0,
        'imagePaths': imagePaths,
        'category': productData['category'] ?? 'general',
      });

      return CartItemModel(
        product: product,
        quantity: quantity is int ? quantity : int.parse(quantity.toString()),
      );
    } catch (e, stackTrace) {
      dev.log('Error creating CartItemModel: $e\n$stackTrace',
          name: 'CartItemModel', error: e);
      rethrow;
    }
  }
}
