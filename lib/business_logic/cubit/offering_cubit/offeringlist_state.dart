part of 'offeringlist_cubit.dart';

abstract class OfferinglistState extends Equatable {
  const OfferinglistState();

  @override
  List<Object> get props => [];
}

class OfferinglistInitial extends OfferinglistState {}

class OfferinglistLoading extends OfferinglistState {}

class OfferingListLoaded extends OfferinglistState {
  final List<Product> products;
  final List<Service> services;
  OfferingListLoaded({required this.products, required this.services});

  @override
  List<Object> get props => [products, services];
}

class OfferingDelete extends OfferinglistState {
  final String message;
  OfferingDelete({required this.message});
  
  @override
  List<Object> get props => [message];
}

class OfferingCreate extends OfferinglistState {
  final String message;
  OfferingCreate({required this.message});
  
  @override
  List<Object> get props => [message];
}

class OfferingUpdate extends OfferinglistState {
  final String message;
  OfferingUpdate({required this.message});
  
  @override
  List<Object> get props =>[];
}

class OfferingError extends OfferinglistState {
  final String error;
  OfferingError(this.error);

  @override
  List<Object> get props => [error];
}