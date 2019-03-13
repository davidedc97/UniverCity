import 'package:flutter/material.dart';
import 'package:univer_city_app_1_1/elements/elements.dart';
import 'package:univer_city_app_1_1/mashup_tab/mashup_tab.dart';

class Mashup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        ITuoi(),
        Esplora(),
      ],
    );
  }
}
