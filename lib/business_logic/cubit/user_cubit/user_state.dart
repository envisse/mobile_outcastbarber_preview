part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserCubitInitial extends UserState {}

class UserCubitSuccess extends UserState {
  final UserData userData;

  UserCubitSuccess(this.userData);
  
  @override
  List<Object> get props => [userData];
}

class UserCubitEmpty extends UserState {
  final String error;

  UserCubitEmpty(this.error);

  @override
  List<Object> get props => [error];
}

class UserCubitError extends UserState {
  final String error;

  UserCubitError(this.error);

  @override
  List<Object> get props => [error];
}
