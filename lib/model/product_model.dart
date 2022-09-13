import 'dart:convert';

import 'package:flutter/foundation.dart';

class Product {
  int id;
  String name;
  Map<String, int> plan;
  Product({
    this.id,
    this.name,
    this.plan,
  });

  Product copyWith({
    int id,
    String name,
    Map<String, int> plan,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      plan: plan ?? this.plan,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'plan': plan});

    return result;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      plan: Map<String, int>.from(map['plan']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() => 'Product(id: $id, name: $name, plan: $plan)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.name == name &&
        mapEquals(other.plan, plan);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ plan.hashCode;
}
