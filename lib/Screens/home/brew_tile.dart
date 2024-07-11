import 'package:coffeebrew/models/brew.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BrewTile extends StatelessWidget {
  final Brew? brew;

  BrewTile({super.key, this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown[brew!.strength!],
          ),
          title: Text(brew!.name!),
          subtitle: Text('Takes ${brew!.sugars!} suagar(s)'),
        ),
      ),
    );
  }
}
