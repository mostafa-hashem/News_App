import 'package:http/http.dart';
import 'package:news_app/screens/home/repository/repo.dart';
import 'package:http/http.dart' as http;
import '../../../../shared/components/constans.dart';

class RemoteRepo extends BaseRepo{
  @override
  Future<Response> getNewsData(String sourceId ,{String? query}) {
    Uri URL = Uri.https(BASE_URL, "/v2/everything", {
      "apiKey": ApiKey,
      "sources": sourceId,
      "q": query,
    });
    return  http.get(URL);
  }


  @override
  Future<Response> getSources(String id) {
    Uri URL =
    Uri.https(BASE_URL, END_POINT, {"apiKey": ApiKey, "category": id});
    return http.get(URL);
  }

}