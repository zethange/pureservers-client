import 'package:dio/dio.dart';
import 'package:pureservers/data/os/os.dart';
import 'package:pureservers/data/status.dart';

abstract class OsRepository {
  final Dio dio;
  OsRepository(this.dio);

  Future<List<OS>> getOs(String serverId);
  Future<Status> reinstallOs(String serverId, String selectedOption);
}
