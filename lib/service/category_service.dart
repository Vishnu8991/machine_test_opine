import 'package:http/http.dart' as http;

class HttpDataService {
  static Future<dynamic> fetchData() async {
    var response = await http.get(
        Uri.parse("https://www.themealdb.com/api/json/v1/1/categories.php"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception();
    }
  }
}