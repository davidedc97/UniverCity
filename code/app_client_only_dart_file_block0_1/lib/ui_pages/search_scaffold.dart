import 'package:flutter/material.dart';
import 'package:univer_city_app_block0_1/elements/app_bar.dart';


class SearchScaffold extends StatefulWidget {
  @override
  _SearchScaffoldState createState() => _SearchScaffoldState();
}

class _SearchScaffoldState extends State<SearchScaffold> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: SearchAppBar(),
    );
  }
}
