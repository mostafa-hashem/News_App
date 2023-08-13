import 'package:http/http.dart';

abstract class BaseRepo{

  Future<Response> getSources(String id);

  Future<Response> getNewsData(String sourceId, {String? query});

}