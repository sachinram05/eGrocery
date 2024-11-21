class CartModel {
  CartModel({required this.vegetableId,required this.vegetableName,required this.vegetableImage,required this.vegetablePrice,required this.quantity});

  final int vegetableId;
  final String vegetableName;
  final String vegetableImage;
  final double vegetablePrice;
  final int quantity;

  CartModel copyWith({int? quantity}) {
    return CartModel(vegetableId: vegetableId,vegetableName: vegetableName,vegetableImage: vegetableImage,vegetablePrice: vegetablePrice,quantity: quantity ?? this.quantity);
  }
}
