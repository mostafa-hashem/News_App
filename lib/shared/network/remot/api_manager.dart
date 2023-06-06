import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../../models/SoursesResponse.dart';
import '../../components/constans.dart';

class ApiManager {
  static Future<SoursesResponse> getSources() async {
    Uri URL = Uri.https(
        BASE_URL, END_POINT, {"apiKey": ApiKey});
    Response response = await http.get(URL);
    var jsonResponse = jsonDecode(response.body);
    SoursesResponse soursesResponse= SoursesResponse.fromJson(jsonResponse);
    return soursesResponse;
  }

}
