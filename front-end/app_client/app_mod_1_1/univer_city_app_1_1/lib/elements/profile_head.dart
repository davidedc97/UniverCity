import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/http_handling/http_handler.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:univer_city_app_1_1/elements/session_user.dart';

class HeadProfile extends StatelessWidget {
  final String userName, pathImage, corsoStudi;
  final String flag;
  HeadProfile(this.userName, this.corsoStudi, this.pathImage, this.flag);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 24, left: 16, bottom: 8, right: 16),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: ()async{
              if(flag=='mod'){
                FlutterDocumentPickerParams params = FlutterDocumentPickerParams(
                  allowedFileExtensions: ['png', 'jpg'],
                );

                try{
                  final String path = await FlutterDocumentPicker.openDocument(params: params) ??'';
                  if(path != ''){
                    int v = await HttpHandler.changeUserImg(SessionUser.user, path);
                    debugPrint(v.toString());
                  }
                }catch(e){
                  // TODO show only img
                  showDialog(context: context, builder: (context)=>AlertDialog(title: Text('Attenzione !'),content: Text('puoi caricare solo immagini')));
                }
              }
            },
            child: Container(
              width: 100.0,
              height: 100.0,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new NetworkImage(pathImage),
                  fit: BoxFit.cover,
                ),
                borderRadius:
                BorderRadius.all(new Radius.circular(100.0)),
                border: new Border.all(
                  color: Theme.of(context).accentColor,
                  width: 4.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  userName,
                  style: TextStyle(fontSize: 20),
                ),
                Text(corsoStudi)
              ],
            ),
          )
        ],
      ),
    );
  }
}