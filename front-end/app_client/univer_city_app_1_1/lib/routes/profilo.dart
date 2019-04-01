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
                            return ShowNoteClp('Appunti caricati', ["bf6a5e06-490b-11e9-b404-46a1abcb3bd6","caaae290-490b-11e9-b321-aac8ccbdb6a1","c7b71ce6-4cb4-11e9-9fbc-3ed937668553","d4261c20-4cb4-11e9-9fbc-3ed937668553","227de77c-4d5f-11e9-b474-3ae076d3bff6","46c157ea-4d5f-11e9-a7e5-fe78be2a438f","6da448c2-4d5f-11e9-8d9e-a6150fd4980c","9e9063ee-4d5f-11e9-943f-3ae076d3bff6","e6265dbc-4d5f-11e9-9af7-de41be2c71f5","e494726c-4d60-11e9-9af7-de41be2c71f5","ee88a694-4d60-11e9-9af7-de41be2c71f5","f58e2676-4d60-11e9-9af7-de41be2c71f5","310a6ca0-4d61-11e9-9af7-de41be2c71f5"]);
                          }
                          return ShowNoteClp('Appunti caricati',[]);
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
