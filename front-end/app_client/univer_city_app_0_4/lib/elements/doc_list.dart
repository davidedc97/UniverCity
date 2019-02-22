import 'package:flutter/material.dart';
import 'package:univer_city_app_0_4/elements/document_formatting.dart';
import 'package:univer_city_app_0_4/elements/bottom_sheet_info_file.dart';
import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';

class DocList extends StatelessWidget {

  final Document _info;

  DocList(this._info);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        title:Text(_info.title),
        subtitle: _info.owner ?? Text(''),
        leading: Icon(Icons.description),
        trailing: IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: (){
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context)=>
                      BottomSheetInfoFile(_info.title, _info.owner, _info.uuid)

              );
            }
        ),
        onTap: (){
          PdfViewer.loadAsset(_info.uuid);
        },
      ),
    );
  }
}