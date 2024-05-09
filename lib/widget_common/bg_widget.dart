import 'package:flutter/cupertino.dart';

Widget bgWidget({Widget? child}){
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage
        ('assets/images/background.jpg'),fit: BoxFit.fill),
    ),
    child: child,
  );
}