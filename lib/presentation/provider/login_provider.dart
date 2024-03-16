import 'dart:convert';
import 'dart:developer';
import 'package:ayurveda/core/constants.dart';
import 'package:ayurveda/domain/usecases/login_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginProvider with ChangeNotifier {
  final LoginUsecase _loginUsecase;
  LoginProvider({required LoginUsecase loginUsecase}) : _loginUsecase = loginUsecase;

  bool get isLogin => _isLogin;
  bool _isLogin = false;

  set isLogin(bool value) {
    _isLogin = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  set errorMessage(String value) {
    _errorMessage = value;
    notifyListeners();
  }

  Future<void> login({required String username, required String password}) async {
    isLoading = true;
    final result = await _loginUsecase.userLogin(username: username, password: password);
    result.fold((l) {
      isLoading = false;
      log("Error: $l");
    }, (r) async{
      final data = jsonDecode(r);
      if(data["status"] == true){
        await storage.write(key: "token", value: "${data["token"]}");
        isLoading = false;
        isLogin = true;
      }else{
      errorMessage = data["message"];
      log("Success: $r");
      }
    });
  }
}
