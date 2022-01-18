import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_outcastbarber/models/pdf/pdfData.dart';
import 'package:mobile_outcastbarber/models/record/recordServices.dart';
import 'package:mobile_outcastbarber/models/record/recordWithdraws.dart';
import 'package:mobile_outcastbarber/models/recordrecap.dart';

class PdfDataFeature {
  final CollectionReference _dataRecordService =
      FirebaseFirestore.instance.collection('record_service');
  final CollectionReference _dataRecordWithdraw =
      FirebaseFirestore.instance.collection('record_withdraw');

  Future<PdfData> fetcData(DateTimeRange dateTimeRange) async {
    PdfData pdfData = PdfData(
        recordRecap: RecordRecap(earnservice: 0, earnwithdraw: 0, record: []),
        recordServices: [],
        recordWItdraws: [],totalearn: 0,dateData: dateTimeRange);

    DateTime startdate = DateTime(dateTimeRange.start.year, dateTimeRange.start.month,dateTimeRange.start.day, 00, 00);
    DateTime enddate = DateTime(dateTimeRange.end.year, dateTimeRange.end.month,dateTimeRange.end.day, 23, 59);

    try {
      var dataService = await _dataRecordService
          .where('date', isGreaterThanOrEqualTo: startdate)
          .where('date', isLessThanOrEqualTo: enddate)
          .get();
      dataService.docs.forEach((element) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        pdfData.recordServices.add(RecordServices.fromjson(data));
        pdfData.recordRecap.earnservice += int.parse(data['total'].toString());
      });

      var dataWithdraws = await _dataRecordWithdraw
          .where('date', isGreaterThanOrEqualTo: startdate)
          .where('date', isLessThanOrEqualTo: enddate)
          .get();
      dataWithdraws.docs.forEach((element) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        pdfData.recordWItdraws.add(RecordWithdraws.fromjson(data));
        pdfData.recordRecap.earnwithdraw += int.parse(data['price'].toString());
      });

      pdfData.totalearn = pdfData.recordRecap.earnservice - pdfData.recordRecap.earnwithdraw;

      return pdfData;
    } catch (e) {
      print(e);
      return pdfData;
      }

  }
}
