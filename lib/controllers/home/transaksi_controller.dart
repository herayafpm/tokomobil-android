import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tokomobil/bloc/user/transaksi/transaksi_bloc.dart';

class TransaksiController extends GetxController {
  TextEditingController alamatController = TextEditingController();
  TextEditingController noTelpController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();
  final isLoading = false.obs;
  final istapmin = false.obs;
  final istapplus = false.obs;
  final mobil = Map<String, dynamic>().obs;
  final jumlah = 1.obs;

  void proses(context) {
    isLoading.value = true;
    Map<String, dynamic> json = Map<String, dynamic>();
    json['mobil_id'] = mobil['mobil_id'];
    json['transaksi_harga'] = mobil['mobil_harga'];
    json['transaksi_jumlah'] = jumlah.value;
    json['transaksi_alamat'] = alamatController.text;
    json['transaksi_no_telp'] = noTelpController.text;
    json['transaksi_keterangan'] = keteranganController.text;
    BlocProvider.of<TransaksiBloc>(context)..add(TransaksiTambahEvent(json));
  }
}
