class ProductLinkGenerator {
  static String generateProductLink(String productId) {
    // Use your actual domain or Firebase Dynamic Link
    return 'https://pickpay.com/products/$productId';

    // For Firebase Dynamic Links:
    // return 'https://pickpay.page.link/?link=https://pickpay.com/products/$productId&apn=com.your.package';
  }
}
