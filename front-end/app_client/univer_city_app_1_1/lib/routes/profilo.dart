import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/elements/elements.dart';
import 'package:univer_city_app_1_1/bloc/profilo_bloc_provider.dart';


class Profilo extends StatelessWidget {
  final String uuid = '550e8400-e29b-41d4-a716-446655440017',
      userName;
  Profilo(this.userName);

  @override
  Widget build(BuildContext context) {
    ProfiloBloc bloc = ProfiloBlocProvider.of(context);
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
                      StreamBuilder(
                        stream: bloc.headProfile,
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            return HeadProfile(snapshot.data[0], snapshot.data[1], snapshot.data[2],SessionUser().user==snapshot.data[0]?'m':'nm');
                          }if(!snapshot.hasData){
                            return HeadProfile('Caricamento...', 'Caricamento...', 'http://www.jdevoto.cl/web/wp-content/uploads/2018/04/default-user-img.jpg','nomod');
                          }
                        },
                      ),
                      StreamBuilder(
                        stream: bloc.xp,
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            return LevelBar(snapshot.data);
                          }if(!snapshot.hasData){
                            return LevelBar(0);
                          }
                        },
                      ),
                      //TODO passare flag per abilitare disabilitare la modifica
                      StreamBuilder(
                        stream: bloc.bio,
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            return ProfileBio(snapshot.data, SessionUser().user==snapshot.data[0]?'mod':'nomod');
                          }if(!snapshot.hasData){
                            return ProfileBio('caricamento...', 'nomod');
                          }
                        },
                      ),
                      StreamBuilder(
                        stream: bloc.originali,
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            return ShowNoteClp('Appunti caricati',snapshot.data);
                          }if(!snapshot.hasData){
                            return ShowNoteClp('Appunti caricati',[]);
                          }
                        },
                      ),
                      StreamBuilder(
                        stream: bloc.mashup,
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            return ShowNoteClp('Mashup creati',snapshot.data);
                          }if(!snapshot.hasData){
                            return ShowNoteClp('Mashup creati',[]);
                          }
                        },
                      ),
                    ],
                  );
                },
                childCount: 1,
              ),
            )
          ],
        ));
  }
}