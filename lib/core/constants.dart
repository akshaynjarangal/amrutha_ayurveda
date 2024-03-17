import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppUrls {
  static const String domain = "flutter-amr.noviindus.in";
  static const String basePath = "/api";
  static const String loginEndPoint = "$basePath/Login";
  static const String patientListEndPoint = "$basePath/PatientList";
  static const String branchListEndPoint = "$basePath/BranchList";
  static const String treatmentsListEndPoint = "$basePath/TreatmentList";
  static const String patientUpdateEndPoint = "$basePath/PatientUpdate";
}

const storage = FlutterSecureStorage();

final kNavigationKey = GlobalKey<NavigatorState>();