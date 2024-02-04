import 'package:dio/dio.dart';
import 'package:pureservers/data/user/user.dart';

abstract class UserRepository {
  final Dio dio;

  UserRepository(this.dio);

  Future<User?> getUser();
}
