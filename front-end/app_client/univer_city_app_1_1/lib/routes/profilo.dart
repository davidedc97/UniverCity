import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:univer_city_app_1_1/elements/elements.dart';
import 'package:univer_city_app_1_1/http_handling/http_handler.dart';

class Profilo extends StatelessWidget {
  final String userName;
  Profilo(this.userName);

  @override
  Widget build(BuildContext context) {
    //ProfiloBloc bloc = ProfiloBlocProvider.of(context);
    Future<User> user = HttpHandler.getUserData(userName);
    return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text('Profilo',
                    style: TextStyle(
                      fontSize: 16.0,
                    )),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return Column(
                    children: <Widget>[
                      //TODO passare flag per abilitare disabilitare la modifica dell img
                      FutureBuilder(
                        future: user,
                        builder: (context, AsyncSnapshot<User> snapshot) {
                          if (snapshot.hasData) return HeadProfile(snapshot.data.user.trim(), snapshot.data.faculty.trim(), snapshot.data.img.trim(), SessionUser().user==snapshot.data.user.trim()?'mod':'nomod');
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
                      //TODO passare flag per abilitare disabilitare la modifica
                      FutureBuilder(
                        future: user,
                        builder: (context, AsyncSnapshot<User> snapshot) {
                          if (snapshot.hasData)return ProfileBio(snapshot.data.bio?.trim(), SessionUser().user==snapshot.data.user.trim()?'mod':'nomod');
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
                  );
                },
                childCount: 1,
              ),
            )
          ],
        )
    );
  }
}
