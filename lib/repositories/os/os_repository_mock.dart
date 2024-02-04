import 'package:dio/dio.dart';
import 'package:pureservers/data/os/os.dart';
import 'package:pureservers/data/status.dart';
import 'package:pureservers/repositories/os/os_repository.dart';

class OsRepositoryMock implements OsRepository {
  @override
  final Dio dio;

  OsRepositoryMock(this.dio);

  @override
  Future<List<OS>> getOs(String serverId) async {
    return [
      OS(image: "1", label: "Rach Linux"),
      OS(image: "2", label: "Pedora 399"),
      OS(image: "3", label: "Bubuntu Linux"),
      OS(image: "4", label: "OpenSnus"),
      OS(image: "5", label: "GayOS"),
    ];
  }

  @override
  Future<Status> reinstallOs(String serverId, String selectedOption) async {
    return Status(success: true, message: "Заявка на переустановку отправлена");
  }
}
