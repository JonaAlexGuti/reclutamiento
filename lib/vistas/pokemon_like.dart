
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reclutamiento/datos/pokemons.dart';
import 'package:reclutamiento/utilidades/database_helper.dart';

import 'package:reclutamiento/utilidades/json_data.dart';
import 'detalles_pokemons.dart';

class LikePokemons extends StatefulWidget {
  @override
  _LikePokemons createState() =>  _LikePokemons();
}

class _LikePokemons extends State<LikePokemons> {
  var db;
  late List<Pokemons> listPokemon = List.empty(growable: true);
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    db = DatabaseHelper();
    fToast = FToast();
    fToast.init(context);
  }

  _showToast(String message) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.redAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error, color: Colors.white,),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(
              message,style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 5),
    );
  }

  void loadPokemons(String satName) async{
    List<Pokemons> pokemonLike;

    pokemonLike = await db.getOneSatelite(satName);
    if(pokemonLike.isEmpty){
      _showToast("No tienes algun pokemon");
    }else {
      listPokemon = pokemonLike; //retorna una List<Pokemon>
      for (int i = 0; i < pokemonLike.length; i++) {
        //print('este es el satélite actual buscado: ' + pokemonLike[i].satName);
       
        setState(() {
          //nombreSat = sateliteActual[i].satName;
          //longitudSat = sateliteActual[i].currentSatLongitude;
          //
          // latitudSat = sateliteActual[i].currentLat;
        });
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Center(
            child: Column(
              children: <Widget> [
                ClayContainer(
                  depth: 50,
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  customBorderRadius: const BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
                  child: Column(
                    children: const <Widget>[
                      Expanded(
                        child: Padding(padding: EdgeInsets.only(top: 15),),
                      ),
                      Expanded(
                        child:Text(
                          'Pokemons ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'WorkSans',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                Expanded(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Scaffold(
                          body:  Text('wii'),
                              /*
                          FutureBuilder<Pokemons>(
                            future: listPokemon,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                if (snapshot.hasData) {
                                  final data = snapshot.data!.pokemonSummary;
                                  return ItemList(data: data);
                                } else {
                                  return const Center(
                                    child: Text('No hay data'),
                                  );
                                }
                              }
                            },
                          ),

                               */
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}

class ItemList extends StatelessWidget {
  final dynamic data;
  var result;
  ItemList({Key? key, required this.data}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    chekPokemon(context, url) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetallePokemonView(url: url),
        ),
      );
    }

    return ListView.builder(
        itemCount: data!.length,
        itemBuilder: (context, index) {
          final name = data[index].name;
          return Card(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                onTap: () {
                  chekPokemon(context, data[index].url);
                },
                title: Center(
                  child: Text(
                    '$name'.toUpperCase(),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
