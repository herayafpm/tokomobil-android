part of 'admin_transaksi_bloc.dart';

@immutable
abstract class AdminTransaksiEvent {}

class AdminTransaksiGetListEvent extends AdminTransaksiEvent {
  final bool refresh;

  AdminTransaksiGetListEvent({this.refresh = false});
}

class AdminTransaksiTambahEvent extends AdminTransaksiEvent {
  final Map<String, dynamic> json;

  AdminTransaksiTambahEvent(this.json);
}

class AdminTransaksiEditEvent extends AdminTransaksiEvent {
  final Map<String, dynamic> json;
  AdminTransaksiEditEvent(this.json);
}

class AdminTransaksiDeleteEvent extends AdminTransaksiEvent {
  final int id;

  AdminTransaksiDeleteEvent(this.id);
}

class AdminTransaksiGetEvent extends AdminTransaksiEvent {
  final int id;

  AdminTransaksiGetEvent(this.id);
}
