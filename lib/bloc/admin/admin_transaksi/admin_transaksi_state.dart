part of 'admin_transaksi_bloc.dart';

@immutable
abstract class AdminTransaksiState {}

class AdminTransaksiInitial extends AdminTransaksiState {}

class AdminTransaksiStateLoading extends AdminTransaksiState {}

class AdminTransaksiStateSuccess extends AdminTransaksiState {
  final Map<String, dynamic> data;

  AdminTransaksiStateSuccess(this.data);
}

class AdminTransaksiFormSuccess extends AdminTransaksiState {
  final Map<String, dynamic> data;

  AdminTransaksiFormSuccess(this.data);
}

class AdminTransaksiStateError extends AdminTransaksiState {
  final Map<String, dynamic> errors;

  AdminTransaksiStateError(this.errors);
}

class AdminTransaksiListLoaded extends AdminTransaksiState {
  List<dynamic> transaksis;
  bool hasReachMax;

  AdminTransaksiListLoaded({this.transaksis, this.hasReachMax});
  AdminTransaksiListLoaded copyWith(
      {List<dynamic> transaksis, bool hasReachMax}) {
    return AdminTransaksiListLoaded(
        transaksis: transaksis ?? this.transaksis,
        hasReachMax: hasReachMax ?? this.hasReachMax);
  }
}
