import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class NutritionController {
  final String apiKey = 'b6zWEforUAKEX1FfjpUX5Q==dyn97WwF4F3rrm2r'; 

  Future<List<Map<String, dynamic>>> getNutritionValue(String query) async {
    var url = Uri.parse(
      'https://api.calorieninjas.com/v1/nutrition?query=$query',
    );

    log('Request URL: $url'); 

    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-Api-Key': apiKey,
      },
    );

    try {
      if (response.statusCode == 200) {
        log('Response : ${response.body}');

        var data = jsonDecode(response.body);
        var items = data['items'] as List<dynamic>;

        // Extracting only the required fields: calories, nutrition (protein, carbs, etc.), fat
        List<Map<String, dynamic>> nutritionInfo = items.map((item) {
          return {
            'name': item['name'],
            'calories': item['calories'],
            'fat_total_g': item['fat_total_g'],
            'protein_g': item['protein_g'],
            'carbohydrates_total_g': item['carbohydrates_total_g'],
          };
        }).toList();

        return nutritionInfo;
      }
      
      throw Exception(
        'Failed to load data, status code: ${response.statusCode}',
      );
    } catch (e) {
      log('Error: $e'); 
      rethrow;
    }
  }
}
