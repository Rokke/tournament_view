import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tournamentviewer/models/tournament.dart';

class DatabaseService {
  DatabaseService() {
    print('DatabaseService constructor');
  }
  final CollectionReference tournamentCollection = Firestore.instance.collection("tournaments");
  List<Tournament> _tournamentListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((e) =>
            Tournament(key: e.documentID, name: e.data['name'], country: e.data['country'], place: e.data['place']))
        .toList();
  }

  Stream<List<Tournament>> get tournaments {
    print('fetching tournament snapshot');
    return tournamentCollection.snapshots().map(_tournamentListFromSnapshot);
  }

  void updateTournamentInformation({String key, String name}) async {
    if (name != null)
      tournamentCollection.document(key).updateData({'name': name});
    else
      print('Ignoring name');
  }

  Future<bool> createNewTournament(Tournament tournament) async {
    print('hei');
    final e = await tournamentCollection.add({'name': tournament.name, 'country': tournament.country});
    Future.delayed(Duration(seconds: 5));
    print('3');
    tournament.key = e.documentID;
    return true;
  }
}
