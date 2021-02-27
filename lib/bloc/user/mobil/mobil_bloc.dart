import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tokomobil/repositories/user/user_mobil_repository.dart';

part 'mobil_event.dart';
part 'mobil_state.dart';

class MobilBloc extends Bloc<MobilEvent, MobilState> {
  MobilBloc() : super(MobilInitial());

  @override
  Stream<MobilState> mapEventToState(
    MobilEvent event,
  ) async* {
    if (event is MobilGetListEvent) {
      int limit = 10;
      List<dynamic> mobils = [];
      if (state is MobilInitial || event.refresh) {
        Map<String, dynamic> res =
            await UserMobilRepository.getListMobil(limit: limit, offset: 0);
        if (res['statusCode'] == 200 && res['data']['status'] == 1) {
          var jsonObject = res['data']['data'] as List<dynamic>;
          mobils = jsonObject;
          yield MobilListLoaded(mobils: mobils, hasReachMax: false);
        } else if (res['statusCode'] == 400) {
          yield MobilStateError(res['data']);
        } else {
          yield MobilStateError(res['data']);
        }
      } else if (state is MobilListLoaded) {
        MobilListLoaded mobilListLoaded = state as MobilListLoaded;
        Map<String, dynamic> res = await UserMobilRepository.getListMobil(
            limit: limit, offset: mobilListLoaded.mobils.length);
        if (res['statusCode'] == 200 && res['data']['status'] == 1) {
          var jsonObject = res['data']['data'] as List<Map<String, dynamic>>;
          if (jsonObject.length == 0) {
            yield mobilListLoaded.copyWith(hasReachMax: true);
          } else {
            mobils = jsonObject;
            yield MobilListLoaded(
                mobils: mobilListLoaded.mobils + mobils, hasReachMax: false);
          }
        } else if (res['statusCode'] == 400) {
          yield MobilStateError(res['data']);
        } else {
          yield MobilStateError(res['data']);
        }
      }
    }
  }
}
