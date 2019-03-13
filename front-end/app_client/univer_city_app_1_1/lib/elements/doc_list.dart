import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/elements/document.dart';

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
              debugPrint('test');}
        ),
        onTap: ()async{
          debugPrint('test');
        },
      ),
    );
  }
}

