import 'package:flutter/material.dart';

class SocialIcons extends StatelessWidget{
  SocialIcons({this.colors,this.iconData,this.onPressed});
  final List<Color> colors;
  final IconData iconData;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
              colors: colors,
              tileMode: TileMode.clamp)),
      child: RawMaterialButton(
        shape: CircleBorder(),
        onPressed: onPressed,
        child: Icon(iconData,color: Colors.white,size: 30,),
      ),
    );
  }
}