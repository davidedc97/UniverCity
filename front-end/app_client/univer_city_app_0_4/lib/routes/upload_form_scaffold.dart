import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:univer_city_app_0_4/elements/title_div.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Padding(padding: EdgeInsets.symmetric(vertical: 8),
              child: TitleDivider('File upload'),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                        return tag._tag.toLowerCase().contains(query.toLowerCase());
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
                  onChanged: (tags){
                    return debugPrint('cambio tag');
                  })),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(labelText: 'Title'))),
          Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(labelText: 'Course'))),
          Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(labelText: 'Professor'))),
          Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: TextField(
                maxLines: 4,
                textAlign: TextAlign.center,
                decoration: InputDecoration(labelText: 'Description'))),
          Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: RaisedButton.icon(
                icon: Icon(Icons.add_circle_outline),
                label: Text('UPLOAD'),
                onPressed: (){
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          title: Text('Tank you!'),
                          content: Text('Sharing your notes will help all the community'),
                          actions: <Widget>[
                            FlatButton(onPressed: (){Navigator.pop(context);}, child: Text('Close'))
                          ],
                        );
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
