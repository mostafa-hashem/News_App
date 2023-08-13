import 'package:http/src/response.dart';
import 'package:news_app/screens/home/repository/repo.dart';

class LocalRepo extends BaseRepo{
  @override
  Future<Response> getNewsData(String sourceId, {String? query}) {
    // TODO: implement getNewsData
    throw UnimplementedError();
  }

  @override
  Future<Response> getSources(String id) {
    // TODO: implement getSources
    throw UnimplementedError();
  }

}