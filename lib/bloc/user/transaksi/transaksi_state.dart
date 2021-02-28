part of 'transaksi_bloc.dart';

@immutable
abstract class TransaksiState {}

class TransaksiInitial extends TransaksiState {}

class TransaksiStateLoading extends TransaksiState {}

class TransaksiStateSuccess extends TransaksiState {
  final Map<String, dynamic> data;

  TransaksiStateSuccess(this.data);
}

class TransaksiFormSuccess extends TransaksiState {
  final Map<String, dynamic> data;

  TransaksiFormSuccess(this.data);
}

class TransaksiStateError extends TransaksiState {
  final Map<String, dynamic> errors;

  TransaksiStateError(this.errors);
}

class TransaksiListLoaded extends TransaksiState {
  List<dynamic> transaksis;
  bool hasReachMax;

  TransaksiListLoaded({this.transaksis, this.hasReachMax});
  TransaksiListLoaded copyWith({List<dynamic> transaksis, bool hasReachMax}) {
    return TransaksiListLoaded(
        transaksis: transaksis ?? this.transaksis,
        hasReachMax: hasReachMax ?? this.hasReachMax);
  }
}
