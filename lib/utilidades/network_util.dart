import 'dart:async';
import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:reclutamiento/datos/pokemons.dart';

import 'json_data.dart';

class NetworkUtil {
  Future<JsonData> fetchPokemon() async {
    final Uri url = Uri.parse('https://pokeapi.co/api/v2/pokemon?offset=100&limit=100');
    final response = await http.get(url);
    final data = JsonData.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<Pokemons> fetchDetailPokemon(url) async {
    final Uri uri = Uri.parse(url);
    final response = await http.get(uri);
    var data = Pokemons.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception(response.statusCode);
    }
  }
}