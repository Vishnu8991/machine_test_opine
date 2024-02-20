import 'package:http/http.dart' as http;

class HttpMealService {

  static Future<dynamic> fetchMeals(String strCategory) async {
    String url = "https://www.themealdb.com/api/json/v1/1/filter.php?c=$strCategory";

    var response = await http.get(
        Uri.parse(url));
        
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception();
    }
  }
}