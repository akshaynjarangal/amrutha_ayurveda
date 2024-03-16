import 'dart:developer';

import 'package:ayurveda/data/models/branch_list_model.dart';
import 'package:ayurveda/domain/usecases/patient_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegistrationProvider extends ChangeNotifier {
  final PatientUseCase _patientUseCase;
  RegistrationProvider({required PatientUseCase patientUseCase})
      : _patientUseCase = patientUseCase;

  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<BranchListModel> _branches = [];
  List<BranchListModel> get branches => _branches;

  set branches(List<BranchListModel> value) {
    _branches = value;
    notifyListeners();
  }

  String _errorMessage = "";
  String get errorMessage => _errorMessage;
  
  set errorMessage(String value) {
    _errorMessage = value;
    notifyListeners();
  }



  Future<void> fetchBranches() async {
    isLoading = true;
    final res = await _patientUseCase.getBranches;
    res.fold((l) {
      isLoading = false;
      errorMessage  = "Error occured while fetching branches";
      log("Error: $l");
    }, (r) {
      branches = r;
      isLoading = false;
    });
    notifyListeners();
  }
}
