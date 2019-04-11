import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/elements/elements.dart';
import 'package:univer_city_app_1_1/bloc/cronologia_bloc_provider.dart';

class Cronologia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime oggi = DateTime.now();
    DateTime unaSettimanaFa = oggi.subtract(Duration(days: 7));
    DateTime unMeseFa = oggi.subtract(Duration(days: 30));
    CronologiaBloc cBloc = CronologiaBlocProvider.of(context);





    return StreamBuilder(
      stream: cBloc.cronologia,
      builder: (context, snapshot){
        if(!snapshot.hasData || (snapshot.hasData && (snapshot.data as List<CronologiaEntry>).isEmpty)){
          return CronoSfondo();
        }else if(snapshot.hasData){
          bool r=false, s=false, m=false;
          return ListView.builder(
            itemBuilder: (context, i){
              if(snapshot.data[i].stamp.isBefore(unaSettimanaFa)&&!r){
                r=true;
                return DocListDividedTitle('Questa settimana', Document(snapshot.data[i].titolo, snapshot.data[i].proprietario, snapshot.data[i].uuid, null));
              }else if(snapshot.data[i].stamp.isBefore(unMeseFa)&&!s){
                s=true;
                return DocListDividedTitle('Questa settimana', Document(snapshot.data[i].titolo, snapshot.data[i].proprietario, snapshot.data[i].uuid, null));
              }else if(snapshot.data[i].stamp.isAfter(unMeseFa)&&!m){
                m=true;
                return DocListDividedTitle('Questa settimana', Document(snapshot.data[i].titolo, snapshot.data[i].proprietario, snapshot.data[i].uuid, null));
              }else{
                return DocList(Document(
                     snapshot.data[i].titolo, snapshot.data[i].proprietario, snapshot.data[i].uuid, null));
              }

            },
            itemCount: (snapshot.data as List<CronologiaEntry>).length,
          );
        }
      },
    );
  }
}

class CronoSfondo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
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
          padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 32.0),
          child: Center(child: Image.asset('assets/img/listDoc.png'),))
    ]);
  }
}
