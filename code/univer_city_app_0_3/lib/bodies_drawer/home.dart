import 'package:flutter/material.dart';
import 'package:univer_city_app_0_3/elements/list_preferiti.dart';
import 'package:univer_city_app_0_3/elements/list_recenti.dart';
import 'package:univer_city_app_0_3/elements/title_div.dart';
import 'package:univer_city_app_0_3/bloc/home_provider.dart';



// DA SISTEMARE TUTTOO ################################################################

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final blocHome = HomeProvider.of(context);

    return ListView(
      children: <Widget>[
        RaisedButton.icon(icon:Icon(Icons.file_download), label: Text('test bloc') , onPressed: ()=>blocHome.test()),
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TitleDivider('Recenti'),
              SizedBox(
                height: 100.0,
                child: ListRecenti(),
              ),
            ],
          ),
        ),
        TitleDivider('Preferiti'),
        Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: ListPreferiti(),
        ),
        SizedBox(
          height: 80,
        )
      ],
    );
  }
}
