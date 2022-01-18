import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_outcastbarber/models/recordrecap.dart';
import 'package:mobile_outcastbarber/services/repository/firebase/recordv2.dart';

part 'recaprecord_state.dart';

class RecaprecordCubit extends Cubit<RecaprecordState> {
  RecaprecordCubit() : super(RecaprecordInitial());

  Future recaprecordload() async{
    emit(RecaprecordLoading());
    try {
      var data = await RecordV2().recapRecordToday();
      emit(RecaprecordLoaded(recordRecap: data));
      // emit(RecaprecordLoaded(recordRecap: data!));
    } catch (e) {
      emit(RecaprecordError(error: e.toString()));
    }
  }
}
