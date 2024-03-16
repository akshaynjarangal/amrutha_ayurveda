// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatments_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreatmentsListModel _$TreatmentsListModelFromJson(Map<String, dynamic> json) =>
    TreatmentsListModel(
      id: json['id'] as int?,
      branches: (json['branches'] as List<dynamic>?)
          ?.map((e) => Branch.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
      duration: json['duration'] as String?,
      price: json['price'] as String?,
      isActive: json['is_active'] as bool?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$TreatmentsListModelToJson(
  TreatmentsListModel instance,
) =>
    <String, dynamic>{
      'id': instance.id,
      'branches': instance.branches,
      'name': instance.name,
      'duration': instance.duration,
      'price': instance.price,
      'is_active': instance.isActive,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

Branch _$BranchFromJson(Map<String, dynamic> json) => Branch(
      id: json['id'] as int?,
      name: json['name'] as String?,
      patientsCount: json['patients_count'] as int?,
      location: json['location'] as String?,
      phone: json['phone'] as String?,
      mail: json['mail'] as String?,
      address: json['address'] as String?,
      gst: json['gst'] as String?,
      isActive: json['is_active'] as bool?,
    );

Map<String, dynamic> _$BranchToJson(Branch instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'patients_count': instance.patientsCount,
      'location': instance.location,
      'phone': instance.phone,
      'mail': instance.mail,
      'address': instance.address,
      'gst': instance.gst,
      'is_active': instance.isActive,
    };
