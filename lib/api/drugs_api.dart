import 'dart:convert';
import 'package:http/http.dart' as http;

class DrugApi {
  final String baseUrl = "iterar-mapi-us.p.rapidapi.com";
  final String drugName =
      "Acetaminophen-and-Codeine-Phosphate-Oral-Solution-acetaminophen-codeine-phosphate-665";
  final String apiKey = "780caea59cmsh7efc7a4738c8fa2p1f2d27jsnaed84170338e";

  Future<void> fetchDrugSummaryByName() async {
    final url = Uri.parse("$baseUrl$drugName");
    final headers = {
      'X-RapidAPI-Key': '780caea59cmsh7efc7a4738c8fa2p1f2d27jsnaed84170338e',
    'X-RapidAPI-Host': 'iterar-mapi-us.p.rapidapi.com'
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      print(json.decode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to fetch drug summary: ${response.statusCode}');
    }
  }
}
