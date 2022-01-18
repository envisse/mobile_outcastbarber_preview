import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_outcastbarber/models/record/recordServices.dart';
import 'package:mobile_outcastbarber/models/record/recordWithdraws.dart';
import 'package:mobile_outcastbarber/services/repository/firebase/recordv2.dart';

part 'recordv2_state.dart';

class Recordv2Cubit extends Cubit<Recordv2State> {
  Recordv2Cubit() : super(Recordv2Initial());
  RecordV2 _record = RecordV2();

  Future recordServiceInitial(DateTimeRange dateTimeRange) async{
    emit(Recordv2Loading());
    try {
      List<RecordServices> services = await _record.getRecordService(dateTimeRange);
      if (services.isEmpty) {
        emit(Recordv2Empty());
        return;
      }
      emit(Recordv2ServiceLoaded(services));
    } catch (e) {
      emit(Recordv2Error());
    }
  }

  Future recordWIthdrawsInitial(DateTimeRange dateTimeRange) async{
    emit(Recordv2Loading());
    try {
      List<RecordWithdraws> withdraws = await _record.getRecordWithdraw(dateTimeRange);
      if (withdraws.isEmpty) {
        emit(Recordv2Empty());
        return;
      }
      emit(Recordv2WithdrawLoaded(withdraws));
    } catch (e) {
      emit(Recordv2Error());
    }
  }
}
