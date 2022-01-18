import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(LocaleInitial());

  //Save Chhosen Locale to local storage
  void setLocale(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('locale', locale.languageCode);

    if (!L10n.supportedlang.contains(locale)) return;

    emit(LocaleLoaded(locale));
  }

  //Load saved Locale from local storage
  void loadLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var savedlocale = prefs.getString('locale');

    if (savedlocale == null) {
      emit(LocaleLoaded(Locale('en')));
      return;
    }

    emit(LocaleLoaded(Locale(savedlocale)));
  }
}
