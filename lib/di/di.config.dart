// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/repositories/login_repository.dart' as _i3;
import '../data/repositories/patient_repository.dart' as _i5;
import '../domain/usecases/login_usecase.dart' as _i4;
import '../domain/usecases/patient_usecase.dart' as _i6;
import '../presentation/provider/login_provider.dart' as _i8;
import '../presentation/provider/patient_provider.dart' as _i9;
import '../presentation/provider/registration_provider.dart' as _i7;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.LoginRepository>(() => _i3.LoginRepositoryImpl());
    gh.factory<_i4.LoginUsecase>(
        () => _i4.LoginUsecase(gh<_i3.LoginRepository>()));
    gh.lazySingleton<_i5.PatientRepository>(() => _i5.PatientRepositoryImpl());
    gh.factory<_i6.PatientUseCase>(() =>
        _i6.PatientUseCase(patientRepository: gh<_i5.PatientRepository>()));
    gh.factory<_i7.RegistrationProvider>(() =>
        _i7.RegistrationProvider(patientUseCase: gh<_i6.PatientUseCase>()));
    gh.factory<_i8.LoginProvider>(
        () => _i8.LoginProvider(loginUsecase: gh<_i4.LoginUsecase>()));
    gh.factory<_i9.PatientProvider>(
        () => _i9.PatientProvider(patientUseCase: gh<_i6.PatientUseCase>()));
    return this;
  }
}
