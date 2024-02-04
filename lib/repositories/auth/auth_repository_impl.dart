import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pureservers/core/config.dart';
import 'package:pureservers/data/status.dart';
import 'package:pureservers/repositories/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  final Dio dio;

  AuthRepositoryImpl(this.dio);

  @override
  Future<Status> login(String email, String password) async {
    final res = await dio.post(
      '${AppConfig.apiUrl}/auth/login',
      data: jsonEncode({'email': email, 'password': password}),
      options: Options(validateStatus: (status) => true),
    );

    switch (res.data) {
      case "FillFields":
        return Status(success: false, message: "Не все поля заполнены");
      case "UserNotExists":
        return Status(success: false, message: "Логин или пароль неверный");
      case "UserBlocked":
        return Status(success: true, message: "Вы были заблокированы");
      case "LoggedIn":
        dio.options.headers['Session'] = res.headers['Session'];
        return Status(success: true, message: "Вы успешно вошли в систему");
    }

    return Status(success: false, message: "Что-то пошло не так");
  }

  @override
  void logout() {
    dio.options.headers.remove("Session");
  }
}
