import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tokomobil/bloc/user/transaksi/transaksi_bloc.dart';
import 'package:tokomobil/static_data.dart';
import 'package:tokomobil/ui/components/error_state.dart';
import 'package:tokomobil/utils/convert_util.dart';
import 'package:tokomobil/utils/date_time_util.dart';
import 'package:tokomobil/utils/toast_util.dart';

class BeliRiwayatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StaticData.bgColor,
      appBar: AppBar(
        title: Text("Riwayat Pembelian"),
      ),
      body: BlocProvider(
        create: (context) => TransaksiBloc()..add(TransaksiGetListEvent()),
        child: BeliRiwayatView(),
      ),
    );
  }
}

class BeliRiwayatView extends StatelessWidget {
  TransaksiBloc bloc;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    bloc..add(TransaksiGetListEvent(refresh: true));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    bloc..add(TransaksiGetListEvent());
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<TransaksiBloc>(context);
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: BlocConsumer<TransaksiBloc, TransaksiState>(
        listener: (context, state) {
          if (state is TransaksiStateError) {
            ToastUtil.error(message: state.errors['message'] ?? '');
          } else if (state is TransaksiStateSuccess) {
            ToastUtil.success(message: state.data['message'] ?? '');
          }
        },
        builder: (context, state) {
          if (state is TransaksiListLoaded) {
            TransaksiListLoaded stateData = state;
            if (stateData.transaksis != null &&
                stateData.transaksis.length > 0) {
              return SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                enablePullUp: true,
                header: WaterDropMaterialHeader(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: ListView.builder(
                  itemCount: stateData.transaksis.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> transaksi =
                        stateData.transaksis[index];
                    int jumlah = int.parse(transaksi['transaksi_jumlah']);
                    int total_bayar = int.parse(transaksi['transaksi_jumlah']) *
                        int.parse(transaksi['transaksi_harga']);
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed("/user/beli/riwayat/detail",
                            arguments: transaksi);
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        child: ListTile(
                          title: Text(
                              "${DateTimeUtil.humanize(transaksi['transaksi_created_at'])}"),
                          subtitle: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text:
                                      "Jumlah: ${ConvertUtil.formatMoney(jumlah)}\n",
                                  style: TextStyle(color: Colors.black54)),
                              TextSpan(
                                  text:
                                      "Total bayar: Rp${ConvertUtil.formatMoney(total_bayar)}\n",
                                  style: TextStyle(color: Colors.black54)),
                            ]),
                          ),
                          isThreeLine: true,
                          trailing: Icon(Icons.arrow_right),
                          tileColor: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return ErrorState(
                title: "Anda belum memiliki riwayat pembelian",
                onTap: () {
                  bloc..add(TransaksiGetListEvent(refresh: true));
                },
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
    );
  }
}
