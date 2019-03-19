import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/elements/document.dart';
import 'package:univer_city_app_1_1/elements/pre_viewer.dart';

class DocList extends StatelessWidget {

  final Document _info;

  DocList(this._info);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        title:Text(_info.title),
        subtitle: (_info.creator != null)
            ? Text(_info.creator)
            : Text(''),
        leading: Icon(Icons.description),
        trailing: IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: (){
              //visualizzazione pre viewer
              showDialog(
                context: context,
                builder: (context)=>buildDocDialog(context, _info.title,_info.creator, _info.uuid)
              );}
        ),
        onTap: ()async{
          showDialog(
              context: context,
              builder: (context)=>buildDocDialog(context,_info.title,_info.creator , _info.uuid)
          );
        },
      ),
    );
  }
}

