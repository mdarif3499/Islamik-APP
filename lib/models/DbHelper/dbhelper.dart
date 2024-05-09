import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;


class DictionaryDataBaseHelper {
  late Database _db;

  Future<List<HadithModel>?> init() async {
    io.Directory applicationDirectory =
    await getApplicationDocumentsDirectory();

    String dbPathEnglish =
    path.join(applicationDirectory.path, "hadith_db.db");

    bool dbExistsEnglish = await io.File(dbPathEnglish).exists();

    if (!dbExistsEnglish) {
      // Copy from asset
      ByteData data = await rootBundle.load(path.join("assets", "hadith_db.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await io.File(dbPathEnglish).writeAsBytes(bytes, flush: true);
    }

    this._db = await openDatabase(dbPathEnglish);
  return getHadithFromDB() ;


  }

  Future<List<HadithModel>?> getHadithFromDB() async {
    if (_db == null) {
      print("bd is not initiated, initiate using [init(db)] function") ;

      throw "bd is not initiated, initiate using [init(db)] function";

    }
    List<Map<String, dynamic>> hadith=[];
    List<Map<String, dynamic>> books=[];
    List<Map<String, dynamic>> chapter=[];
    List<Map<String, dynamic>> section=[];

    await _db.transaction((txn) async {
      hadith = await txn.query(
        "hadith",
        columns: [
          "hadith_id",
          "book_id",
          "book_name",
          "chapter_id",
          "section_id",
          "ar_diacless",
          "bn",
          "ar",
          "grade",
        ],
      );
    });

    await _db.transaction((txn) async {
      section  = await txn.query(
        "section",
        columns: [
          "id",
          "book_id",
          "book_name",
          "chapter_id",
          "section_id",
          "title",
          "preface",
          "number",
        ],
      );
    });



    await _db.transaction((txn) async {
      chapter = await txn.query(
        "chapter",
        columns: [
          "id",
          "chapter_id",
          "book_id",
          "title",
          "number",
          "hadis_range",
          "book_name",],
      );
    });

    await _db.transaction((txn) async {
      books  = await txn.query(
        "books",
        columns: [
          "id",
          "title",
          "title_ar",
          "number_of_hadis",
          "abvr_code",
          "book_name",
          "book_descr",

        ],
      );
    });
    hadith.forEach((element) {
      print("..........hadith.....${element}");
    });

    // hadith.forEach((element) {
    //   print("${element}");
    //
    //
    // });
   var hadithM= hadith.map((e) =>HadithModel .fromJson(e)).toList();
   var sectionM= section.map((e) =>HadithModel .fromJson(e)).toList();
   var chapterM= chapter.map((e) =>HadithModel .fromJson(e)).toList();
   var bookM= books.map((e) =>HadithModel .fromJson(e)).toList();
   List <HadithModel> data=[];
   data.clear();
   data.add(hadithM[0] );
   data.add(sectionM[0]);
   data.add(chapterM[0]);
   data.add(bookM[0]);


    return  data;
  }
}





class HadithModel {
  var hadith_id;
  var book_id;
  var book_name;
  var chapter_id;
  var section_id;
  var narrator;
  var ar_diacless;
  var bn;
  var ar;
  var id;
  var title;
  var preface;
  var number;
  var abvr_code;
  var grade;


  HadithModel({
    required this.hadith_id,
    required this.book_id,
    required this.book_name,
    required this.chapter_id,
    required this.section_id,
    required this.narrator,
    required this.ar_diacless,
    required this.ar,
    required this.bn,
    required this.id,
    required this.title,
    required this.preface,
    required this.number,
    required this.grade,
    required this.abvr_code,
  });



  factory HadithModel.fromRawJson(String str) => HadithModel.fromJson(json.decode(str));

   String toRawJson() => json.encode(toJson());

  factory HadithModel.fromJson(Map<String, dynamic> json) => HadithModel(
    hadith_id: json["hadith_id"],
    book_id: json["book_id"],
    book_name: json["book_name"],
    chapter_id: json["chapter_id"],
    section_id: json["section_id"],
    narrator: json["narrator"],
    ar_diacless: json["ar_diacless"],
    ar: json["ar"],
    bn: json["bn"],
    id: json["id"],
    title: json["title"],
    preface: json["preface"],
    number: json["number"],
    grade: json["grade"],
    abvr_code: json["abvr_code"],
  );

  Map<String, dynamic> toJson() => {
    "hadith_id": hadith_id,
    "book_id": book_id,
    "book_name": book_name,
    "chapter_id": chapter_id,
    "section_id": section_id,
    "narrator": narrator,
    "ar_diacless": ar_diacless,
    "bn": bn,
    "ar": ar,
    "id": id,
    "title": title,
    "preface": preface,
    "number": number,
    "abvr_code": abvr_code,
    "grade": grade,
  };
}