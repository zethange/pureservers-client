import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pureservers/core/config.dart';
import 'package:pureservers/data/status.dart';
import 'package:pureservers/repositories/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  final Dio dio;

  AuthRepositoryImpl(this.dio);

  @override
  Future<Status> login(String email, String password) async {
    final res = await dio.post('${AppConfig.apiUrl}/auth/login',
        data: jsonEncode({'email': email, 'password': password}));
    switch (res.data) {
      case "FillFields":
        return Status(success: false, message: "Not all fields are filled in");
      case "UserNotExists":
        return Status(success: false, message: "The user does not exist");
      case "UserBlocked":
        return Status(success: true, message: "You have been blocked");
      case "LoggedIn":
        dio.options.headers['Session'] = res.headers['Session'];
        debugPrint('successfuly logged in');
        return Status(
            success: true, message: "You have successfully logged in");
    }

    return Status(success: false, message: "Something went wrong");
  }

  @override
  void logout() {
    dio.options.headers.remove("Session");
  }
}
