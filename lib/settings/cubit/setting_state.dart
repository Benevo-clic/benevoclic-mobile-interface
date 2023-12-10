


import 'package:flutter/material.dart';

class SettingState{
  final ThemeData themeData;
  SettingState({required this.themeData});
}

class SettingInitialState extends SettingState {
  SettingInitialState({required ThemeData themeData}) : super(themeData: themeData);
}

class SettingDarkState extends SettingState {
  SettingDarkState({required ThemeData themeData}) : super(themeData: themeData);
}

class SettingLightState extends SettingState {
  SettingLightState({required ThemeData themeData}) : super(themeData: themeData);
}

