import 'package:flutter/material.dart';
import 'package:tournamentviewer/models/tournament.dart';
import 'package:tournamentviewer/screens/tournament_view/tournament_view.dart';

class TournamentListTile extends StatelessWidget {
  final Tournament tournament;
  const TournamentListTile(this.tournament);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple,
      elevation: 5,
      child: Row(
        children: <Widget>[
          Container(
              alignment: Alignment.center, height: 40, width: 190, color: Colors.green, child: Text(tournament.name)),
          Expanded(child: Text(tournament.country ?? 'Ukjent')),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: FlatButton(
              child: Icon(
                Icons.hot_tub,
                color: Colors.red,
              ),
              color: Colors.blue,
              highlightColor: Colors.yellow,
              splashColor: Colors.blue,
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TournamentView(tournament))),
            ),
          )
        ],
      ),
    );
  }
}
