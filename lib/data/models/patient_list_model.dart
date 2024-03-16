// To parse this JSON data, do
//
//     final patientListModel = patientListModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'patient_list_model.g.dart';

List<PatientListModel> patientListModelFromJson(String str) => List<PatientListModel>.from(json.decode(str).map((x) => PatientListModel.fromJson(x)));

String patientListModelToJson(List<PatientListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class PatientListModel {
    @JsonKey(name: "id")
    final int? id;
    @JsonKey(name: "patientdetails_set")
    final List<PatientdetailsSet>? patientdetailsSet;
    @JsonKey(name: "branch")
    final Branch? branch;
    @JsonKey(name: "user")
    final String? user;
    @JsonKey(name: "payment")
    final String? payment;
    @JsonKey(name: "name")
    final String? name;
    @JsonKey(name: "phone")
    final String? phone;
    @JsonKey(name: "address")
    final String? address;
    @JsonKey(name: "price")
    final dynamic price;
    @JsonKey(name: "total_amount")
    final int? totalAmount;
    @JsonKey(name: "discount_amount")
    final int? discountAmount;
    @JsonKey(name: "advance_amount")
    final int? advanceAmount;
    @JsonKey(name: "balance_amount")
    final int? balanceAmount;
    @JsonKey(name: "date_nd_time")
    final DateTime? dateNdTime;
    @JsonKey(name: "is_active")
    final bool? isActive;
    @JsonKey(name: "created_at")
    final DateTime? createdAt;
    @JsonKey(name: "updated_at")
    final DateTime? updatedAt;

    PatientListModel({
        this.id,
        this.patientdetailsSet,
        this.branch,
        this.user,
        this.payment,
        this.name,
        this.phone,
        this.address,
        this.price,
        this.totalAmount,
        this.discountAmount,
        this.advanceAmount,
        this.balanceAmount,
        this.dateNdTime,
        this.isActive,
        this.createdAt,
        this.updatedAt,
    });

    PatientListModel copyWith({
        int? id,
        List<PatientdetailsSet>? patientdetailsSet,
        Branch? branch,
        String? user,
        String? payment,
        String? name,
        String? phone,
        String? address,
        dynamic price,
        int? totalAmount,
        int? discountAmount,
        int? advanceAmount,
        int? balanceAmount,
        DateTime? dateNdTime,
        bool? isActive,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        PatientListModel(
            id: id ?? this.id,
            patientdetailsSet: patientdetailsSet ?? this.patientdetailsSet,
            branch: branch ?? this.branch,
            user: user ?? this.user,
            payment: payment ?? this.payment,
            name: name ?? this.name,
            phone: phone ?? this.phone,
            address: address ?? this.address,
            price: price ?? this.price,
            totalAmount: totalAmount ?? this.totalAmount,
            discountAmount: discountAmount ?? this.discountAmount,
            advanceAmount: advanceAmount ?? this.advanceAmount,
            balanceAmount: balanceAmount ?? this.balanceAmount,
            dateNdTime: dateNdTime ?? this.dateNdTime,
            isActive: isActive ?? this.isActive,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory PatientListModel.fromJson(Map<String, dynamic> json) => _$PatientListModelFromJson(json);

    Map<String, dynamic> toJson() => _$PatientListModelToJson(this);
}

@JsonSerializable()
class Branch {
    @JsonKey(name: "id")
    final int? id;
    @JsonKey(name: "name")
    final String? name;
    @JsonKey(name: "patients_count")
    final int? patientsCount;
    @JsonKey(name: "location")
    final String? location;
    @JsonKey(name: "phone")
    final String? phone;
    @JsonKey(name: "mail")
    final String? mail;
    @JsonKey(name: "address")
    final String? address;
    @JsonKey(name: "gst")
    final String? gst;
    @JsonKey(name: "is_active")
    final bool? isActive;

    Branch({
        this.id,
        this.name,
        this.patientsCount,
        this.location,
        this.phone,
        this.mail,
        this.address,
        this.gst,
        this.isActive,
    });

    Branch copyWith({
        int? id,
        String? name,
        int? patientsCount,
        String? location,
        String? phone,
        String? mail,
        String? address,
        String? gst,
        bool? isActive,
    }) => 
        Branch(
            id: id ?? this.id,
            name: name ?? this.name,
            patientsCount: patientsCount ?? this.patientsCount,
            location: location ?? this.location,
            phone: phone ?? this.phone,
            mail: mail ?? this.mail,
            address: address ?? this.address,
            gst: gst ?? this.gst,
            isActive: isActive ?? this.isActive,
        );

    factory Branch.fromJson(Map<String, dynamic> json) => _$BranchFromJson(json);

    Map<String, dynamic> toJson() => _$BranchToJson(this);
}

@JsonSerializable()
class PatientdetailsSet {
    @JsonKey(name: "id")
    final int? id;
    @JsonKey(name: "male")
    final String? male;
    @JsonKey(name: "female")
    final String? female;
    @JsonKey(name: "patient")
    final int? patient;
    @JsonKey(name: "treatment")
    final int? treatment;
    @JsonKey(name: "treatment_name")
    final String? treatmentName;

    PatientdetailsSet({
        this.id,
        this.male,
        this.female,
        this.patient,
        this.treatment,
        this.treatmentName,
    });

    PatientdetailsSet copyWith({
        int? id,
        String? male,
        String? female,
        int? patient,
        int? treatment,
        String? treatmentName,
    }) => 
        PatientdetailsSet(
            id: id ?? this.id,
            male: male ?? this.male,
            female: female ?? this.female,
            patient: patient ?? this.patient,
            treatment: treatment ?? this.treatment,
            treatmentName: treatmentName ?? this.treatmentName,
        );

    factory PatientdetailsSet.fromJson(Map<String, dynamic> json) => _$PatientdetailsSetFromJson(json);

    Map<String, dynamic> toJson() => _$PatientdetailsSetToJson(this);
}
