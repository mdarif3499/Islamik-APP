
import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';

import '../consts/images.dart';

Widget applogoWidget(){
  return Image.asset(icAppLogo).box.white.size(77, 77).padding(EdgeInsets.all(8)).rounded.make();
}