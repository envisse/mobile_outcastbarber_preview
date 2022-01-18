import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_outcastbarber/models/crew.dart';

class CrewService {
  //collection
  final CollectionReference _crewlist =
      FirebaseFirestore.instance.collection('crew');

  Future<List<Crew>> readCrew() async {
    List<Crew> datacrew = [];
    try {
      var data = await _crewlist.get();
      data.docs.forEach((element) {
        datacrew.add(Crew.fromjson(element.data() as Map<String, dynamic>,element.id));
      });
      return datacrew;
    } on FirebaseException{
      return datacrew;
    }
  }

  Future<bool> creatCrew({required Crew crew}) async {
    try {
      //create command
      await _crewlist.doc().set(crew.json());
      return true;
    } on FirebaseException{
      return false;
    }
  }

  Future<bool> updateCrew({required String id,required Crew crew}) async {
    try {
      //update command
      await _crewlist.doc(id).update(crew.json());
      return true;
    } on FirebaseException{
      return false;
    }
  }

  Future<bool> deleteCrew({required String id}) async{
    try {
      //delete command
      await _crewlist.doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
