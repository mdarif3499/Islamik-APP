import 'package:al_hadith_app/controllers/db_controller.dart';
import 'package:al_hadith_app/widget_common/bg_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../consts/colors/colors.dart';
import '../consts/progressbar.dart';
import '../consts/string/string.dart';
import '../models/DbHelper/dbhelper.dart';

class ShowHadish extends StatefulWidget {
  const ShowHadish({Key? key}) : super(key: key);

  @override
  State<ShowHadish> createState() => _ShowHadishState();
}

class _ShowHadishState extends State<ShowHadish> {
  var controler = Get.put(DbController());
  late List<HadithModel> data;
  String namee = "name";

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Obx(
      () => !controler.check.value
          ? loadingIndicator()
          : Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${data[3].title}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        GestureDetector(
                          child: Text(
                            '${data[2].title}',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          onTap: () async {},
                        )
                      ],
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      child: Image.asset("assets/images/settings-sliders.png")
                          .box
                          .make(),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.white,
                        ),
                      ),
                    ).box.roundedSM.make(),
                  ],
                ),
                leading: Image.asset("assets/images/back.png"),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: "${data[1].number}  ",
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${data[1].title}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Divider(),
                        Text("${data[1].preface}"),
                      ],
                    )
                        .box
                        .color(Colors.white)
                        .padding(EdgeInsets.all(10.0))
                        .rounded
                        .make(),
                    10.heightBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                child: Row(
                              children: [
                                Center(
                                        child: Container(
                                  child: Text(
                                    '${data[3].abvr_code}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                                )
                                    .box
                                    .size(40, 40)
                                    .roundedFull
                                    .color(Colors.green)
                                    .make(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${data[3].title}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    GestureDetector(
                                      child: Text(
                                        'subtitle',
                                        style: TextStyle(
                                            color: Colors.teal,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onTap: () {},
                                    ),
                                  ],
                                ).box.padding(EdgeInsets.only(left: 10)).make(),
                              ],
                            )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                  onPressed: () {},
                                  child: Text(
                                    '${data[0].grade}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.teal,
                                    shape: StadiumBorder(),
                                  ),
                                ),
                                10.widthBox,
                                Image.asset("assets/images/dots.png")
                              ],
                            )
                          ],
                        ).box.roundedSM.make(),
                        20.heightBox,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${data[0].ar}",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     Text(
                        //       data.ar,

                        //     )
                        //   ],
                        // )
                      ],
                    )
                        .box
                        .color(Colors.white)
                        .padding(EdgeInsets.all(12.0))
                        .roundedSM
                        .make(),
                  ],
                )
                    .box
                    .rounded
                    .color(goldenn)
                    .padding(EdgeInsets.all(12))
                    .size(context.screenWidth, context.screenHeight)
                    .make(),
              )),
    ));
  }

  void getData() async {
    data = (await controler.getData())!;
  }
}
