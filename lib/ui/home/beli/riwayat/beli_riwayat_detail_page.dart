import 'package:cached_network_image/cached_network_image.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokomobil/controllers/home/home_controller.dart';
import 'package:tokomobil/static_data.dart';
import 'package:tokomobil/utils/convert_util.dart';

class BeliRiwayatDetailPage extends StatelessWidget {
  Map<String, dynamic> transaksi;
  @override
  Widget build(BuildContext context) {
    transaksi = Get.arguments;
    return Scaffold(
        backgroundColor: Colors.white,
        body: BeliRiwayatDetailView(transaksi: transaksi));
  }
}

class BeliRiwayatDetailView extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  final Map<String, dynamic> transaksi;

  BeliRiwayatDetailView({Key key, this.transaksi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> listTile = getListTiles();
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: <Widget>[
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
                      "${StaticData.baseUrl}/uploads/${transaksi['mobil_img']}",
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
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
        SliverList(delegate: SliverChildListDelegate.fixed(listTile)),
      ]),
    );
  }

  List<Widget> getListTiles() {
    List<Widget> lists = [
      ListTile(
        title: Text("Nama Mobil"),
        subtitle: Text("${transaksi['mobil_nama']}"),
        tileColor: Colors.white,
      ),
      ListTile(
        title: Text("Harga"),
        subtitle: Text(
            "Rp${ConvertUtil.formatMoney(int.parse(transaksi['transaksi_harga']))}"),
        tileColor: Colors.white,
      ),
      ListTile(
        title: Text("Jumlah"),
        subtitle: Text(
            "${ConvertUtil.formatMoney(int.parse(transaksi['transaksi_jumlah']))}"),
        tileColor: Colors.white,
      ),
      ListTile(
        title: Text("Total harga"),
        subtitle: Text(
            "${ConvertUtil.formatMoney(int.parse(transaksi['transaksi_jumlah']) * int.parse(transaksi['transaksi_harga']))}"),
        tileColor: Colors.white,
      ),
    ];
    if (homeController.role.value == 1) {
      lists.addAll([
        ListTile(
          title: Text("Nama pembeli"),
          subtitle: Text("${transaksi['user_nama']}"),
          tileColor: Colors.white,
        ),
        ListTile(
          title: Text("Email pembeli"),
          subtitle: Text("${transaksi['user_email']}"),
          tileColor: Colors.white,
        ),
      ]);
    }
    lists.addAll([
      ListTile(
        title: Text("Alamat"),
        subtitle: Text("${transaksi['transaksi_alamat']}"),
        tileColor: Colors.white,
      ),
      ListTile(
        title: Text("No telepon (WA)"),
        subtitle: Text("${transaksi['transaksi_no_telp']}"),
        tileColor: Colors.white,
      ),
      ListTile(
        title: Text("Keterangan"),
        subtitle: Text("${transaksi['transaksi_keterangan']}"),
        tileColor: Colors.white,
      ),
    ]);
    return lists;
  }
}
