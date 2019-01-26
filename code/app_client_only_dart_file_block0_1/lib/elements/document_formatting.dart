import 'package:flutter/material.dart';
//######################################################################################### DocumentInfo
class DocumentInfo{
  String title;
  String subtitle;
  //tipo TRUE = SCRITTO A MANO, FALSE = FORMATTATO
  bool isWrittenByHand;
  DocumentInfo(this.title, this.subtitle, this.isWrittenByHand);
}

//######################################################################################### DocumentInfoListTyle
//Restituisce una ListTyle a partire da un DocumentInfo
// OPPURE
//Restituisce una ListTyle a partire da dati raw
class DocFormatList{

  final Icon _writtenHand = Icon(Icons.gesture);
  final Icon _formatted = Icon(Icons.subject);

  //############################################################################
  //## docTyle restituisce ListRaw a partire da                               ##
  //## (DocumentInfo doc)                                                     ##
  //############################################################################

  ListTile docTile(DocumentInfo doc){
    Icon icoDoc = doc.isWrittenByHand?_writtenHand:_formatted;
    return ListTile(
      leading: icoDoc,
      title: Text(doc.title),
      subtitle: Text(doc.subtitle),
    );
  }

  //############################################################################
  //## docTyleRaw restituisce ListRaw a partire da                            ##
  //## (String title, String subtitle, bool isWrittenByHand)                  ##
  //############################################################################
  ListTile docTileRaw(String title, String subtitle, bool isWrittenByHand){

    Icon icoDoc = isWrittenByHand?_writtenHand:_formatted;
    return ListTile(
      leading: icoDoc,
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}

//######################################################################################### DocumentInfoCard

class DocFormatCard{
  final Icon _writtenHand = Icon(Icons.gesture);
  final Icon _formatted = Icon(Icons.subject);

  //############################################################################
  //## docCard restituisce Card a partire da                           ##
  //## (DocumentInfo doc)                                                     ##
  //############################################################################

  Card docCard(DocumentInfo doc){
    ListTile lt = new DocFormatList().docTile(doc);
    return Card(
      child: lt,
    );
  }

  //############################################################################
  //## CardRaw restituisce Card a partire da                                  ##
  //## (String title, String subtitle, bool isWrittenByHand)                  ##
  //############################################################################
  Card docCardRaw(String title, String subtitle, bool isWrittenByHand){
    
    ListTile lt = new DocFormatList().docTileRaw(title, subtitle, isWrittenByHand);
    return Card(
      child: lt,
    );
  }
}