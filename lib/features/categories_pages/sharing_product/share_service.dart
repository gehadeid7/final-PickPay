import 'package:pickpay/features/categories_pages/sharing_product/product_link_generator.dart';
import 'package:share_plus/share_plus.dart';

class ShareService {
  static Future<void> shareProduct({
    required String title,
    required String price,
    required String productId,
  }) async {
    final link = ProductLinkGenerator.generateProductLink(productId);
    final text = 'Check out "$title" on PickPay!\nPrice: \$$price\n$link';

    await Share.share(
      text,
      subject: 'Look at this product!',
    );
  }
}
