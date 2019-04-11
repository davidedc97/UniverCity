import 'package:flutter/material.dart';


///
///
///  Decorazione per un container o un Sized Box Per fargli
///  avere un ombra e uno sfondo bianco
///
///
BoxDecoration boxBgeOmbra(Color c){
  return BoxDecoration(color: c, boxShadow: [
    BoxShadow(blurRadius: 4.0, color: Colors.black, offset: Offset(0.0, 0.0))
  ]);
}
