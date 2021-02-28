import 'package:cached_network_image/cached_network_image.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokomobil/static_data.dart';
import 'package:tokomobil/utils/convert_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BeliDetailPage extends StatelessWidget {
  Map<String, dynamic> mobil;
  @override
  Widget build(BuildContext context) {
    mobil = Get.arguments;
    return Scaffold(
        backgroundColor: Colors.white, body: BeliDetailView(mobil: mobil));
  }
}

class BeliDetailView extends StatelessWidget {
  final Map<String, dynamic> mobil;

  const BeliDetailView({Key key, this.mobil}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 250.0,
              floating: true,
              pinned: true,
              snap: true,
              elevation: 5,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    CachedNetworkImage(
                      width: Get.width,
                      height: Get.height,
                      imageUrl:
                          "${StaticData.baseUrl}/uploads/${mobil['mobil_img']}",
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          new CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: Parent(
                          child: Container(),
                          style: ParentStyle()
                            ..background.color(Colors.black.withOpacity(0.2))),
                    )
                  ],
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate.fixed(<Widget>[
              ListTile(
                title: Text("Nama"),
                subtitle: Text("${mobil['mobil_nama']}"),
                tileColor: Colors.white,
              ),
              ListTile(
                title: Text("Harga"),
                subtitle: Text(
                    "Rp${ConvertUtil.formatMoney(int.parse(mobil['mobil_harga']))}"),
                tileColor: Colors.white,
              ),
              ListTile(
                title: Text("Keterangan"),
                subtitle: Text("${mobil['mobil_keterangan']}"),
                tileColor: Colors.white,
              ),
              SizedBox(
                height: 100,
              )
            ])),
          ]),
          Align(
            alignment: Alignment.bottomCenter,
            child: Parent(
              gesture: Gestures()
                ..onTap(() {
                  Get.toNamed("/user/beli/proses", arguments: mobil);
                }),
              child: Txt(
                "Beli",
                style: TxtStyle()
                  ..alignment.center()
                  ..fontSize(16.ssp)
                  ..textColor(Colors.white)
                  ..fontWeight(FontWeight.bold),
              ),
              style: ParentStyle()
                ..margin(bottom: 20)
                ..width(0.7.sw)
                ..height(50)
                ..background.color(StaticData.bgColor)
                ..elevation(2)
                ..borderRadius(all: 10),
            ),
          )
        ],
      ),
    );
  }
}
