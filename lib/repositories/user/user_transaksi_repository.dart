import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tokomobil/services/dio_service.dart';
import 'package:tokomobil/utils/response_util.dart';

abstract class UserTransaksiRepository {
  static Future<Map<String, dynamic>> getListTransaksi(
      {int limit = 10, int offset = 0}) async {
    try {
      Dio dio = await DioService.withToken();
      Response response =
          await dio.get("/user/transaksi?limit=$limit&offset=$offset");
      Map<String, dynamic> data = Map<String, dynamic>();
      data['statusCode'] = response.statusCode;
      data['data'] = response.data;
      return data;
    } on SocketException catch (e) {
      print(e);
      return ResponseUtil.errorClient(e.message);
    } on DioError catch (e) {
      print(e);
      return ResponseUtil.errorClient(e.message);
    } catch (e) {
      print(e);
      return ResponseUtil.errorClient(e.toString());
    }
  }

  static Future<Map<String, dynamic>> postTransaksi(
      Map<String, dynamic> json) async {
    try {
      Dio dio = await DioService.withToken();
      Response response = await dio.post("/user/transaksi", data: json);
      Map<String, dynamic> data = Map<String, dynamic>();
      data['statusCode'] = response.statusCode;
      data['data'] = response.data;
      return data;
    } on SocketException catch (e) {
      print(e);
      return ResponseUtil.errorClient(e.message);
    } on DioError catch (e) {
      print(e);
      return ResponseUtil.errorClient(e.message);
    } catch (e) {
      print(e);
      return ResponseUtil.errorClient(e.toString());
    }
  }
}
