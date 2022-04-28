
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:reclutamiento/utilidades/json_data.dart';
import 'package:reclutamiento/utilidades/network_util.dart';

import 'detalles_pokemons.dart';

class ListarPokemons extends StatefulWidget {
  @override
  _ListarPokemons createState() =>  _ListarPokemons();
}

class _ListarPokemons extends State<ListarPokemons> {
  Future<JsonData>? pokemondata;

  @override
  void initState() {
    super.initState();
    pokemondata = NetworkUtil().fetchPokemon();
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
                        body:  FutureBuilder<JsonData>(
                          future: pokemondata,
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
