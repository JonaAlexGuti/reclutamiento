import 'dart:convert';

class Pokemons {


  String? name;
  int? weight;

  late List<Ability> abilities;
  late List<GameIndex> gameIndices;
  List<Move> moves;
  Species species;
  List<Stat> stats;
  List<Type> types;
  List<Species> forms;

  Sprites? sprites;

  Pokemons({
    this.name,
    this.weight,
    this.sprites,
    required this.abilities,
    required this.gameIndices,
    required this.moves,
    required this.species,
    required this.types,
    required this.stats,
    required this.forms,
  });

  factory Pokemons.fromJson(Map<String, dynamic> json) => Pokemons(
    name: json["name"],
    weight: json["weight"],
    sprites: Sprites.fromJson(json["sprites"]),
    abilities: List<Ability>.from(
        json["abilities"].map((x) => Ability.fromJson(x))),
    gameIndices: List<GameIndex>.from(
        json["game_indices"].map((x) => GameIndex.fromJson(x))),
    moves: List<Move>.from(json["moves"].map((x) => Move.fromJson(x))),
    species: Species.fromJson(json["species"]),
    types: List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
    stats: List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x))),
    forms: List<Species>.from(json["forms"].map((x) => Species.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "weight": weight,
    "sprites": sprites!.toJson(),
    "abilities": List<dynamic>.from(abilities.map((x) => x.toJson())),
    "game_indices": List<dynamic>.from(gameIndices.map((x) => x.toJson())),
    "moves": List<dynamic>.from(moves.map((x) => x.toJson())),
    "species": species.toJson(),
    "types": List<dynamic>.from(types.map((x) => x.toJson())),
    "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
    "forms": List<dynamic>.from(forms.map((x) => x.toJson())),
  };

  Map<String, Object?> toMap() {
    return {
      "name": name,
      "weight": weight,
      "sprites": sprites!.toJson(),
      "abilities": List<dynamic>.from(abilities.map((x) => x.toJson())),
      "game_indices": List<dynamic>.from(gameIndices.map((x) => x.toJson())),
      "moves": List<dynamic>.from(moves.map((x) => x.toJson())),
      "species": species.toJson(),
      "types": List<dynamic>.from(types.map((x) => x.toJson())),
      "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
      "forms": List<dynamic>.from(forms.map((x) => x.toJson())),
    };
  }

}

class Sprites {
  Sprites({
    this.backDefault,
    this.frontDefault,
  });

  String? backDefault;
  String? frontDefault;

  factory Sprites.fromJson(Map<String, dynamic> json) => Sprites(
    backDefault: json["back_default"],
    frontDefault: json["front_default"],
  );

  Map<String, dynamic> toJson() => {
    "back_default": backDefault,
    "front_default": frontDefault,
  };
}


class Ability {
  bool isHidden;
  int slot;
  Species ability;

  Ability({
    required this.isHidden,
    required this.slot,
    required this.ability,
  });

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
    isHidden: json["is_hidden"],
    slot: json["slot"],
    ability: Species.fromJson(json["ability"]),
  );

  Map<String, dynamic> toJson() => {
    "is_hidden": isHidden,
    "slot": slot,
    "ability": ability.toJson(),
  };

  @override
  String toString() {
    return '${ability}';
  }
}

class Species {
  String name;
  String url;

  Species({
    required this.name,
    required this.url,
  });

  factory Species.fromJson(Map<String, dynamic> json) => Species(
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
  };

  @override
  String toString() {
    return '${name}';
  }
}

class GameIndex {
  int gameIndex;
  Species version;

  GameIndex({
    required this.gameIndex,
    required this.version,
  });

  factory GameIndex.fromJson(Map<String, dynamic> json) => GameIndex(
    gameIndex: json["game_index"],
    version: Species.fromJson(json["version"]),
  );

  Map<String, dynamic> toJson() => {
    "game_index": gameIndex,
    "version": version.toJson(),
  };

  @override
  String toString() {
    return '${version}';
  }
}

class Move {
  Species move;
  List<VersionGroupDetail> versionGroupDetails;

  Move({
    required this.move,
    required this.versionGroupDetails,
  });

  factory Move.fromJson(Map<String, dynamic> json) => Move(
    move: Species.fromJson(json["move"]),
    versionGroupDetails: List<VersionGroupDetail>.from(
        json["version_group_details"]
            .map((x) => VersionGroupDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "move": move.toJson(),
    "version_group_details":
    List<dynamic>.from(versionGroupDetails.map((x) => x.toJson())),
  };
}

class VersionGroupDetail {
  int levelLearnedAt;
  Species versionGroup;
  Species moveLearnMethod;

  VersionGroupDetail({
    required this.levelLearnedAt,
    required this.versionGroup,
    required this.moveLearnMethod,
  });

  factory VersionGroupDetail.fromJson(Map<String, dynamic> json) =>
      VersionGroupDetail(
        levelLearnedAt: json["level_learned_at"],
        versionGroup: Species.fromJson(json["version_group"]),
        moveLearnMethod: Species.fromJson(json["move_learn_method"]),
      );

  Map<String, dynamic> toJson() => {
    "level_learned_at": levelLearnedAt,
    "version_group": versionGroup.toJson(),
    "move_learn_method": moveLearnMethod.toJson(),
  };
}

class Stat {
  int baseStat;
  int effort;
  Species stat;

  Stat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
    baseStat: json["base_stat"],
    effort: json["effort"],
    stat: Species.fromJson(json["stat"]),
  );

  Map<String, dynamic> toJson() => {
    "base_stat": baseStat,
    "effort": effort,
    "stat": stat.toJson(),
  };
}

class Type {
  int slot;
  Species type;

  Type({
    required this.slot,
    required this.type,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    slot: json["slot"],
    type: Species.fromJson(json["type"]),
  );

  Map<String, dynamic> toJson() => {
    "slot": slot,
    "type": type.toJson(),
  };
}