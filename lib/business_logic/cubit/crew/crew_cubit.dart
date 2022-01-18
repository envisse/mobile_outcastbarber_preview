import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_outcastbarber/models/crew.dart';
import 'package:mobile_outcastbarber/services/repository/firebase/crew.dart';

part 'crew_state.dart';

class CrewCubit extends Cubit<CrewState> {
  CrewCubit() : super(CrewInitial());

  Future crewLoaded() async{
    emit(CrewLoading());
    try {
      var data = await CrewService().readCrew();
      emit(CrewLoaded(data));
    } catch (e) {
      emit(CrewError(e.toString()));
    }
  }

  Future crewCreate(Crew crew) async{
    emit(CrewLoading());
      var result = await CrewService().creatCrew(crew: crew);
      if(result){
        emit(CrewCreate('New crew added'));
        crewLoaded();
        return;
      }
      emit(CrewError('Create new crew are failed'));
  }

  Future crewUpdated({required String id, required Crew crew}) async{
    var result  = await CrewService().updateCrew(id: id, crew: crew);
    if (result) {
      emit(CrewUpdate('Crew Updated'));
      crewLoaded();
      return;
    }
    emit(CrewError('Update crew are failed'));
  }

  Future crewDeleted({required String id}) async{
    var result = await CrewService().deleteCrew(id: id);
    if (result) {
      emit(CrewDeleted('Crew Deleted'));
      crewLoaded();
      return;
    }
  }
}
