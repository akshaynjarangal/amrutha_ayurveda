import 'package:ayurveda/data/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUsecase {
  final LoginRepository repository;

  LoginUsecase(this.repository);

  Future<Either<String, String>> userLogin({required String username,required String password}) async {
    return await repository.login(username, password);
  }
}