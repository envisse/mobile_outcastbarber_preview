import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_outcastbarber/models/userData.dart';
import 'package:mobile_outcastbarber/services/repository/firebase/userProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserCubitInitial());

  void getdatauser() async {
    try {
      var verification = await UserProfile().checkUser();
      if (!verification) {
        emit(UserCubitEmpty(verification.toString()));
        return null;
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      UserData userdata = UserData.fromjson(jsonDecode(prefs.getString('user')!));
      emit(UserCubitSuccess(userdata));
    } catch (e) {
      emit(UserCubitError(e.toString()));
    }
  }
}
