import 'package:dio/dio.dart';
import 'package:pureservers/core/config.dart';
import 'package:pureservers/data/user/user.dart';
import 'package:pureservers/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  final Dio dio;

  UserRepositoryImpl(this.dio);

  @override
  Future<User?> getUser() async {
    final res = await dio.get('${AppConfig.apiUrl}/auth/session');
    return User.fromJson(res.data);
  }
}
