import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/elements/elements.dart';
import 'package:univer_city_app_1_1/bloc/cronologia_bloc_provider.dart';

class Cronologia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Document> _cronologiaRecente = [];
    List<Document> _cronologiaSettinamaFa = [];
    List<Document> _cronologiaMesefa = [];
    List<Widget> _cronologiaView = [];
    CronologiaBloc cBloc = CronologiaBlocProvider.of(context);

    List<CronologiaEntry> entries = cBloc.cronologia;
    DateTime oggi = DateTime.now();
    DateTime unaSettimanaFa = oggi.subtract(Duration(days: 7));
    DateTime unMeseFa = oggi.subtract(Duration(days: 30));

    for (int i = 0; i < entries.length; i++) {
      if (entries[i].stamp.isBefore(unaSettimanaFa)) {
        _cronologiaSettinamaFa.add(Document(
            entries[i].titolo, entries[i].proprietario, entries[i].uuid, 'C'));
        break;
      } else if (entries[i].stamp.isBefore(unMeseFa)) {
        _cronologiaMesefa.add(Document(
            entries[i].titolo, entries[i].proprietario, entries[i].uuid, 'C'));
        break;
      } else {
        _cronologiaRecente.add(Document(
            entries[i].titolo, entries[i].proprietario, entries[i].uuid, 'C'));
        break;
      }
    }

    _cronologiaView = [] +
        [TitleDivider('Questa settimana')] +
        _cronologiaRecente +
        [TitleDivider('Questo mese')] +
        _cronologiaSettinamaFa +
        [TitleDivider('Meno recenti')] +
        _cronologiaMesefa;

    return _cronologiaView.isEmpty
        ? Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: TitleDivider('Qui comparirà la tua cronologia'),
            ),
            Text(
                ' Hey datti una mossa è pieno di appunti dai un\' occhiata a qualcosa !',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.grey,
                )),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 32.0),
                child: Icon(
                  Icons.history,
                  color: Colors.grey,
                  size: 150,
                ))
          ])
        : ListView(children: _cronologiaView,);
  }
}
