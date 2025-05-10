import 'package:flutter/material.dart';
import 'package:pickpay/features/categories_pages/models/product_model.dart';
import 'package:pickpay/features/categories_pages/products_views/product_detail_view.dart';

class HomeProduct10 extends StatelessWidget {
  const HomeProduct10({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductsViewsModel(
      id: 'home10',
      title:
          "oliruim Black Home Decor Accent Art Woman face Statue Collectible Statue for Modern Home Living Room Bookshelf Black Desk Decor 2 Pieces Set",
      imagePaths: [
        'assets/Home_products/home-decor/home_decor5/1.png',
        'assets/Home_products/home-decor/home_decor5/2.png',
        'assets/Home_products/home-decor/home_decor5/3.png',
        'assets/Home_products/home-decor/home_decor5/4.png',
      ],
      price: 400.00,
      originalPrice: 450.00,
      rating: 4.3,
      reviewCount: 43,
      colorOptions: ['2 Pcs Black'],
      colorAvailability: {'2 Pcs Black': true},
      brand: 'oliruim',
      theme: 'Family',
      dimensions: '5.1D x 5.8W x 16.7H centimeters',
      material: 'Resin',
      style: 'Art Deco',
      occasion: 'Housewarming',
      recommendedUsesForProduct: 'Home',
      mountingType: 'Tabletop',
      subjectCharacter: 'Thinking Woman Statue',
      aboutThisItem:
          '''Design Concept: Art comes from life, each different pattern design comes from the artisan's careful observation of life. Abstract art design, clear layers, simple and clear lines, strong three-dimensional sense, strong texture, it all has a good charm, and is a good choice to enhance the taste of home decoration

Material & Dimensions: The abstract art black gold female face statues are made of resin. This set of 2 features different poses, each approximately 6.3 inches (16 cm) in height and 2.3 inches (6 cm) in length. Place these beautiful statues in your living room, on your bookshelf, or on a shelf, and they will surely catch the eye and become a focal point of your decor

Black and Gold Decor: Statue of abstract thinkers This combined thinker face sculpture is suitable for many places, such astv stand decor for living room, bedrooms, bookshelves, wall decor shelves, decorative books, offices, for home decoration. To play the role of art, it will be the ideal filling

Gift Selection: This abstract lady face sculpture can be an ideal choice for a good friend, family member, lover and so on. It is also an ideal gift choice for Christmas, Valentine's Day, Mother's Day, Father's Day and other holidays. Meaningful art collection statue, it will amaze and impress others

After-Sales Service: We are committed to providing high-quality products and excellent service to every customer. Your satisfaction is our priority. If you have any concerns about our facial sculpture set, please don't hesitate to contact us, and we will work with you to address your needs''',
      deliveryDate: 'Sunday, 9 March',
      deliveryTimeLeft: '20hrs 36 mins',
      deliveryLocation: 'Egypt',
      inStock: true,
      shipsFrom: 'Pickpay',
      soldBy: 'Pickpay',
    );

    return ProductDetailView(product: product);
  }
}
