import 'dart:core';

import 'package:get/get.dart';

import '../models/DbHelper/dbhelper.dart';

class DbController extends GetxController{
  late HadithModel  data;
  var check = false.obs;
   Future<List<HadithModel>?> getData()async{
    var db = DictionaryDataBaseHelper();
    List<HadithModel>? dat = await db.init();

    if(dat!=null){
      check.value=true;
      return dat;
    }
  }


}