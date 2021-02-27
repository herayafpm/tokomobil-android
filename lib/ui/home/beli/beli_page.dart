import 'package:cached_network_image/cached_network_image.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tokomobil/bloc/user/mobil/mobil_bloc.dart';
import 'package:tokomobil/static_data.dart';
import 'package:tokomobil/utils/convert_util.dart';
import 'package:tokomobil/utils/toast_util.dart';

class BeliPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StaticData.bgColor,
      appBar: AppBar(
        title: Text("Beli Mobil"),
      ),
      body: Stack(
        children: [
          BlocProvider<MobilBloc>(
            create: (context) => MobilBloc()..add(MobilGetListEvent()),
            child: BeliView(),
          ),
        ],
      ),
    );
  }
}

class BeliView extends StatelessWidget {
  MobilBloc bloc;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    bloc..add(MobilGetListEvent(refresh: true));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    bloc..add(MobilGetListEvent());
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<MobilBloc>(context);
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Container(
            padding: EdgeInsets.only(bottom: 0.04.sh),
            color: StaticData.bgColor2,
            child: BlocConsumer<MobilBloc, MobilState>(
              listener: (context, state) {
                if (state is MobilStateError) {
                  ToastUtil.error(message: state.errors['message'] ?? '');
                } else if (state is MobilStateSuccess) {
                  ToastUtil.success(message: state.data['message'] ?? '');
                }
              },
              builder: (context, state) {
                if (state is MobilListLoaded) {
                  MobilListLoaded stateData = state;
                  if (stateData.mobils != null && stateData.mobils.length > 0) {
                    return SmartRefresher(
                      controller: _refreshController,
                      enablePullDown: true,
                      enablePullUp: true,
                      header: WaterDropMaterialHeader(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      onRefresh: () => _onRefresh,
                      onLoading: () => _onLoading,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: Get.width / (Get.height / 1.5)),
                        itemCount: stateData.mobils.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> mobil = stateData.mobils[index];
                          return Parent(
                              gesture: Gestures()
                                ..onTap(() {
                                  Get.toNamed("/user/beli/detail",
                                      arguments: mobil);
                                }),
                              child: Container(
                                padding: EdgeInsets.only(bottom: 5),
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                        flex: 3,
                                        child: CachedNetworkImage(
                                          width: 1.sw,
                                          imageUrl:
                                              "${StaticData.baseUrl}/uploads/${mobil['mobil_img']}",
                                          fit: BoxFit.fitWidth,
                                          placeholder: (context, url) =>
                                              new CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              new Icon(Icons.error),
                                        )),
                                    Flexible(
                                        flex: 1,
                                        child: Txt("${mobil['mobil_nama']}",
                                            style: TxtStyle()
                                              ..margin(horizontal: 5)
                                              ..fontSize(13..ssp)
                                              ..textOverflow(
                                                  TextOverflow.ellipsis)
                                              ..maxLines(2))),
                                    Txt("Rp${ConvertUtil.formatMoney(int.parse(mobil['mobil_harga']))}",
                                        style: TxtStyle()
                                          ..margin(horizontal: 5)
                                          ..fontSize(15..ssp)
                                          ..textColor(Colors.redAccent)
                                          ..width(0.9.sw)),
                                  ],
                                ),
                              ),
                              style: ParentStyle()..margin(all: 5));
                        },
                      ),
                    );
                  } else {
                    return Container(
                      child: Center(
                          child: Txt(
                        "mobil sedang kosong",
                        style: TxtStyle()
                          ..fontSize(18.ssp)
                          ..textColor(Colors.white)
                          ..textAlign.center(),
                      )),
                    );
                  }
                }
                return Container(
                  child: Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  )),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
