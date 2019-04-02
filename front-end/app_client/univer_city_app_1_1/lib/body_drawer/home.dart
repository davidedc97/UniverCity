import 'package:univer_city_app_1_1/elements/elements.dart';
import 'package:univer_city_app_1_1/bloc/preferiti_bloc_provider.dart';
import 'package:univer_city_app_1_1/http_handling/http_handler.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final PreferitiBloc _bloc = PreferitiBlocProvider.of(context);
    return StreamBuilder(
      stream: _bloc.preferiti,
      builder: (context,AsyncSnapshot<List<dynamic>> snapshot){
        if (snapshot.hasError)
          return Center(child: Text('Error: ${snapshot.error}'),);
        if(!snapshot.hasData || snapshot.data?.length == 0){
          return Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: TitleDivider('Qui compariranno i tuoi preferiti'),
            ),
            Text(
                'Dai ci saranno degli appunti alla tua altezza, salva qualcosa !',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.grey,
                )),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 32.0),
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.grey,
                  size: 150,
                ))
          ]);
        }
        return ListView.builder(
            itemCount: snapshot.data.length+1,
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: TitleDivider('Preferiti'),
                  );
                default:
                  var f = HttpHandler.getDocumentMetadata(snapshot.data[index - 1]);
                  return FutureBuilder(
                    future: f,
                    builder: (context, AsyncSnapshot<Document> snapshot){
                      if(snapshot.hasError)
                        return Text('Error: ${snapshot.error}');
                      if(!snapshot.hasData){
                        return ListTile(
                          title: Container(child: SizedBox(height: 20,width: 200,),color: Colors.grey[300],),
                          subtitle: Container(child: SizedBox(height: 10,width: 300,),color: Colors.grey[300],),
                          leading: Container(child: SizedBox(height: 20,width: 20,),color: Colors.grey[300],),
                          trailing: Icon(Icons.more_vert),
                        );
                      }
                      return Dismissible(
                        direction: DismissDirection.horizontal,
                        child: DocList(snapshot.data),
                        background: Container(color: Colors.red,child: Center(child: Icon(Icons.delete),)),
                        onDismissed: (_){
                          HttpHandler.removeUserFavourite(SessionUser().user, snapshot.data.uuid);
                        }, key: null,
                      );

                    },
                  );
              }
            });
      },
    );
  }
}
