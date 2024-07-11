import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeebrew/Screens/home/brew_tile.dart';
import 'package:coffeebrew/models/brew.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({super.key});

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>?>(context) ??
        []; //List<Brew>? so that it can have null value as well
    /*brews.forEach((brew) {

    });*/
    //print(brews);
    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) {
        return BrewTile(brew: brews[index]);
      },
    );
  }
}
