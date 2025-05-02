import 'package:flutter/material.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/widgets/custom_app.dart';
import 'package:pickpay/features/categories_pages/widgets/product_card.dart';

class AppliancesViewBody extends StatelessWidget {
  const AppliancesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Appliances'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          SizedBox(height: kTopPadding),
          // product 1
          ProductCard(
            name:
                'Koldair Water Dispenser Cold And Hot 2 Tabs - Bottom Load KWDB Silver Cooler',
            imagePaths: [
              'assets/appliances/product1/1.png',
              'assets/appliances/product1/2.png',
              'assets/appliances/product1/3.png',
            ],
            price: 10499,
            originalPrice: 11999,
            rating: 4.9,
            reviewCount: 1893,
          ),
          SizedBox(height: 10),
          // product 2
          ProductCard(
            name: 'Fresh Jumbo Stainless Steel Potato CB90"',
            imagePaths: [
              'assets/appliances/product2/1.png',
            ],
            price: 1099.00,
            originalPrice: 1299.00,
            rating: 4.8,
            reviewCount: 2762,
          ),
          SizedBox(height: 10),

          // product 3
          ProductCard(
            name:
                'Midea Refrigerator 449L 2D TMF MDRT645MTE06E Inverter Quattro, No Frost, Cooling Box, Multi-Air Flow, Active-C Fresh, Humidity Control Silver',
            imagePaths: [
              'assets/appliances/product3/1.png',
              'assets/appliances/product3/2.png',
              'assets/appliances/product3/3.png',
            ],
            price: 26999,
            originalPrice: 28000,
            rating: 4.7,
            reviewCount: 1542,
          ),
          SizedBox(height: 10),

          // product 4
          ProductCard(
            name:
                'Zanussi Automatic Washing Machine, Silver, 8 KG - ZWF8240SX5r',
            imagePaths: [
              'assets/appliances/product4/1.png',
            ],
            price: 17023,
            originalPrice: 19000,
            rating: 4.9,
            reviewCount: 3120,
          ),
          SizedBox(height: 10),

          // product 5
          ProductCard(
            name:
                'Midea Dishwasher - WQP13-5201C-S - 6 programs - Free standing - 13 Place set - Silver',
            imagePaths: [
              'assets/appliances/product5/1.png',
              'assets/appliances/product5/2.png',
              'assets/appliances/product5/3.png',
              'assets/appliances/product5/4.png',
            ],
            price: 15699,
            originalPrice: 16000,
            rating: 4.8,
            reviewCount: 2123,
          ),
          SizedBox(height: 10),

          // product 6
          ProductCard(
            name:
                'deime Air Fryer 6.2 Quart, Large Air Fryer for Families, 5 Cooking Functions AirFryer, 400°F Temp Controls in 5° Increments, Ceramic Coated Nonstick',
            imagePaths: [
              'assets/appliances/product6/1.png',
              'assets/appliances/product6/2.png',
              'assets/appliances/product6/3.png',
            ],
            price: 3629,
            originalPrice: 4000,
            rating: 4.5,
            reviewCount: 954,
          ),
          SizedBox(height: 10),

          // product 7
          ProductCard(
            name: 'Black & Decker DCM25N-B5 Coffee Maker, Black - 1 Cup',
            imagePaths: [
              'assets/appliances/product7/1.png',
              'assets/appliances/product7/2.png',
              'assets/appliances/product7/3.png',
            ],
            price: 930,
            originalPrice: 1200,
            rating: 4.7,
            reviewCount: 1288,
          ),
          SizedBox(height: 10),

          // product 8
          ProductCard(
            name:
                'Black & Decker 1050W 2-Slice Stainless Steel Toaster, Silver/Black',
            imagePaths: [
              'assets/appliances/product8/1.png',
              'assets/appliances/product8/2.png',
              'assets/appliances/product8/3.png',
            ],
            price: 2540,
            originalPrice: 2760,
            rating: 4.6,
            reviewCount: 884,
          ),
          SizedBox(height: 10),

          // product 9
          ProductCard(
            name:
                'Panasonic Powerful Steam/Dry Iron, 1800W, NI-M300TVTD- 1 Year Warranty',
            imagePaths: [
              'assets/appliances/product9/1.png',
            ],
            price: 10499,
            originalPrice: 11000,
            rating: 4.8,
            reviewCount: 1193,
          ),
          SizedBox(height: 10),

          // product 10
          ProductCard(
            name: 'Fresh 1600W Faster Vacuum Cleaner with Bag, Black',
            imagePaths: [
              'assets/appliances/product10/1.png',
            ],
            price: 2830,
            originalPrice: 3100,
            rating: 4.6,
            reviewCount: 4576,
          ),
          SizedBox(height: 10),

          // product 11
          ProductCard(
            name:
                'Fresh fan 50 watts 18 inches with charger with 3 blades, black and white',
            imagePaths: [
              'assets/appliances/product11/1.png',
            ],
            price: 3983,
            originalPrice: 4200,
            rating: 4.4,
            reviewCount: 674,
          ),
          SizedBox(height: 10),

          // product 12
          ProductCard(
            name:
                'TORNADO Gas Water Heater 6 Liter, Digital, Natural Gas, Silver GHM-C06CNE-S',
            imagePaths: [
              'assets/appliances/product12/1.png',
              'assets/appliances/product12/2.png',
            ],
            price: 3719,
            originalPrice: 3900,
            rating: 4.8,
            reviewCount: 2285,
          ),
          SizedBox(height: 10),

          // product 13
          ProductCard(
            name:
                'Black & Decker 500W 1.5L Blender with Grinder Mill, White - BX520-B5',
            imagePaths: [
              'assets/appliances/product13/1.png',
              'assets/appliances/product13/2.png',
              'assets/appliances/product13/3.png',
              'assets/appliances/product13/4.png',
              'assets/appliances/product13/5.png',
            ],
            price: 1299,
            originalPrice: 1450,
            rating: 4.9,
            reviewCount: 1439,
          ),
          SizedBox(height: 10),

          // product 14
          ProductCard(
            name:
                'Black & Decker 1.7L Concealed Coil Stainless Steel Kettle, Jc450-B5, Silver',
            imagePaths: [
              'assets/appliances/product14/1.png',
              'assets/appliances/product14/2.png',
              'assets/appliances/product14/3.png',
              'assets/appliances/product14/4.png',
              'assets/appliances/product14/5.png',
              'assets/appliances/product14/6.png',
            ],
            price: 1594,
            originalPrice: 1730,
            rating: 4.5,
            reviewCount: 1162,
          ),
          SizedBox(height: 10),

          // product 15
          ProductCard(
            name:
                'BLACK & DECKER Dough Mixer With 1000W 3-Blade Motor And 4L Stainless Steel Mixer For 600G Dough Mixer 5.76 Kilograms White/Sliver',
            imagePaths: [
              'assets/appliances/product15/1.png',
              'assets/appliances/product15/2.png',
              'assets/appliances/product15/3.png',
            ],
            price: 6799,
            originalPrice: 6978,
            rating: 4.6,
            reviewCount: 1735,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
