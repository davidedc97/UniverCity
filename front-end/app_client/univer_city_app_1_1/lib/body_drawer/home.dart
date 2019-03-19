import 'package:univer_city_app_1_1/elements/elements.dart';
import 'package:univer_city_app_1_1/bloc/preferiti_bloc_provider.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final PreferitiBloc _bloc = PreferitiBlocProvider.of(context);
    return StreamBuilder(
      stream: _bloc.preferiti,
      builder: (context, snapshot){
        if (snapshot.hasError)
          return Center(child: Text('Error: ${snapshot.error}'),);
        if(!snapshot.hasData){
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
                  return snapshot.data[index - 1];
              }
            });
      },
    );
  }
}
