import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppUrls {
  static const String domain = "flutter-amr.noviindus.in";
  static const String basePath = "/api";
  static const String loginEndPoint = "$basePath/Login";
  static const String patientListEndPoint = "$basePath/PatientList";
}

const storage = FlutterSecureStorage();