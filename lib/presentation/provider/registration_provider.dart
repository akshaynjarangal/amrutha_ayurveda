import 'dart:developer';

import 'package:ayurveda/data/entities/treatment_entity.dart';
import 'package:ayurveda/data/models/branch_list_model.dart';
import 'package:ayurveda/data/models/treatments_list_model.dart';
import 'package:ayurveda/domain/usecases/patient_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  List<TreatmentsListModel> _treatments = [];

  List<TreatmentsListModel> get treatments => _treatments;

  set treatments(List<TreatmentsListModel> value) {
    _treatments = value;
    notifyListeners();
  }

  Future<void> fetchBranches() async {
    final res = await _patientUseCase.getBranches;
    res.fold((l) {
      errorMessage = "Error occured while fetching branches";
      log("Error: $l");
    }, (r) {
      branches = r;
      log("Branches: $r");
    });
    notifyListeners();
  }

  List<String> keralaDistricts = [
    "Alappuzha",
    "Ernakulam",
    "Idukki",
    "Kannur",
    "Kasaragod",
    "Kollam",
    "Kottayam",
    "Kozhikode",
    "Malappuram",
    "Palakkad",
    "Pathanamthitta",
    "Thiruvananthapuram",
    "Thrissur",
    "Wayanad",
  ];

  Future<void> fetchTreatment() async {
    final res = await _patientUseCase.getTreatments;
    res.fold((l) {
      log("Error: $l");
    }, (r) {
      treatments = r;
      log("Treatments: $r");
    });
    notifyListeners();
  }

  int _maleCount = 0;
  int get maleCount => _maleCount;

  int _femaleCount = 0;
  int get femaleCount => _femaleCount;

  void incrementMaleCount() {
    _maleCount++;
    notifyListeners();
  }

  set setMaleCount(int value) {
    _maleCount = value;
    notifyListeners();
  }

  void decrementMaleCount() {
    if (_maleCount > 0) {
      _maleCount--;
      notifyListeners();
    }
  }

  void incrementFemaleCount() {
    _femaleCount++;
    notifyListeners();
  }

  set setFemaleCount(int value) {
    _femaleCount = value;
    notifyListeners();
  }

  void decrementFemaleCount() {
    if (_femaleCount > 0) {
      _femaleCount--;
      notifyListeners();
    }
  }

  final List<TreatmentEntity> _selectedTreatments = [];

  List<TreatmentEntity> get selectedTreatments => _selectedTreatments;

  TreatmentsListModel? _selectedTreatment;

  TreatmentsListModel? get selectedTreatmentDropDown => _selectedTreatment;

  set selectedTreatment(TreatmentsListModel value) {
    _selectedTreatment = value;
    notifyListeners();
  }

  set onChangeTreatmentSelection(TreatmentEntity value) {}

  void addToSelectedTreatments() {
    if (_selectedTreatment != null) {
      final list = _selectedTreatments
          .where((element) => element.id == _selectedTreatment!.id)
          .toList();
      if (list.isEmpty) {
        _selectedTreatments.add(
          TreatmentEntity(
            name: _selectedTreatment!.name!,
            id: _selectedTreatment!.id!,
            maleCount: maleCount,
            femaleCount: femaleCount,
          ),
        );
        notifyListeners();
      }else{
        removeFromSelectedTreatments = list.first;
        _selectedTreatments.add(
          TreatmentEntity(
            name: _selectedTreatment!.name!,
            id: _selectedTreatment!.id!,
            maleCount: maleCount,
            femaleCount: femaleCount,
          ),
        );
        notifyListeners();
      }
    }
  }

  set removeFromSelectedTreatments(TreatmentEntity value) {
    _selectedTreatments.removeWhere((element) => element.id == value.id);
    notifyListeners();
  }

  set updateSelectedTreatments(TreatmentEntity value) {
    final data =
        _selectedTreatments.where((element) => element.id == value.id).toList();
    if (data.isNotEmpty) {
      _selectedTreatments.removeWhere((element) => element.id == value.id);
      _selectedTreatments.add(value);
      notifyListeners();
    }
  }

  final List<String> _paymentTypes = ["Cash", "Card", "UPI"];

  List<String> get paymentTypes => _paymentTypes;

  String _paymentType = "Cash";

  String get paymentType => _paymentType;

  set paymentType(String value) {
    _paymentType = value;
    notifyListeners();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController advanceController = TextEditingController();
  TextEditingController balanceController = TextEditingController();
  TextEditingController treatmentDate = TextEditingController();
  TextEditingController treatmentTime = TextEditingController();

  void calculateBalance() {
    final totalAmount = double.parse(totalAmountController.text);
    final discount = double.parse(discountController.text);
    final advance = double.parse(advanceController.text);
    final balance = totalAmount - discount - advance;
    balanceController.text = balance.toString();
    notifyListeners();
  }
}
