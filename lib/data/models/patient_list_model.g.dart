// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientListModel _$PatientListModelFromJson(Map<String, dynamic> json) =>
    PatientListModel(
      id: json['id'] as int?,
      patientdetailsSet: (json['patientdetails_set'] as List<dynamic>?)
          ?.map((e) => PatientdetailsSet.fromJson(e as Map<String, dynamic>))
          .toList(),
      branch: json['branch'] == null
          ? null
          : Branch.fromJson(json['branch'] as Map<String, dynamic>),
      user: json['user'] as String?,
      payment: json['payment'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      price: json['price'],
      totalAmount: json['total_amount'] as int?,
      discountAmount: json['discount_amount'] as int?,
      advanceAmount: json['advance_amount'] as int?,
      balanceAmount: json['balance_amount'] as int?,
      dateNdTime: json['date_nd_time'] == null
          ? null
          : DateTime.parse(json['date_nd_time'] as String),
      isActive: json['is_active'] as bool?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$PatientListModelToJson(PatientListModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patientdetails_set': instance.patientdetailsSet,
      'branch': instance.branch,
      'user': instance.user,
      'payment': instance.payment,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address,
      'price': instance.price,
      'total_amount': instance.totalAmount,
      'discount_amount': instance.discountAmount,
      'advance_amount': instance.advanceAmount,
      'balance_amount': instance.balanceAmount,
      'date_nd_time': instance.dateNdTime?.toIso8601String(),
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

PatientdetailsSet _$PatientdetailsSetFromJson(Map<String, dynamic> json) =>
    PatientdetailsSet(
      id: json['id'] as int?,
      male: json['male'] as String?,
      female: json['female'] as String?,
      patient: json['patient'] as int?,
      treatment: json['treatment'] as int?,
      treatmentName: json['treatment_name'] as String?,
    );

Map<String, dynamic> _$PatientdetailsSetToJson(PatientdetailsSet instance) =>
    <String, dynamic>{
      'id': instance.id,
      'male': instance.male,
      'female': instance.female,
      'patient': instance.patient,
      'treatment': instance.treatment,
      'treatment_name': instance.treatmentName,
    };
