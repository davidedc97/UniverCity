import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/elements/document.dart';
import 'package:univer_city_app_1_1/elements/pre_viewer.dart';
import 'package:univer_city_app_1_1/elements/title_div.dart';

class DocList extends StatelessWidget {

  final Document _info;

  DocList(this._info);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).cardColor,border: BorderDirectional(bottom: BorderSide(color: Theme.of(context).dividerColor))),
      child: ListTile(
        title:Text(_info.title),
        subtitle: (_info.creator != null)
            ? Text(_info.creator)
            : Text(''),
        leading: Icon(Icons.description),
        trailing: IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: (){
              //visualizzazione pre viewer
              showDialog(
                context: context,
                builder: (context)=>buildDocDialog(context, _info.title,_info.creator, _info.uuid)
              );}
        ),
        onTap: ()async{
          showDialog(
              context: context,
              builder: (context)=>buildDocDialog(context,_info.title,_info.creator , _info.uuid)
          );
        },
      ),
    );
  }
}

class DocListDividedTitle extends StatelessWidget {

  final Document _info ;
  final String _title;
  DocListDividedTitle(this._title,this._info);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleDivider(_title),
        Container(
          decoration: BoxDecoration(color: Theme.of(context).cardColor,border: BorderDirectional(bottom: BorderSide(color: Theme.of(context).dividerColor))),

          child: ListTile(
            title:Text(_info.title),
            subtitle: (_info.creator != null)
                ? Text(_info.creator)
                : Text(''),
            leading: Icon(Icons.description),
            trailing: IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: (){
                  //visualizzazione pre viewer
                  showDialog(
                      context: context,
                      builder: (context)=>buildDocDialog(context, _info.title,_info.creator, _info.uuid)
                  );}
            ),
            onTap: ()async{
              showDialog(
                  context: context,
                  builder: (context)=>buildDocDialog(context,_info.title,_info.creator , _info.uuid)
              );
            },
          ),
        )
      ],
    );
  }
}

