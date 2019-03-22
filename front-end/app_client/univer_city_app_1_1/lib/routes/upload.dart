import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/bloc/upload_bloc_provider.dart';
import 'package:univer_city_app_1_1/elements/elements.dart';
import 'package:univer_city_app_1_1/http_handling/http_handler.dart';

class Upload extends StatelessWidget {
  final String path;
  Upload(this.path);
  @override
  Widget build(BuildContext context) {
    final UploadBloc _bloc = UploadBlocProvider.of(context);
    _bloc.onPathChanged(path);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Carica',
              style:
                  TextStyle(fontSize: 18, color: Theme.of(context).accentColor),
            ),
            onPressed: () => carica(context),
          )
        ],
        title: Text(
          'Nuovo appunto',
        ),
      ),
      body: UploadFormBody(path),
    );
  }
}

class UploadFormBody extends StatelessWidget {
  final String path;
  UploadFormBody(this.path);
  @override
  Widget build(BuildContext context) {
    final UploadBloc _bloc = UploadBlocProvider.of(context);
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 52, vertical: 32),
          child: Column(
            children: <Widget>[
              Text('Hey, ${SessionUser().user} cosa vuoi caricare oggi ?   ;)', style: TextStyle(fontSize: 24), textAlign: TextAlign.center,),
              SizedBox(height: 18),
              StreamBuilder<String>(
                  stream: _bloc.titolo,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: 'Titolo',
                          errorText: snapshot.error,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor))),
                      onChanged: _bloc.onTitoloChanged,
                      keyboardType: TextInputType.emailAddress,
                    );
                  }),
              StreamBuilder<String>(
                  stream: _bloc.tags,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: 'Tags',
                          errorText: snapshot.error,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor))),
                      onChanged: _bloc.onTagsChanged,
                      keyboardType: TextInputType.emailAddress,
                    );
                  }),
              SizedBox(height: 18),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Vuoi annullare ?'),
                  FlatButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/home', (Route<dynamic> route) => false);
                      },
                      child: Text('ANNULLA',
                          style:
                              TextStyle(color: Theme.of(context).accentColor)))
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

carica(context) {
  final UploadBloc _bloc = UploadBlocProvider.of(context);

  debugPrint('carica ${_bloc.pathValue} titolo ${_bloc.titoloValue} tag ${_bloc.tagsValue}');
  if (_bloc.titoloValue == '' || _bloc.tagsValue == '') {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ops!'),
            content: Text('Devi inserire sia il titolo che i tags :/'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close'))
            ],
          );
        });
  }
  debugPrint('prima del pop');
  Navigator.of(context).pop();
  debugPrint('dopo del pop');
  debugPrint('show dialog 137');
  showDialog(
      context: context,
      builder: (context) {
        debugPrint('dentro dialog 141');
        return AlertDialog(
          title: Text('Hey !'),
          content: FutureBuilder(
              future: HttpHandler.uploadDocument(_bloc.titoloValue, _bloc.pathValue),
              builder: (context, snapshot) {
                debugPrint('dentro builder 165');
                if (snapshot.hasError) return Container();
                if (snapshot.hasData) {
                  return Text((snapshot.data == 1)
                      ? 'Upload completato'
                      : (snapshot.data == -1)
                          ? 'Qualche paramentro è sbagliato'
                          : '500 server error');
                } else {
                  debugPrint('dialog 176');
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('Upload in corso ;)'),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[CircularProgressIndicator()])
                    ],
                  );
                }
              }),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home', (Route<dynamic> route) => false);
                },
                child: Text('Close'))
          ],
        );
      });
}