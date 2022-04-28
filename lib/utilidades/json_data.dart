import 'package:reclutamiento/datos/results.dart';

class JsonData {
  List<Results>? pokemonSummary;

  JsonData({this.pokemonSummary});

  JsonData.fromJson(Map<String, dynamic> json) {
    pokemonSummary = <Results>[];
    json['results'].forEach((item) {
      pokemonSummary!.add(Results.fromJson(item));
    });
  }
}