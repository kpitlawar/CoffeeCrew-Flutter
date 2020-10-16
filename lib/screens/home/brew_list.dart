import 'package:firebaseApp/models/brew.dart';
import 'package:firebaseApp/screens/home/brew_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {

  @override
  Widget build(BuildContext context) {

  final brews = Provider.of<List<Brew>>(context) ?? [];
  // brews.forEach((element) {
  //   print(element.name);
  //   print(element.suagr);
  //   print(element.strength); 
    
  // });

    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index){
        return BrewTile(brew: brews[index]);
      });
  }
}