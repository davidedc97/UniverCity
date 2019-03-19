import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/bloc/upload_bloc_provider.dart';
import 'package:univer_city_app_1_1/elements/elements.dart';
import 'package:univer_city_app_1_1/http_handling/http_handler.dart';

class Upload extends StatelessWidget {
  final String path;
  Upload(this.path);
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
      body: UploadFormBody(path),
    );
  }
}

class UploadFormBody extends StatelessWidget {
  final String path;
  String _titolo,_tags;
  UploadFormBody(this.path);
  @override
  Widget build(BuildContext context) {
    final UploadBloc _uploadBloc = UploadBlocProvider.of(context);
    _uploadBloc.titolo.listen((data){_titolo = data??'';});
    _uploadBloc.tags.listen((data){_tags = data??'';});
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 64),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height-500,
              ),
              Text(
                'UPLOAD FORM',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 24,
              ),

              StreamBuilder<String>(
                  stream: _uploadBloc.titolo,
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: 'Titolo',
                          errorText: snapshot.error,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor))),
                      onChanged: _uploadBloc.onTitoloChanged,
                      keyboardType: TextInputType.emailAddress,
                    );
                  }),
              StreamBuilder<String>(
                  stream: _uploadBloc.tags,
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Tags',
                          errorText: snapshot.error,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor))),
                      onChanged: _uploadBloc.onTagsChanged,
                      keyboardType: TextInputType.emailAddress,
                    );
                  }),

              SizedBox(
                height: 42,
              ),
              //################################################################ Get Started Button
              BtnLogin(
                color: Theme.of(context).accentColor,
                title: 'CARICA',
                onPressed: () => carica(context, _titolo ?? '', _tags ?? '', path),
              ),
              //################################################## LOGIN if already have an account
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Vuoi annullare ?'),
                  FlatButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
                      },
                      child: Text('ANNULLA',
                          style: TextStyle(color: Theme.of(context).accentColor)))
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

carica(context, String titolo, String tags, String path){
  if (titolo == '' || tags == '') {
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
        });}
  Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
  showDialog(
      context: context,
      builder:(context){
        return DialogUpload(titolo, path);
      }
  );
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
    print('dialog $path');
    return AlertDialog(
      title: Text('Hey !'),
      content: FutureBuilder(
        ///
        /// ancora non capisco perche devo mettere una stringa to string ma altrimenti
        /// mi formatta male il dialog devo studiamelo meglio
        ///
          future: HttpHandler.uploadDocument(title, path),
          builder: (context, snapshot){
            if(snapshot.hasError)return Container();
            if(snapshot.hasData){
              return Text(
                  (snapshot.data==1)
                      ?'Upload completato'
                      :(snapshot.data==-1)
                      ?'Qualche paramentro è sbagliato'
                      :'500 server error'
              );
            } else{
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Upload in corso ;)'),
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