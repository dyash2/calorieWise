import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class RecipeController {
  final String apiKey = 'b6zWEforUAKEX1FfjpUX5Q==dyn97WwF4F3rrm2r'; // API Key

  Future<List<Map<String, dynamic>>> getRecipe(String query) async {
    var url = Uri.parse(
      'https://api.calorieninjas.com/v1/recipe?query=$query',
    );

    log('Request URL: $url'); // Log the full request URL (with query)

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
        log('Response: ${response.body}'); // Log the response body

        var data = jsonDecode(response.body);
        var items = data['items'] as List<dynamic>;

        List<Map<String, dynamic>> recipeInfo = items.map((item) {
          return {
            'title': item['title'],
            'ingredients': item['ingredients'],
            'servings': item['servings'],
            'instructions': item['instructions'],
          };
        }).toList();

        log('Parsed Recipe Info: $recipeInfo');
        
        return recipeInfo;
      }

      throw Exception(
        'Failed to load data, status code: ${response.statusCode}',
      );
    } catch (e) {
      log('Error: $e'); // Log any errors
      rethrow;
    }
  }
}
