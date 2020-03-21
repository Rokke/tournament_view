import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tournamentviewer/models/tournament.dart';
import 'package:tournamentviewer/screens/home/tournament_list_tile.dart';

class TournamentList extends StatefulWidget {
  TournamentList({Key key}) : super(key: key);

  @override
  _TournamentListState createState() => _TournamentListState();
}

class _TournamentListState extends State<TournamentList> {
  @override
  Widget build(BuildContext context) {
    print('rebuild _TournamentListState');
    final tournamentList = Provider.of<List<Tournament>>(context) ?? [];
    return Container(
      child: ListView.builder(
          itemCount: tournamentList.length,
          itemBuilder: (context, index) {
            return TournamentListTile(tournamentList[index]);
          }),
    );
  }
}
