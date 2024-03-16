import 'dart:developer';

import 'package:ayurveda/data/models/patient_list_model.dart';
import 'package:ayurveda/domain/usecases/patient_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@injectable
class PatientProvider extends ChangeNotifier {
  final PatientUseCase _patientUseCase;
  PatientProvider({required PatientUseCase patientUseCase}) : _patientUseCase = patientUseCase;


  List<PatientListModel> get patients => _patients;
  List<PatientListModel> _patients = [];

  set patients(List<PatientListModel> value) {
    _patients = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }


  Future<void> fetchPatients() async {
    isLoading = true;
    final res = await _patientUseCase.getPatients;
    res.fold((l) {
      isLoading = false;
      log("Error: $l");
    }, (r) {
      patients = r;
      isLoading = false;
    });
    notifyListeners();
  }
}