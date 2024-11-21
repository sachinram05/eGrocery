import 'dart:convert';

class Product {
  Product({required this.id,required this.name, required this.moq,required this.price,required this.discountedPrice});

  final int id;
  final String name;
  final int moq;
  final double price;
  final double discountedPrice;

  Product copyWith({int? id,String? name,int? moq,double? price,double? discountedPrice}) {
    return Product(id: id ?? this.id,name: name ?? this.name,moq: moq ?? this.moq,price: price ?? this.price,discountedPrice: discountedPrice ?? this.discountedPrice);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id,'name': name,'moq': moq,'price': price,'discountedPrice': discountedPrice};
  }

  factory Product.fromMap(Map<dynamic, dynamic> map) {
    return Product(id: int.tryParse(map['id']) as int,name: map['name'] as String,moq: int.tryParse(map['moq']) as int,price: double.tryParse(map['price']) as double,discountedPrice: double.tryParse(map['discounted_price']) as double);
  }

  String toJson() => json.encode(toMap());
  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
