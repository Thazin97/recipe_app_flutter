import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:receipes/model/hits.dart';

class Recipe {
  List<Hits> hits = [];

  Future<void> getRecipe() async {
    String url =
        "https://api.edamam.com/search?q=banana&app_id=90040b20&app_key=7c7103bfc3bd7daa4662e7d9e0bce23b";
    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
    jsonData["hits"].forEach((element) {
      Hits hits = Hits(
        recipeModel: element['recipe'],
      );
      //hits.recipeModel = add(Hits.fromMap(hits.recipeModel));
    });
  }
}