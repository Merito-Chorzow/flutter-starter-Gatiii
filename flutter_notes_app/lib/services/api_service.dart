import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
    static const String baseUrl = "https://dummyjson.com";

    Future<List<dynamic>> fetchPosts() async {
        final response = await http.get(Uri.parse("$baseUrl/posts?limit=10"));

    if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data["posts"];
    } else {
        throw Exception("Błąd pobierania danych");
    }
}
}
