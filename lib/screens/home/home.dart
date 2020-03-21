import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tournamentviewer/models/tournament.dart';
import 'package:tournamentviewer/screens/home/tournament_list.dart';
import 'package:tournamentviewer/screens/tournament_view/tournament_view.dart';
import 'package:tournamentviewer/services/database.dart';

class MyHomeView extends StatefulWidget {
  MyHomeView({Key key}) : super(key: key);

  @override
  _MyHomeViewState createState() => _MyHomeViewState();
}

class _MyHomeViewState extends State<MyHomeView> {
  @override
  Widget build(BuildContext context) {
    print('_MyHomeViewState build');
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tournament viewer'),
        ),
        body: StreamProvider<List<Tournament>>.value(
          value: DatabaseService().tournaments,
          child: TournamentList(),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add_circle_outline,
              color: Colors.blue,
              size: 40,
            ),
            onPressed: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) => TournamentView(Tournament())))),
      ),
    );
  }
}
