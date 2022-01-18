part of 'pdfexport_cubit.dart';

abstract class PdfexportState extends Equatable {
  const PdfexportState();

  @override
  List<Object> get props => [];
}

class PdfexportInitial extends PdfexportState {}

class PdfexportError extends PdfexportState {
  final String error;

  PdfexportError({required this.error});
  
  @override
  List<Object> get props => [error];
}

class PdfLoading extends PdfexportState {}