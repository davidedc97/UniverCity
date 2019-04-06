import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/elements/document.dart';
import 'package:univer_city_app_1_1/elements/pre_viewer.dart';
import 'package:univer_city_app_1_1/elements/title_div.dart';
import 'package:univer_city_app_1_1/http_handling/http_handler.dart';
import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';

const _SPESSORE = 0.4;

class DocList extends StatelessWidget {

  final Document _info;


  DocList(this._info);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).cardColor,border: BorderDirectional(bottom: BorderSide(width: _SPESSORE, color: Theme.of(context).dividerColor),)),
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
          var byte = await HttpHandler.getDocumentById(_info.uuid);
          PdfViewer.loadBytes(byte);
        },
      ),
    );
  }
}

class DocListDividedTitle extends StatelessWidget {

  final Document _info ;
  final String _title;
  DocListDividedTitle(this._title,this._info);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleDivider(_title),
        Container(
          decoration: BoxDecoration(color: Theme.of(context).cardColor,border: BorderDirectional(bottom: BorderSide(width: _SPESSORE,color: Theme.of(context).dividerColor))),

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
              var byte = await HttpHandler.getDocumentById(_info.uuid);
              PdfViewer.loadBytes(byte);
            },
          ),
        )
      ],
    );
  }
}

class DocListFuture extends StatelessWidget{
  final String _uuid;
  DocListFuture(this._uuid);

  @override
  Widget build(BuildContext context) {
    var f = HttpHandler.getDocumentMetadata(_uuid);
    return FutureBuilder(
      future: f,
      builder: (context, AsyncSnapshot<Document> snapshot) {
        if (snapshot.hasError)
          return Text('Error: ${snapshot.error}');
        if (!snapshot.hasData) {
          return ListTile(
            title: Container(child: SizedBox(height: 20, width: 200,),
              color: Colors.grey[300],),
            subtitle: Container(child: SizedBox(height: 10, width: 300,),
              color: Colors.grey[300],),
            leading: Container(child: SizedBox(height: 20, width: 20,),
              color: Colors.grey[300],),
            trailing: Container(child: SizedBox(height: 20, width: 8,),
              color: Colors.grey[300],),
          );
        }
        return DocList(snapshot.data);
      }
    );
  }
}

