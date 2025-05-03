class CartItemModel {
  final String id;
  final String title;
  final double price;
  final String imagePath;
  final int quantity;

  CartItemModel({
    required this.id,
    required this.title,
    required this.price,
    required this.imagePath,
    required this.quantity,
  });

  // Convert CartItemModel to CartItem JSON format
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      imagePath: json['imagePath'],
      quantity: json['quantity'],
    );
  }

  // Convert CartItem JSON format to CartItemModel
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'imagePath': imagePath,
      'quantity': quantity,
    };
  }
}
