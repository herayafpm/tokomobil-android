import 'package:cached_network_image/cached_network_image.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokomobil/static_data.dart';
import 'package:tokomobil/utils/convert_util.dart';

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
    return CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        expandedHeight: 250.0,
        floating: true,
        pinned: true,
        snap: true,
        elevation: 5,
        flexibleSpace: FlexibleSpaceBar(
          title: Text("${mobil['mobil_nama']}"),
          centerTitle: true,
          background: GestureDetector(
            onTap: () {
              // Get.toNamed("/list_image_view",
              //     arguments: barang.barang_foto);
            },
            child: Stack(
              children: [
                CachedNetworkImage(
                  width: Get.width,
                  height: Get.height,
                  imageUrl:
                      "${StaticData.baseUrl}/uploads/${mobil['mobil_img']}",
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
                Parent(
                    child: Container(),
                    style: ParentStyle()
                      ..background.color(Colors.black.withOpacity(0.2))
                      ..width(Get.width)
                      ..height(Get.height))
              ],
            ),
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
      ])),
    ]);
  }
}
