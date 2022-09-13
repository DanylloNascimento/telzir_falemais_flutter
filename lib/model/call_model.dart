import 'dart:convert';

class Call {
  String origin;
  String destiny;
  double tariff;
  Call({
    this.origin,
    this.destiny,
    this.tariff,
  });

  Call copyWith({
    String origin,
    String destiny,
    double tariff,
  }) {
    return Call(
      origin: origin ?? this.origin,
      destiny: destiny ?? this.destiny,
      tariff: tariff ?? this.tariff,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'origin': origin});
    result.addAll({'destiny': destiny});
    result.addAll({'tariff': tariff});

    return result;
  }

  factory Call.fromMap(Map<String, dynamic> map) {
    return Call(
      origin: map['origin'] ?? '',
      destiny: map['destiny'] ?? '',
      tariff: map['tariff']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Call.fromJson(String source) => Call.fromMap(json.decode(source));

  @override
  String toString() =>
      'Call(origin: $origin, destiny: $destiny, tariff: $tariff)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Call &&
        other.origin == origin &&
        other.destiny == destiny &&
        other.tariff == tariff;
  }

  @override
  int get hashCode => origin.hashCode ^ destiny.hashCode ^ tariff.hashCode;
}
