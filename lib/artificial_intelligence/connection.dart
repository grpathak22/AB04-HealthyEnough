import 'package:google_generative_ai/google_generative_ai.dart';

class EnoughAi {
  final apiKey = 'AIzaSyASPvQYnbQgPO7ROqOlHotlieNdFhVBH0E';
  GenerativeModel? model;

  Future<bool> connectKey() async {
    model = await GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    if (model == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<dynamic> promptGen(String t) async {
    final content = [Content.text(t)];
    final response = await model?.generateContent(content);
    return response!.text;
  }
}
