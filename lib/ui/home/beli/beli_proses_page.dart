import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tokomobil/bloc/user/transaksi/transaksi_bloc.dart';
import 'package:tokomobil/controllers/home/transaksi_controller.dart';
import 'package:tokomobil/static_data.dart';
import 'package:tokomobil/ui/components/my_button.dart';
import 'package:tokomobil/ui/components/my_input.dart';
import 'package:tokomobil/ui/components/my_input_multiline.dart';
import 'package:tokomobil/utils/convert_util.dart';
import 'package:tokomobil/utils/toast_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BeliProsesPage extends StatelessWidget {
  final controller = Get.put(TransaksiController());
  Map<String, dynamic> mobil;
  int jumlah;
  @override
  Widget build(BuildContext context) {
    mobil = Get.arguments;
    controller.mobil.assignAll(mobil);
    return Scaffold(
        backgroundColor: StaticData.bgColor,
        appBar: AppBar(
          title: Text("Beli"),
        ),
        body: BlocProvider(
          create: (context) => TransaksiBloc(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: BeliProsesView(),
          ),
        ));
  }
}

class BeliProsesView extends StatelessWidget {
  final controller = Get.find<TransaksiController>();
  TransaksiBloc bloc;
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<TransaksiBloc>(context);
    return BlocListener<TransaksiBloc, TransaksiState>(
      listener: (context, state) {
        if (state is TransaksiStateError) {
          controller.isLoading.value = false;
          ToastUtil.error(message: state.errors['message'] ?? '');
        } else if (state is TransaksiStateSuccess) {
          controller.isLoading.value = false;
          Get.offNamedUntil("/user/beli/riwayat", ModalRoute.withName('/home'));
          ToastUtil.success(message: state.data['message'] ?? '');
        }
      },
      child: Form(
        key: _key,
        child: ListView(
          children: [
            ListTile(
              title: Text("Total bayar"),
              subtitle: Obx(() => Text(
                  "Rp${ConvertUtil.formatMoney(int.parse(controller.mobil['mobil_harga']) * controller.jumlah.value)}")),
              tileColor: Colors.white,
              leading: Icon(Icons.monetization_on),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.white,
              child: Column(
                children: [
                  Txt("Jumlah"),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onLongPressStart: (_) async {
                          controller.istapmin.value = true;
                          do {
                            if (controller.jumlah.value > 1) {
                              controller.jumlah.value--;
                            } else {
                              controller.istapmin.value = false;
                            }
                            await Future.delayed(Duration(milliseconds: 100));
                          } while (controller.istapmin.value);
                        },
                        onLongPressEnd: (_) =>
                            controller.istapmin.value = false,
                        onTap: () {
                          if (controller.jumlah.value > 1) {
                            controller.jumlah.value--;
                          }
                        },
                        child: Parent(
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                          style: ParentStyle()
                            ..background.color(Colors.redAccent)
                            ..padding(all: 5)
                            ..borderRadius(all: 10)
                            ..elevation(1),
                        ),
                      ),
                      Obx(() => Txt(
                            "${controller.jumlah.value}",
                            style: TxtStyle()
                              ..textColor(Colors.black54)
                              ..fontSize(15..ssp),
                          )),
                      GestureDetector(
                        onLongPressStart: (_) async {
                          controller.istapplus.value = true;
                          do {
                            controller.jumlah.value++;
                            await Future.delayed(Duration(milliseconds: 100));
                          } while (controller.istapplus.value);
                        },
                        onLongPressEnd: (_) =>
                            controller.istapplus.value = false,
                        onTap: () {
                          controller.jumlah.value++;
                        },
                        child: Parent(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          style: ParentStyle()
                            ..background.color(Colors.greenAccent[700])
                            ..padding(all: 5)
                            ..borderRadius(all: 10)
                            ..elevation(1),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MyInputMultiLine(
              title: "Alamat",
              validator: (String value) {
                if (value.isEmpty) {
                  return "Alamat harus diisi";
                }
                return null;
              },
              controller: controller.alamatController,
            ),
            SizedBox(
              height: 10,
            ),
            MyInput(
              title: "No Telepon (WA)",
              type: TextInputType.number,
              controller: controller.noTelpController,
              validator: (String value) {
                if (value.isEmpty) {
                  return "no telepon (WA) tidak boleh kosong";
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            MyInputMultiLine(
              title: "Keterangan (Opsional)",
              controller: controller.keteranganController,
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: Obx(() => MyButton(
                    isLoading: controller.isLoading.value,
                    title: "Simpan",
                    onTap: (controller.isLoading.value)
                        ? () {}
                        : () {
                            if (_key.currentState.validate()) {
                              controller.proses(context);
                            }
                          },
                  )),
            )
          ],
        ),
      ),
    );
  }
}
