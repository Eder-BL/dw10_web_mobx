import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/exceptions/unautorized_exception.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../models/auth_model.dart';
import './auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CustomDio _dio;

  AuthRepositoryImpl(this._dio);

  @override
  Future<AuthModel> login(String email, String password) async {
    try {
      final result = await _dio.unauth().post(
        '/auth',
        data: {
          'email': email,
          'password': password,
          'admin': true,
        },
      );

      return AuthModel.fromMap(result.data);
    } on DioError catch (e, s) {
      if (e.response?.statusCode == 403) {
        log(
          'Email ou senha inválidos',
          name: 'AuthRepositoryImpl.login',
          error: e,
          stackTrace: s,
        );
        throw UnautorizedException();
      }
      log(
        'Erro ao realizar login',
        name: 'AuthRepositoryImpl.login',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(message: 'Erro ao realizar login');
    }
  }
}
