// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchListModel _$BranchListModelFromJson(Map<String, dynamic> json) =>
    BranchListModel(
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

Map<String, dynamic> _$BranchListModelToJson(BranchListModel instance) =>
    <String, dynamic>{
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
