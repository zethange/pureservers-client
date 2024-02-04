import 'package:dio/dio.dart';
import 'package:pureservers/data/status.dart';
import 'package:pureservers/repositories/auth/auth_repository.dart';

class AuthRepositoryMock implements AuthRepository {
  @override
  final Dio dio;

  AuthRepositoryMock(this.dio);

  @override
  Future<Status> login(String email, String password) async {
    if (email == "admin@admin.com" && password == "12345678") {
      return Status(success: true, message: "Succesfully logged in");
    }

    return Status(success: false, message: "Wrong credentials");
  }

  @override
  void logout() {}
}
