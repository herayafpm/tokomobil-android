import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tokomobil/repositories/admin/admin_transaksi_repository.dart';

part 'admin_transaksi_event.dart';
part 'admin_transaksi_state.dart';

class AdminTransaksiBloc
    extends Bloc<AdminTransaksiEvent, AdminTransaksiState> {
  AdminTransaksiBloc() : super(AdminTransaksiInitial());

  @override
  Stream<AdminTransaksiState> mapEventToState(
    AdminTransaksiEvent event,
  ) async* {
    if (event is AdminTransaksiGetListEvent) {
      int limit = 10;
      List<dynamic> transaksis = [];
      if (state is AdminTransaksiInitial || event.refresh) {
        Map<String, dynamic> res =
            await AdminTransaksiRepository.getListTransaksi(
                limit: limit, offset: 0);
        if (res['statusCode'] == 200 && res['data']['status'] == 1) {
          var jsonObject = res['data']['data'] as List<dynamic>;
          transaksis = jsonObject;
          yield AdminTransaksiListLoaded(
              transaksis: transaksis, hasReachMax: false);
        } else if (res['statusCode'] == 400) {
          yield AdminTransaksiStateError(res['data']);
        } else {
          yield AdminTransaksiStateError(res['data']);
        }
      } else if (state is AdminTransaksiListLoaded) {
        AdminTransaksiListLoaded admintransaksiListLoaded =
            state as AdminTransaksiListLoaded;
        Map<String, dynamic> res =
            await AdminTransaksiRepository.getListTransaksi(
                limit: limit,
                offset: admintransaksiListLoaded.transaksis.length);
        if (res['statusCode'] == 200 && res['data']['status'] == 1) {
          var jsonObject = res['data']['data'] as List<Map<String, dynamic>>;
          if (jsonObject.length == 0) {
            yield admintransaksiListLoaded.copyWith(hasReachMax: true);
          } else {
            transaksis = jsonObject;
            yield AdminTransaksiListLoaded(
                transaksis: admintransaksiListLoaded.transaksis + transaksis,
                hasReachMax: false);
          }
        } else if (res['statusCode'] == 400) {
          yield AdminTransaksiStateError(res['data']);
        } else {
          yield AdminTransaksiStateError(res['data']);
        }
      }
    }
  }
}
