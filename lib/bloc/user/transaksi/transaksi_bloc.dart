import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tokomobil/repositories/user/user_transaksi_repository.dart';

part 'transaksi_event.dart';
part 'transaksi_state.dart';

class TransaksiBloc extends Bloc<TransaksiEvent, TransaksiState> {
  TransaksiBloc() : super(TransaksiInitial());

  @override
  Stream<TransaksiState> mapEventToState(
    TransaksiEvent event,
  ) async* {
    if (event is TransaksiGetListEvent) {
      int limit = 10;
      List<dynamic> transaksis = [];
      if (state is TransaksiInitial || event.refresh) {
        Map<String, dynamic> res =
            await UserTransaksiRepository.getListTransaksi(
                limit: limit, offset: 0);
        if (res['statusCode'] == 200 && res['data']['status'] == 1) {
          var jsonObject = res['data']['data'] as List<dynamic>;
          transaksis = jsonObject;
          yield TransaksiListLoaded(transaksis: transaksis, hasReachMax: false);
        } else if (res['statusCode'] == 400) {
          yield TransaksiStateError(res['data']);
        } else {
          yield TransaksiStateError(res['data']);
        }
      } else if (state is TransaksiListLoaded) {
        TransaksiListLoaded transaksiListLoaded = state as TransaksiListLoaded;
        Map<String, dynamic> res =
            await UserTransaksiRepository.getListTransaksi(
                limit: limit, offset: transaksiListLoaded.transaksis.length);
        if (res['statusCode'] == 200 && res['data']['status'] == 1) {
          var jsonObject = res['data']['data'] as List<Map<String, dynamic>>;
          if (jsonObject.length == 0) {
            yield transaksiListLoaded.copyWith(hasReachMax: true);
          } else {
            transaksis = jsonObject;
            yield TransaksiListLoaded(
                transaksis: transaksiListLoaded.transaksis + transaksis,
                hasReachMax: false);
          }
        } else if (res['statusCode'] == 400) {
          yield TransaksiStateError(res['data']);
        } else {
          yield TransaksiStateError(res['data']);
        }
      }
    } else if (event is TransaksiTambahEvent) {
      yield TransaksiStateLoading();
      Map<String, dynamic> res =
          await UserTransaksiRepository.postTransaksi(event.json);
      if (res['statusCode'] == 400 || res['data']['status'] == false) {
        yield TransaksiStateError(res['data']);
      } else if (res['statusCode'] == 200) {
        yield TransaksiStateSuccess(res['data']);
      } else {
        yield TransaksiStateError(res['data']);
      }
    }
  }
}
