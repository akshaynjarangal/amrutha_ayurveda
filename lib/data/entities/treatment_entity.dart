class TreatmentEntity {
  final String name;
  final int id;
  final int maleCount;
  final int femaleCount;

  TreatmentEntity({
    required this.name,
    required this.id,
    required this.maleCount,
    required this.femaleCount,
  });

  TreatmentEntity copyWith({
    String? name,
    int? id,
    int? maleCount,
    int? femaleCount,
  }) {
    return TreatmentEntity(
      name: name ?? this.name,
      id: id ?? this.id,
      maleCount: maleCount ?? this.maleCount,
      femaleCount: femaleCount ?? this.femaleCount,
    );
  }
}
