import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:univer_city_app_0_4/elements/title_div.dart';
import 'package:univer_city_app_0_4/http_handling/http_handler.dart';

class Tags {
  final String _tag;
  const Tags(this._tag);
}

const tagsDisp = <Tags>[
  Tags('Tag di prova'),
  Tags('automatica'),
  Tags('telecomunicazioni'),
  Tags('analisi'),
  Tags('automotive'),
  Tags('alpha'),
  Tags('nami'),
  Tags('rami'),
  Tags('resa'),
  Tags('tesa'),
  Tags('test1'),
];

class UploadFormScaffold extends StatelessWidget {
  final String _pathFile;
  UploadFormScaffold(this._pathFile);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'UniverCity',
          style: TextStyle(
            fontFamily: 'Collegiate',
            fontSize: 32.0,
          ),
        ),
      ),
      body: UploadFormBody(_pathFile),
    );
  }
}

class UploadFormBody extends StatelessWidget {
  final String path;
  UploadFormBody(this.path);
  String title, type = 'o';
  Future<int> res ;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: TitleDivider('File upload'),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: ChipsInput(
                  decoration: InputDecoration(
                    labelText: "Tag",
                  ),
                  initialValue: [
                    Tags('Tag di prova'),
                  ],
                  findSuggestions: (String query) {
                    if (query.length != 0) {
                      var lowercaseQuery = query.toLowerCase();
                      return tagsDisp.where((tag) {
                        return tag._tag
                            .toLowerCase()
                            .contains(query.toLowerCase());
                      }).toList(growable: false)
                        ..sort((a, b) => a._tag
                            .toLowerCase()
                            .indexOf(lowercaseQuery)
                            .compareTo(
                                b._tag.toLowerCase().indexOf(lowercaseQuery)));
                    } else {
                      return const <Tags>[];
                    }
                  },
                  chipBuilder: (context, state, tag) {
                    return InputChip(
                      key: ObjectKey(tag),
                      label: Text(tag._tag),
                      onDeleted: () => state.deleteChip(tag),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    );
                  },
                  suggestionBuilder: (context, state, tag) {
                    return ListTile(
                      key: ObjectKey(tag),
                      title: Text(tag._tag),
                      onTap: () => state.selectSuggestion(tag),
                    );
                  },
                  onChanged: (tags) {
                    return debugPrint('cambio tag');
                  })),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: TextField(
                  onChanged: (value) {
                    title = value;
                    debugPrint(title);
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(labelText: 'Title'))),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(labelText: 'Course'))),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(labelText: 'Professor'))),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: TextField(
                  maxLines: 4,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(labelText: 'Description'))),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: RaisedButton.icon(
              icon: Icon(Icons.add_circle_outline),
              label: Text('UPLOAD'),
              onPressed: () {
                //TODO controllo campi
                Navigator.of(context).pop();
                showDialog(
                    context: context,
                    builder:(context){
                      return DialogUpload(title, path);
                    }
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

///
///
/// Dialog per dopo il download
///
///

class DialogUpload extends StatelessWidget {
  String title, path;
  DialogUpload(this.title, this.path);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Hey !'),
      content: FutureBuilder(
        ///
        /// ancora non capisco perche devo mettere una stringa to string ma altrimenti
        /// mi formatta male il dialog devo studiamelo meglio
        ///
          future: HttpHandler.uploadDocument(title.toString(), 'o', path),
          builder: (context, snapshot){
            if(snapshot.hasError)return Container();
            if(snapshot.hasData){
              return Text(snapshot.data.toString());
            } else{
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Prenditi un caffe nel frattempo ;)'),
                  SizedBox(height: 16,),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:<Widget>[CircularProgressIndicator()])
                ],
              );
            }
          }),
      actions: <Widget>[
        FlatButton(onPressed: (){Navigator.pop(context);}, child: Text('Close'))
      ],
    );
  }
}
