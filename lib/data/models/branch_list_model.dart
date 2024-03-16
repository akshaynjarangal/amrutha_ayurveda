// To parse this JSON data, do
//
//     final branchListModel = branchListModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'branch_list_model.g.dart';

List<BranchListModel> branchListModelFromJson(String str) => List<BranchListModel>.from(json.decode(str).map((x) => BranchListModel.fromJson(x)));

String branchListModelToJson(List<BranchListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class BranchListModel {
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

    BranchListModel({
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

    BranchListModel copyWith({
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
        BranchListModel(
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

    factory BranchListModel.fromJson(Map<String, dynamic> json) => _$BranchListModelFromJson(json);

    Map<String, dynamic> toJson() => _$BranchListModelToJson(this);
}
