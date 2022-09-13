import 'dart:convert';

import 'package:falemais_app_flutter/model/product_model.dart';

class Interprise {
  int id;
  String name;
  Product product;
  Interprise({
   this.id,
    this.name,
    this.product,
  });

  Interprise copyWith({
    int id,
    String name,
    Product product,
  }) {
    return Interprise(
      id: id ?? this.id,
      name: name ?? this.name,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'product': product.toMap()});
  
    return result;
  }

  factory Interprise.fromMap(Map<String, dynamic> map) {
    return Interprise(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      product: Product.fromMap(map['product']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Interprise.fromJson(String source) => Interprise.fromMap(json.decode(source));

  @override
  String toString() => 'Interprise(id: $id, name: $name, product: $product)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Interprise &&
      other.id == id &&
      other.name == name &&
      other.product == product;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ product.hashCode;
}
