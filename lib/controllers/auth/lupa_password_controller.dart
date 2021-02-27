import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tokomobil/bloc/auth/lupa_password/lupa_password_bloc.dart';

class LupaPasswordController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController kodeOTPController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  GlobalKey<FormState> cekKodeOTPkey = GlobalKey<FormState>();
  GlobalKey<FormState> ubahPasswordkey = GlobalKey<FormState>();
  final kirimUlangTimer = 60.obs;
  final showPass = false.obs;
  final isLoading = false.obs;
  final email = "".obs;

  void setTimerPeriodic() async {
    if (kirimUlangTimer.value > 0) {
      Timer.periodic(Duration(seconds: 1), (timer) {
        kirimUlangTimer.value -= 1;
      });
    }
  }

  void lupa(LupaPasswordBloc bloc) {
    isLoading.value = !isLoading.value;
    bloc..add(LupaPasswordBlocEvent(usernameController.text));
  }

  void cekKode(LupaPasswordBloc bloc) {
    isLoading.value = !isLoading.value;
    bloc..add(CekKodeEvent(email.value, int.parse(kodeOTPController.text)));
  }

  void ubahPassword(LupaPasswordBloc bloc) {
    isLoading.value = !isLoading.value;
    bloc
      ..add(UbahPasswordEvent(email.value, int.parse(kodeOTPController.text),
          passwordController.text));
  }
}
