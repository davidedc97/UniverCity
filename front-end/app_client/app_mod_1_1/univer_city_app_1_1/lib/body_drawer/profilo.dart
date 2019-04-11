import 'package:flutter/material.dart';
import 'dart:async';
import 'package:univer_city_app_1_1/elements/elements.dart';
import 'package:univer_city_app_1_1/http_handling/http_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:univer_city_app_1_1/bloc/theme_bloc_provider.dart';

class Profilo extends StatefulWidget {
  final String userName;
  Profilo(this.userName);

  @override
  _ProfiloState createState() => _ProfiloState();
}

class _ProfiloState extends State<Profilo> {

  final GlobalKey<RefreshIndicatorState> _rIKProfilo =new GlobalKey<RefreshIndicatorState>();
  static Future<User> user;
  @override
  initState(){
    super.initState();
    user = HttpHandler.getUserData(widget.userName);
  }

  @override
  Widget build(BuildContext context) {
    ThemeBloc tBloc = ThemeBlocProvider.of(context);
    return RefreshIndicator(
            key: _rIKProfilo,
            onRefresh: () async{
              user = HttpHandler.getUserData(widget.userName);
              setState(() {});
            },
            child: Column(
              children: <Widget>[
                FutureBuilder(
                  future: user,
                  builder: (context, AsyncSnapshot<User> snapshot) {
                    if (snapshot.hasData) return HeadProfile(snapshot.data.user.trim(), snapshot.data.faculty.trim(), snapshot.data.img.trim(), SessionUser.user==snapshot.data.user.trim()?'mod':'nomod');
                    return HeadProfile('Caricamento...', 'Caricamento...', 'http://www.jdevoto.cl/web/wp-content/uploads/2018/04/default-user-img.jpg', 'nomod');
                  },
                ),
                FutureBuilder(
                  future: user,
                  builder: (context, AsyncSnapshot<User> snapshot) {
                    if (snapshot.hasData) return LevelBar(snapshot.data.xp);
                    return LevelBar(0);
                  },
                ),
                FutureBuilder(
                  future: user,
                  builder: (context, AsyncSnapshot<User> snapshot) {
                    if (snapshot.hasData)return ProfileBio(snapshot.data.bio?.trim(), SessionUser.user==snapshot.data.user.trim()?'mod':'nomod');
                    return ProfileBio('caricamento...', 'nomod');
                  },
                ),
                FutureBuilder(
                  future: user,
                  builder: (context, AsyncSnapshot<User> snapshot) {
                    if (snapshot.hasData){

                      //snapshot.data.documentUploaded['docs'].map((uuid)=>uuid.toString()).toList();
                      return ShowNoteClp('Appunti caricati', snapshot.data.documentUploaded['docs']);
                    }
                    return ShowNoteClp('Appunti caricati',[]);
                  },
                ),
                FutureBuilder(
                  future: user,
                  builder: (context, AsyncSnapshot<User> snapshot) {
                    if (snapshot.hasData){

                      //snapshot.data.documentUploaded['docs'].map((uuid)=>uuid.toString()).toList();
                      return ShowNoteClp('Mashup creati', []);
                    }
                    return ShowNoteClp('Mashup creati',[]);
                  },
                ),

              ],
            ),
        );
  }
  choiceAction(String choice) {
    if (choice == 'bug') {
      launch('https://github.com/davidedc97/UniverCity/issues/new/');
    }
  }
}