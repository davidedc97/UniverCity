import 'package:univer_city_app_1_1/elements/elements.dart';
import 'package:univer_city_app_1_1/bloc/preferiti_bloc_provider.dart';

class Home extends StatefulWidget {
  final PreferitiBloc bloc;
  Home(this.bloc);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // List<String>
  List<String> fav = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.bloc.preferiti,
      builder: (context, snapshot) {
        print('refresh builder HOME');
        fav = widget.bloc.preferitiValue;
        if (fav.isEmpty) {
          return PreferitiSfondo();
        } else {
          return ListView.builder(
            itemBuilder: (context, i) {
              if (i == 0) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: TitleDivider('Preferiti'),
                );
              }
              if (i == fav.length + 1)
                return SizedBox(
                  height: 72,
                );
              return Dismissible(
                key: Key(fav[i - 1]),
                background: Container(
                    color: Theme.of(context).accentColor,
                    child: Center(
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[Icon(Icons.delete)])))),
                secondaryBackground: Container(
                    color: Theme.of(context).accentColor,
                    child: Center(
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[Icon(Icons.delete)])))),
                child: DocListFuture(fav[i - 1]),
                onDismissed: (direction) {
                  setState(() {
                    widget.bloc.removeInFavourite(fav[i - 1]);
                  });
                },
              );
            },
            itemCount: fav.length + 2,
          );
        }
      },
    );
  }
}

class PreferitiSfondo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: TitleDivider('Qui compariranno i tuoi preferiti'),
      ),
      Text('Dai ci saranno degli appunti alla tua altezza, salva qualcosa !',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24.0,
            color: Colors.grey,
          )),
      Padding(
          padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 32.0),
          child: Center(child: Image.asset('assets/img/preferitiDocOmb.png')))
    ]);
  }
}
