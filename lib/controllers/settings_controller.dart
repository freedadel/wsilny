import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:wsilny/Models/response_model.dart';
import 'package:wsilny/Models/sign_up_body.dart';
import 'package:get/get.dart';
import 'package:wsilny/repository/settings_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/address_model.dart';
import '../main.dart';
import '../repository/auth_repo.dart';
import '../utils/app_constants.dart';
import '../utils/language.dart';
import 'package:restart_app/restart_app.dart';

class SettingsController extends GetxController implements GetxService{
  final SettingsRepo settingsRepo;
  SettingsController({required this.settingsRepo});

  List<Locale> getSupportedLanguages() {
    final List<Locale> localeList = <Locale>[];
    for (final Language lang in AppConstants.psSupportedLanguageList) {
      localeList.add(Locale(lang.languageCode, lang.countryCode));
    }
    print('Loaded Languages');
    return localeList;
  }

  Future<void> setLanguage(String lang) async {
    settingsRepo.setLanguage(lang);

  }

  Language getLanguage() {
    return settingsRepo.getLanguage();
    update();
  }



}
