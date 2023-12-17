

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/settings/cubit/setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitialState(themeData: ThemeData.light()));


  void changeTheme() {
    emit((state.themeData == ThemeData.light()
        ? SettingDarkState(themeData: ThemeData.dark())
        : SettingLightState(themeData: ThemeData.light())));
  }

}