import 'package:dio/dio.dart';
import 'package:pureservers/data/user/user.dart';
import 'package:pureservers/repositories/user/user_repository.dart';

class UserRepositoryMock implements UserRepository {
  @override
  final Dio dio;

  UserRepositoryMock(this.dio);

  @override
  Future<User?> getUser() async {
    return User(
      firstname: "Pomidor",
      lastname: "Ivanovich",
      email: "admin@admin.com",
      password: "12345678",
      currency: "EUR",
      balance: 0.98,
      automaticProcessing: false,
      isAdmin: false,
      active: true,
    );
  }
}
