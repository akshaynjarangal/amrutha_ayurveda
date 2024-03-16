import 'package:ayurveda/data/models/branch_list_model.dart';
import 'package:ayurveda/data/models/patient_list_model.dart';
import 'package:ayurveda/data/models/treatments_list_model.dart';
import 'package:ayurveda/data/repositories/patient_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class PatientUseCase {
  final PatientRepository _patientRepository;
  PatientUseCase({required PatientRepository patientRepository}) : _patientRepository = patientRepository;


  Future<Either<String, List<PatientListModel>>> get getPatients async {
    return await _patientRepository.getPatientList;
  }

  Future<Either<String, List<BranchListModel>>> get getBranches async {
    return await _patientRepository.getBranchList;
  }

  Future<Either<String, List<TreatmentsListModel>>> get getTreatments async {
    return await _patientRepository.getTreatmentsList;
  }
}
