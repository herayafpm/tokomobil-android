part of 'mobil_bloc.dart';

@immutable
abstract class MobilState {}

class MobilInitial extends MobilState {}

class MobilStateLoading extends MobilState {}

class MobilStateSuccess extends MobilState {
  final Map<String, dynamic> data;

  MobilStateSuccess(this.data);
}

class MobilFormSuccess extends MobilState {
  final Map<String, dynamic> data;

  MobilFormSuccess(this.data);
}

class MobilStateError extends MobilState {
  final Map<String, dynamic> errors;

  MobilStateError(this.errors);
}

class MobilListLoaded extends MobilState {
  List<dynamic> mobils;
  bool hasReachMax;

  MobilListLoaded({this.mobils, this.hasReachMax});
  MobilListLoaded copyWith({List<dynamic> mobils, bool hasReachMax}) {
    return MobilListLoaded(
        mobils: mobils ?? this.mobils,
        hasReachMax: hasReachMax ?? this.hasReachMax);
  }
}
