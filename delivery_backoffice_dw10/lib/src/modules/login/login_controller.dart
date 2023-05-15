import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../core/exceptions/unautorized_exception.dart';
import '../../services/auth/login_service.dart';
part 'login_controller.g.dart';

enum LoginStateStatus {
  initial,
  loading,
  success,
  error;
}

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  final LoginService _loginService;

  @readonly
  var _loginStatus = LoginStateStatus.initial;

  @readonly
  String? _errorMessage;

  LoginControllerBase(this._loginService);

  @action
  Future<void> login(String email, String password) async {
    _loginStatus = LoginStateStatus.loading;
    try {
      await _loginService.execute(email, password);
      _loginStatus = LoginStateStatus.success;
    } on UnautorizedException {
      _errorMessage = 'Email ou senha inválidos';
      _loginStatus = LoginStateStatus.error;
    } catch (e, s) {
      log(
        'Erro ao realizar login',
        error: e,
        stackTrace: s,
      );
      _errorMessage = 'Tente novamente mais tarde';
      _loginStatus = LoginStateStatus.error;
    }
  }
}
