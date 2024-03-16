// To parse this JSON data, do
//
//     final treatmentsListModel = treatmentsListModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'treatments_list_model.g.dart';

List<TreatmentsListModel> treatmentsListModelFromJson(String str) => List<TreatmentsListModel>.from(json.decode(str).map((x) => TreatmentsListModel.fromJson(x)));

String treatmentsListModelToJson(List<TreatmentsListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class TreatmentsListModel {
    @JsonKey(name: "id")
    final int? id;
    @JsonKey(name: "branches")
    final List<Branch>? branches;
    @JsonKey(name: "name")
    final String? name;
    @JsonKey(name: "duration")
    final String? duration;
    @JsonKey(name: "price")
    final String? price;
    @JsonKey(name: "is_active")
    final bool? isActive;
    @JsonKey(name: "created_at")
    final DateTime? createdAt;
    @JsonKey(name: "updated_at")
    final DateTime? updatedAt;

    TreatmentsListModel({
        this.id,
        this.branches,
        this.name,
        this.duration,
        this.price,
        this.isActive,
        this.createdAt,
        this.updatedAt,
    });

    TreatmentsListModel copyWith({
        int? id,
        List<Branch>? branches,
        String? name,
        String? duration,
        String? price,
        bool? isActive,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        TreatmentsListModel(
            id: id ?? this.id,
            branches: branches ?? this.branches,
            name: name ?? this.name,
            duration: duration ?? this.duration,
            price: price ?? this.price,
            isActive: isActive ?? this.isActive,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory TreatmentsListModel.fromJson(Map<String, dynamic> json) => _$TreatmentsListModelFromJson(json);

    Map<String, dynamic> toJson() => _$TreatmentsListModelToJson(this);
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
