part of 'transaksi_bloc.dart';

@immutable
abstract class TransaksiEvent {}

class TransaksiGetListEvent extends TransaksiEvent {
  final bool refresh;

  TransaksiGetListEvent({this.refresh = false});
}

class TransaksiTambahEvent extends TransaksiEvent {
  final Map<String, dynamic> json;

  TransaksiTambahEvent(this.json);
}

class TransaksiEditEvent extends TransaksiEvent {
  final Map<String, dynamic> json;
  TransaksiEditEvent(this.json);
}

class TransaksiDeleteEvent extends TransaksiEvent {
  final int id;

  TransaksiDeleteEvent(this.id);
}

class TransaksiGetEvent extends TransaksiEvent {
  final int id;

  TransaksiGetEvent(this.id);
}
