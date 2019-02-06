import 'package:flutter/material.dart';
import 'package:univer_city_app_0_3/elements/document_formatting.dart';
import 'package:univer_city_app_0_3/elements/doc_list.dart';

class DocCard extends StatelessWidget {

  final DocumentInfo _info;

  DocCard(this._info);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      color: Colors.white,
      child: SizedBox(
        height: 70,
        width: 300,
        child: DocList(_info),
      ),
    );
  }
}