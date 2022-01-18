import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardComponent extends StatelessWidget {
  //must fill
  Widget contain;

  //optional
  EdgeInsetsGeometry? margin;
  CardComponent({required this.contain,this.margin});

  @override
  Widget build(BuildContext context) {
    return Card(    
      child: Container(margin: margin ?? EdgeInsets.all(10), child: contain),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      shadowColor: Colors.black54,
      elevation: 4,
    );
  }
}