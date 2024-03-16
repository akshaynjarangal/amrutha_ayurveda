import 'package:ayurveda/core/constants.dart';
import 'package:ayurveda/data/models/patient_list_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

abstract class PatientRepository {
  Future<Either<String, List<PatientListModel>>> get getPatientList;
}

@LazySingleton(as: PatientRepository)
class PatientRepositoryImpl implements PatientRepository {
  @override
  Future<Either<String, List<PatientListModel>>> get getPatientList async {
    try {
      final url = Uri.https(AppUrls.domain, AppUrls.loginEndPoint);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = await compute(patientListModelFromJson, response.body);
        return right(data);
      } 
      if(response.statusCode == 401){
        return left("Unauthorized request");
      }
      else {
        return left(response.body);
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}