import 'package:flutter/material.dart';
import 'package:univer_city_app_0_3/elements/document_formatting.dart';
import 'package:univer_city_app_0_3/elements/bottom_sheet_info_file.dart';
import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';

class DocList extends StatelessWidget {

  final DocumentInfo _info;

  DocList(this._info);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title:Text(_info.title),
      subtitle: (_info.subtitle == '' || _info.subtitle == null)
          ?null
          :Text(_info.subtitle),
      leading: (_info.isWrittenByHand)
          ?Icon(Icons.gesture)
          :Icon(Icons.description),
      trailing: IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: (){
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context)=>
                    BottomSheetInfoFile(_info.title, _info.proprietario,
                        _info.rank, _info.downloads)

            );
          }
      ),
      onTap: (){
        PdfViewer.loadAsset(_info.url);
      },
    );
  }
}