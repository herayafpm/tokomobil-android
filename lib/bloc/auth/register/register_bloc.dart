import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tokomobil/models/user_model.dart';
import 'package:tokomobil/repositories/auth/register_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterBlocEvent) {
      yield RegisterStateLoading();
      Map<String, dynamic> res =
          await RegisterRepository.proses(event.user.toJson());
      if (res['statusCode'] == 400 || res['data']['status'] == false) {
        yield RegisterStateError(res['data']);
      } else if (res['statusCode'] == 200) {
        yield RegisterStateSuccess(res['data']);
      } else {
        yield RegisterStateError(res['data']);
      }
    }
  }
}
