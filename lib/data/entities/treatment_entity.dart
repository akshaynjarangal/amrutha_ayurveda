class TreatmentEntity {
  final String name;
  final int id;
  final int maleCount;
  final int femaleCount;
  final String price;

  TreatmentEntity({
    required this.name,
    required this.id,
    required this.maleCount,
    required this.femaleCount,
    required this.price,
  });

  num get totalAmount => num.parse(price) * (maleCount + femaleCount);

  TreatmentEntity copyWith({
    String? name,
    int? id,
    int? maleCount,
    int? femaleCount,
    String? price,
  }) {
    return TreatmentEntity(
      name: name ?? this.name,
      id: id ?? this.id,
      maleCount: maleCount ?? this.maleCount,
      femaleCount: femaleCount ?? this.femaleCount,
      price: price ?? this.price,
    );
  }
}
