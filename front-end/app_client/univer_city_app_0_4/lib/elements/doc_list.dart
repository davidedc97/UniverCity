import 'package:flutter/material.dart';
import 'package:univer_city_app_0_4/elements/document.dart';
import 'package:univer_city_app_0_4/elements/pre_viewer.dart';
import 'package:univer_city_app_0_4/elements/pdf_viewer_func.dart';

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
              showDialog(
                  context: context,
                  builder: (context) =>
                      buildDocDialog(context, _info.title, _info.uuid));
              ///showModalBottomSheet(
              /// context: context,
              ///builder: (BuildContext context)=>
              ///     BottomSheetInfoFile(_info.title, _info.owner, _info.uuid)
              ///);
            }
        ),
        onTap: ()async{
          pdfFuncView(context, _info.uuid);
        },
      ),
    );
  }
}

