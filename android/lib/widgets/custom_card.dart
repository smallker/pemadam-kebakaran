import 'package:flutter/material.dart';

import 'mytext.dart';

class MyCard extends StatelessWidget {
  final double cardSize;
  final double fontSize;
  final Color fontColor;
  final Color cardColor;
  final Icon icon;
  final String title;
  final String subtitle;
  const MyCard(
      {Key key,
      this.cardSize,
      this.fontSize,
      this.fontColor,
      this.cardColor,
      this.icon,
      this.title,
      this.subtitle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardSize == null ? double.maxFinite : cardSize,
      child: ListTile(
        leading: icon,
        tileColor: cardColor,
        title: MyText(
          text: title,
          fontSize: fontSize / 2,
          color: fontColor,
        ),
        subtitle: MyText(
          text: title,
          fontSize: fontSize,
          color: fontColor,
        ),
      ),
    );
  }
}
