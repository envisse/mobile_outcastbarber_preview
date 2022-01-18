import 'package:flutter/material.dart';
import 'package:mobile_outcastbarber/models/record/recordServices.dart';
import 'package:mobile_outcastbarber/models/record/recordWithdraws.dart';
import 'package:mobile_outcastbarber/models/recordrecap.dart';

class PdfData {
  List<RecordServices> recordServices;
  List<RecordWithdraws> recordWItdraws;
  RecordRecap recordRecap;
  int totalearn;
  DateTimeRange dateData;

  PdfData(
      {required this.recordServices,
      required this.recordWItdraws,
      required this.recordRecap,
      required this.totalearn,
      required this.dateData});
}
