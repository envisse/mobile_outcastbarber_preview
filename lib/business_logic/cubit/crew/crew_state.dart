part of 'crew_cubit.dart';

abstract class CrewState extends Equatable {
  const CrewState();

  @override
  List<Object> get props => [];
}

class CrewInitial extends CrewState {}
class CrewLoading extends CrewState {}

class CrewError extends CrewState {
  final String messeage;

  CrewError(this.messeage);

  @override
  List<Object> get props => [messeage];
}

class CrewUpdate extends CrewState {
  final String messeage;

  CrewUpdate(this.messeage);

  @override
  List<Object> get props => [messeage];
}

class CrewCreate extends CrewState {
  final String messeage;

  CrewCreate(this.messeage);

  @override
  List<Object> get props => [messeage];
}

class CrewLoaded extends CrewState {
   final List<Crew> crew;

  CrewLoaded(this.crew);

  @override
  List<Object> get props => [crew];
}

class CrewDeleted extends CrewState {
   final String message;

  CrewDeleted(this.message);

  @override
  List<Object> get props => [message];
}


