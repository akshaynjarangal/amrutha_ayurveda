import 'dart:convert';
import 'dart:developer';

import 'package:ayurveda/core/constants.dart';
import 'package:ayurveda/data/models/branch_list_model.dart';
import 'package:ayurveda/data/models/patient_list_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

abstract class PatientRepository {
  Future<Either<String, List<PatientListModel>>> get getPatientList;

  Future<Either<String, List<BranchListModel>>> get getBranchList;
}

@LazySingleton(as: PatientRepository)
class PatientRepositoryImpl implements PatientRepository {
  @override
  Future<Either<String, List<PatientListModel>>> get getPatientList async {
    try {
      log("Get Patient List");
      final token = await storage.read(key: "token");
      final url = Uri.https(AppUrls.domain, AppUrls.patientListEndPoint);
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        final decode = jsonDecode(response.body);
        final data = await compute(
          patientListModelFromJson,
          jsonEncode(decode["patient"]),
        );
        return right(data);
      }
      if (response.statusCode == 401) {
        return left("Unauthorized request");
      } else {
        return left(response.body);
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<BranchListModel>>> get getBranchList async {
    try {
      final token = await storage.read(key: "token");
      final url = Uri.https(AppUrls.domain, AppUrls.branchListEndPoint);
      final res = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      if (res.statusCode == 200) {
        final decode = jsonDecode(res.body);
        final data = await compute(
          branchListModelFromJson,
          jsonEncode(decode["branches"]),
        );
        return right(data);
      }
      if (res.statusCode == 401) {
        return left("Unauthorized request");
      } else {
        return left(res.body);
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}
