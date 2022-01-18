part of 'recaprecord_cubit.dart';

abstract class RecaprecordState extends Equatable {
  const RecaprecordState();

  @override
  List<Object> get props => [];
}

class RecaprecordInitial extends RecaprecordState {}

class RecaprecordError extends RecaprecordState {
  final String error;

  RecaprecordError({required this.error});

  @override
  List<Object> get props => [error];
}

class RecaprecordLoading extends RecaprecordState {}

class RecaprecordLoaded extends RecaprecordState {
  final RecordRecap recordRecap;

  RecaprecordLoaded({required this.recordRecap});

  @override
  List<Object> get props => [recordRecap];
}
