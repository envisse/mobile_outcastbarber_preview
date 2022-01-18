import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_outcastbarber/services/api/pdf_api.dart';
import 'package:mobile_outcastbarber/services/api/pdf_recap_api.dart';
import 'package:mobile_outcastbarber/services/repository/firebase/pdfData.dart';

part 'pdfexport_state.dart';

class PdfexportCubit extends Cubit<PdfexportState> {
  PdfexportCubit() : super(PdfexportInitial());
  
  Future generatePDF(DateTimeRange dateTimeRange,List<bool> reportType)async{
    emit(PdfLoading());
    try {
      var data  = await PdfDataFeature().fetcData(dateTimeRange);
      final pdfFile = await PdfRecapApi.generate(data,reportType);
      PdfApi.openFile(pdfFile);
    } catch (e) {
      emit(PdfexportError(error: e.toString()));
    }
  }
}
