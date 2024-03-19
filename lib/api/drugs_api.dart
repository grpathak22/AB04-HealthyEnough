import 'dart:convert';
import 'package:http/http.dart' as http;

class DrugApi {
  final String baseUrl = "https://drugapi.p.rapidapi.com/Drug/Summary/";
  final String drugName =
      "Acetaminophen-and-Codeine-Phosphate-Oral-Solution-acetaminophen-codeine-phosphate-665";
  final String apiKey = "ef18faa0d1msh6881a11b4b6e056p1a22c5jsn5a2c2b6d5ab2";

  Future<void> fetchDrugSummaryByName() async {
    final url = Uri.parse("$baseUrl$drugName");
    final headers = {
      'X-RapidAPI-Key': apiKey,
      // 'X-RapidAPI-Host': 'drugapi.p.rapidapi.com',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      print(json.decode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to fetch drug summary: ${response.statusCode}');
    }
  }
}
