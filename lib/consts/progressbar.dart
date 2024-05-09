
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget loadingIndicator(){
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.red),
    ),
  );
}