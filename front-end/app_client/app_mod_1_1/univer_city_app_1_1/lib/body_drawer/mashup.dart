import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/elements/elements.dart';
import 'package:univer_city_app_1_1/bloc/mash_bloc_provider.dart';

class Mashup extends StatefulWidget {
  final MashupBloc bloc;
  Mashup(this.bloc);
  @override
  _MashupState createState() => _MashupState();
}

class _MashupState extends State<Mashup> {
  // List<String>
  List<String> fav = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.bloc.mashup,
      builder: (context, snapshot){
        print('refresh builder Mash');
        fav = widget.bloc.mashupValue;
        if(fav.isEmpty){
          return Center(child: MashSfondo(),);
        }else {
          return ListView.builder(
            itemBuilder: (context, i){
              if(i==0){
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: TitleDivider(''
                      'I tuoi Mashups'),
                );
              }
              return DocListFuture(fav[i-1]);
            },
            itemCount: fav.length+1,
          );
        }
      },
    );
  }
}

class MashSfondo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: TitleDivider('Qui compariranno tutti i tuoi mashup'),
      ),
      Text(
          ' Hey datti una mossa !',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24.0,
            color: Colors.grey,
          )),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 32.0),
          child: Center(child: Image.asset('assets/img/mash.png')))
    ]);
  }
}