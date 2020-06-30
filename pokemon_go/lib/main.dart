import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokemon_go/pokemon.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  var url =
      "https://raw.githubusercontent.com/aungzinphyo94/PokemonGo/master/pokedex.json";

  PokemonHub pokemonHub; //obj

  @override
  void initState() {
    super.initState();
    fectchData();
  }

  fectchData() async {
    var data = await http.get(url);

    var jsonData = jsonDecode(data.body); //==json.decode()
    pokemonHub = PokemonHub.fromJson(
        jsonData); //add data to List<Pokemon> in generated json pokemon.dart
  } //no return

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PokemonGo'),
          backgroundColor: Colors.cyan,
        ),
        body: pokemonHub == null
            ? Center(child: CircularProgressIndicator())
            : GridView.count(
                crossAxisCount: 2, //2 columns
                children: pokemonHub.pokemon
                    .map((poke) => Padding(
                          padding: EdgeInsets.all(2.0),
                          child: InkWell(
                            onTap: () {},
                            child: Hero(
                              tag: poke.img,
                              child: Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Container(
                                      child: Image.network(poke.img),
                                    ),
                                    Text(
                                      poke.name,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(), //collection (key , value)
              ));
  }
}
