part of 'recordv2_cubit.dart';

abstract class Recordv2State extends Equatable {
  const Recordv2State();

  @override
  List<Object> get props => [];
}

class Recordv2Initial extends Recordv2State {}

//load service data
class Recordv2ServiceLoaded extends Recordv2State {
  final List<RecordServices> services;

  Recordv2ServiceLoaded(this.services);

  @override
  List<Object> get props => [services];
}

////load withdraws data
class Recordv2WithdrawLoaded extends Recordv2State {
  final List<RecordWithdraws> withdraws;

  Recordv2WithdrawLoaded(this.withdraws);

  @override
  List<Object> get props => [withdraws];
}


class Recordv2Empty extends Recordv2State {}

class Recordv2Error extends Recordv2State {}

class Recordv2Loading extends Recordv2State {}
