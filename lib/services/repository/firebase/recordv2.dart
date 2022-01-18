// make another version for "record" document
// path is 'record' -> 'doc'.get
// getting doc by query (order) timstamps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_outcastbarber/models/record/recordServices.dart';
import 'package:mobile_outcastbarber/models/record/recordWithdraws.dart';
import 'package:mobile_outcastbarber/models/recordrecap.dart';

class RecordV2 {
  final CollectionReference _collectionRecordService =
      FirebaseFirestore.instance.collection('record_service');
  final CollectionReference _collectionRecordWithdraw =
      FirebaseFirestore.instance.collection('record_withdraw');

  Future<bool> createRecordService(
      {required RecordServices recordServices}) async {
    try {
      //location service path
      await _collectionRecordService.doc().set(recordServices.json());
      return true;
    } on FirebaseException {
      return false;
    }
  }

  Future<bool> createRecordWithdraw(
      {required RecordWithdraws recordWithdraw}) async {
    try {
      //location withdraw path
      await _collectionRecordWithdraw.doc().set(recordWithdraw.json());
      return true;
    } on FirebaseException {     
      return false;
    }
  }

  Future<List<RecordServices>> getRecordService(DateTimeRange dateTime) async {
    List<RecordServices> recordservices = [];
    DateTime startdate = DateTime(dateTime.start.year, dateTime.start.month, dateTime.start.day);
    DateTime enddate = DateTime(dateTime.end.year, dateTime.end.month, dateTime.end.day, 23, 59);

    try {
      var data = await _collectionRecordService
        .where('date', isGreaterThanOrEqualTo: startdate)
        .where('date', isLessThanOrEqualTo: enddate)
        .orderBy('date',descending: true)
        .get();

     
      data.docs.forEach((element) {
        recordservices.add(RecordServices.fromjson(element.data() as Map<String, dynamic>));
      });
      return recordservices;
    } on FirebaseException {
      return recordservices;
    }
  }

  Future<List<RecordWithdraws>> getRecordWithdraw(DateTimeRange dateTime) async {
    List<RecordWithdraws> recordwithdraws = [];
    DateTime startdate = DateTime(dateTime.start.year, dateTime.start.month, dateTime.start.day);
    DateTime enddate = DateTime(dateTime.end.year, dateTime.end.month, dateTime.end.day, 23, 59);

    try {
      var data = await _collectionRecordWithdraw
        .where('date', isGreaterThanOrEqualTo: startdate)
        .where('date', isLessThanOrEqualTo: enddate)
        .orderBy('date',descending: true)
        .get();
      data.docs.forEach((element) {
        recordwithdraws.add(RecordWithdraws.fromjson(element.data() as Map<String, dynamic>));
      });
      return recordwithdraws;
    } on FirebaseException {
      return recordwithdraws;
    }
  }


  Future<RecordRecap> recapRecordToday() async{
    RecordRecap recordRecap = RecordRecap(earnservice: 0, earnwithdraw: 0, record: []);
    DateTime today = DateTime.now();
    DateTime startdate = DateTime(today.year, today.month, today.day);
    DateTime enddate = DateTime(today.year, today.month, today.day, 23, 59);
    
    try {
      var totalServices = await _collectionRecordService
        .where('date', isGreaterThanOrEqualTo: startdate)
        .where('date', isLessThanOrEqualTo: enddate)
        .orderBy('date',descending: true)
        .get();

      //fetching total earn of service 
      totalServices.docs.forEach((element) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        recordRecap.earnservice += int.parse(data['total'].toString());
      });

      //fetching data record
      for (var i = 0; i < 3; i++) 
        recordRecap.record.add(RecordServices.fromjson(totalServices.docs[i].data() as Map<String, dynamic>));
      
      var totalWithdraws = await _collectionRecordWithdraw
        .where('date', isGreaterThanOrEqualTo: startdate)
        .where('date', isLessThanOrEqualTo: enddate)
        .get();
      
      //fetching total earn of withdraws 
      totalWithdraws.docs.forEach((element) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        recordRecap.earnwithdraw += int.parse(data['price'].toString());
      });     
      return recordRecap;
      
    } catch (e) {
      return recordRecap;
    }
  }
}
