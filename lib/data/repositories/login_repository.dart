import 'package:ayurveda/core/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

abstract class LoginRepository {
  Future<Either<String, String>> login(String username, String password);
}

@LazySingleton(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<Either<String, String>> login(String username, String password) async{
    try {
      final url = Uri.https(AppUrls.domain,AppUrls.loginEndPoint);
      final response = await http.post(
        url,
        body: {
          "username": username,
          "password": password,
        },
      );
      if(response.statusCode == 200){
        return right(response.body);
      }else{
        return left(response.body);
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}
