part of 'mobil_bloc.dart';

@immutable
abstract class MobilEvent {}

class MobilGetListEvent extends MobilEvent {
  final bool refresh;

  MobilGetListEvent({this.refresh = false});
}

class MobilTambahEvent extends MobilEvent {
  final Map<String, dynamic> json;

  MobilTambahEvent(this.json);
}

class MobilEditEvent extends MobilEvent {
  final Map<String, dynamic> json;
  MobilEditEvent(this.json);
}

class MobilDeleteEvent extends MobilEvent {
  final int id;

  MobilDeleteEvent(this.id);
}

class MobilGetEvent extends MobilEvent {
  final int id;

  MobilGetEvent(this.id);
}

class MobilSetStatusEvent extends MobilEvent {
  final int id;
  final int status;

  MobilSetStatusEvent(this.id, this.status);
}
