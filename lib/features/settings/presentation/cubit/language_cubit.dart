import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:news_xproject/features/settings/presentation/cubit/language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(const LanguageState()) {
    _loadSavedLanguage();
  }

  static const String _languageCodeKey = 'en';

  Future<void> _loadSavedLanguage() async {
    emit(state.copyWith(status: LanguageStatus.loading));
    try {
      final prefs = await SharedPreferences.getInstance();
      final languageCode = prefs.getString(_languageCodeKey) ?? 'en';
      emit(state.copyWith(
        locale: Locale(languageCode),
        status: LanguageStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: LanguageStatus.failure,errorMessage: e.toString()));
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    emit(state.copyWith(status: LanguageStatus.loading));
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageCodeKey, languageCode);
      emit(state.copyWith(
        locale: Locale(languageCode),
        status: LanguageStatus.success,
      ));
      print('Language changed to ${state.locale.languageCode}');
    } catch (e) {
      emit(state.copyWith(status: LanguageStatus.failure,errorMessage: e.toString()));
    }
  }

  bool isCurrentLanguage(String languageCode) {
    return state.locale.languageCode == languageCode;
  }
}