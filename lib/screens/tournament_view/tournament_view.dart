import 'package:flutter/material.dart';
import 'package:tournamentviewer/models/tournament.dart';
import 'package:tournamentviewer/services/database.dart';
import 'package:tournamentviewer/theme/consts.dart';

class TournamentView extends StatefulWidget {
  Tournament tournament;
  TournamentView(this.tournament, {Key key}) : super(key: key);

  @override
  _TournamentViewState createState() => _TournamentViewState();
}

class _TournamentViewState extends State<TournamentView> {
  final _controllerName = TextEditingController();
  final _controllerCountry = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _vent = ValueNotifier<int>(1);
  final _focusName = FocusNode(), _focusCountry = FocusNode();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controllerName.text = widget.tournament.name;
    _controllerCountry.text = widget.tournament.country;
    print('initState: ${widget.tournament}');
    _vent.value = 0;
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  _createNewTournament() async {
    _vent.value = 1;
    final newTournament = await DatabaseService().createNewTournament(_controllerName.text, _controllerCountry.text);
    setState(() {
      widget.tournament = newTournament;
    });
    _vent.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    print('Rebuild $_controllerName dd');
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.tournament.key == null ? 'Opprett ny turnering' : 'Turnering: ${widget.tournament.name}'),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: TextFormField(
                  controller: _controllerName,
                  focusNode: _focusName,
                  validator: (value) {
                    return value.isEmpty ? 'Du må angi land' : null;
                  },
                  onFieldSubmitted: (term) {
                    widget.tournament.name = term;
                    print('onEdit: ${widget.tournament}');
                    _fieldFocusChange(context, _focusName, _focusCountry);
                    return _formKey.currentState.validate();
                  },
                  textInputAction: TextInputAction.next,
                  decoration: defaultInputDecoration.copyWith(labelText: 'Tournament name'),
                ),
              ),
              Container(
                child: TextFormField(
                  controller: _controllerCountry,
                  focusNode: _focusCountry,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    return value.isEmpty ? 'Du må angi land' : null;
                  },
                  onFieldSubmitted: (term) {
                    widget.tournament.country = term;
                    print('term: ${widget.tournament}');
                    if (term.isEmpty) _focusCountry.requestFocus();
                    return _formKey.currentState.validate();
                  },
                  decoration: defaultInputDecoration.copyWith(
                    labelText: 'Country',
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Expanded(child: Text('Key: ${widget.tournament.key}')),
              Container(
                color: Colors.red,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(onPressed: () => Navigator.pop(context), child: Text('Tilbake')),
                      ValueListenableBuilder(
                        valueListenable: _vent,
                        builder: (context, value, child) => value == 1
                            ? CircularProgressIndicator()
                            : RaisedButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    print('Lagre: ${widget.tournament}');
                                    _createNewTournament();
                                  } else
                                    print('Ikke OK');
                                  //                      DatabaseService().updateTournamentInformation(key: _tournament.key, name: _tournament.name);
                                },
                                child: Text((widget.tournament.key == null) ? 'Lag ny' : 'Oppdater'),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
