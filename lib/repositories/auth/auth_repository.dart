import 'package:dio/dio.dart';
import 'package:pureservers/data/status.dart';

abstract class AuthRepository {
  final Dio dio;
  AuthRepository(this.dio);

  Future<Status> login(String email, String password);
  void logout();
}
