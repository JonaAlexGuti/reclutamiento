import 'dart:ffi';

import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reclutamiento/datos/pokemons.dart';
import 'package:reclutamiento/utilidades/database_helper.dart';
import 'package:reclutamiento/utilidades/network_util.dart';
import 'package:favorite_button/favorite_button.dart';

class DetallePokemonView extends StatefulWidget {
  final String url;
  const DetallePokemonView({Key? key, required this.url}) : super(key: key);

  @override
  _DetallePokemonViewState createState() => _DetallePokemonViewState();
}

class _DetallePokemonViewState extends State<DetallePokemonView> {
  Future<Pokemons>? pokemonIndex;
  late DatabaseHelper db;
  List<Ability> habilidades = List.empty(growable: true);
  List<GameIndex> game_version = List.empty(growable: true);
  List<Move> moves = List.empty(growable: true);

  get species => null;

  get stats => null;

  get forms => null;

  get types => null;

  @override
  void initState() {
    super.initState();
    db = DatabaseHelper();
    db.initDb();
    pokemonIndex = NetworkUtil().fetchDetailPokemon(widget.url);
  }

  void btnFavorite(){

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Pokemons>(
      future: pokemonIndex,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasData) {
            habilidades = snapshot.data!.abilities;
            game_version = snapshot.data!.gameIndices;
            moves = snapshot.data!.moves;

            final name = snapshot.data!.name;
            final weight = snapshot.data!.weight;
            final gambar2 = snapshot.data!.sprites!.backDefault;
            final gambar1 = snapshot.data!.sprites!.frontDefault;
            final especie = snapshot.data!.species.name;
            return Scaffold(

              body: Center(
                child: Column(
                  children: [
                    ClayContainer(
                      depth: 50,
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      customBorderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                      child: Column(
                        children:  <Widget>[
                          const Expanded(
                            child: Padding(padding: EdgeInsets.only(top: 1),),
                          ),
                          Row(
                            children: [
                              const Expanded(
                                child:Text(
                                  'Detalles del Pokemon ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'WorkSans',
                                  ),
                                ),
                              ),
                              FavoriteButton(
                                valueChanged: (_isFavorite) {
                                  setState(() {
                                    db.savePokemon(Pokemons(abilities: habilidades, gameIndices: game_version, moves: moves, species: species, types: types, stats: stats, forms: forms));
                                  });
                                  print('Is Favorite $_isFavorite)');
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),

                    const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                    Text(
                      'Nombre: $name',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),

                    Image.network(
                      '$gambar1',
                      width: 100,
                      height: 100,
                    ),

                    Image.network(
                      '$gambar2',
                      width: 100,
                      height: 100,
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    const Text(
                      'Habilidades: ',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),

                    Expanded(
                        child: ListView.builder(
                          itemCount: habilidades.length,
                          itemBuilder: (context, index){
                            final item = habilidades[index];
                            return ListTile(
                              title: Text(item.ability.toString()),
                            );
                          },
                        ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    const Text(
                      'Versiones en las que aparece: ',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),

                    Expanded(
                      child: ListView.builder(
                        itemCount: game_version.length,
                        itemBuilder: (context, index){
                          final item = game_version[index];
                          return ListTile(
                            title: Text(item.version.toString()),
                          );
                        },
                      ),
                    ),

                    Text(
                      'Peso: $weight',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    const Text(
                      'Movimientos: ',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),

                      Expanded(
                      child: ListView.builder(

                        itemCount: moves.length,
                        itemBuilder: (context, index){
                          final item = moves[index];
                          return ListTile(
                            title: Text(item.move.toString()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            // eror
            return const Scaffold(
              body: Center(
                child: Text('Sin datos para mostrar'),
              ),
            );
          }
        }
      },
    );
  }
}