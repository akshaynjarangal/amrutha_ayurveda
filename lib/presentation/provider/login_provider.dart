import 'dart:convert';
import 'dart:developer';
import 'package:ayurveda/core/constants.dart';
import 'package:ayurveda/domain/usecases/login_usecase.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginProvider extends ChangeNotifier {
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

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    isLoading = true;
    final result = await _loginUsecase.userLogin(username: usernameController.text, password: passwordController.text);
    result.fold((l) {
      isLoading = false;
      log("Error: $l");
    }, (r) async{
      final data = jsonDecode(r);
      if(data["status"] == true){
        await storage.write(key: "token", value: "${data["token"]}");
        await storage.write(key: "name", value: "${data["user_details"]["name"]}");
        isLoading = false;
        isLogin = true;
      }else{
      errorMessage = data["message"];
      isLoading = false;
      log("Success: $r");
      }
    });
  }
}
