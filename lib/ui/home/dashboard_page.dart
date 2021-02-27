import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tokomobil/controllers/home/home_controller.dart';
import 'package:tokomobil/static_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class DashboardPage extends StatelessWidget {
  HomeController controller;
  @override
  Widget build(BuildContext context) {
    controller = Get.find<HomeController>();
    return Column(
      children: [
        Txt("Home",
            style: TxtStyle()
              ..fontSize(18..ssp)
              ..textColor(Colors.white)
              ..bold()),
        SizedBox(height: 20),
        Parent(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Parent(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Txt("Selamat datang,",
                        style: TxtStyle()
                          ..fontSize(14.ssp)
                          ..textColor(StaticData.textColor.withOpacity(0.8))),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(() => Txt(
                        "${controller.userModel.value.user_nama.capitalize}",
                        style: TxtStyle()
                          ..fontSize(18.ssp)
                          ..textColor(
                            StaticData.textColor,
                          ))),
                  ],
                ),
                style: ParentStyle()
                  ..padding(horizontal: 20, top: 20, bottom: 10),
              ),
              Obx(
                () => (controller.role.value == 2)
                    ? Expanded(
                        child: ListView(
                          children: [
                            controller.tileDefault(
                                title: "Beli",
                                onTap: () {
                                  Get.toNamed("/user/beli");
                                }),
                          ],
                        ),
                      )
                    : Container(),
              ),
            ],
          ),
          style: ParentStyle()
            ..background.color(StaticData.bgColor2)
            ..width(Get.width)
            ..height(Get.height)
            ..borderRadius(all: 20),
        )
      ],
    );
  }
}
