// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

enum LanguageStatus { initial, loading, success, failure }

class LanguageState {
  final Locale locale;
  final LanguageStatus status;
  final String? errorMessage;

  const LanguageState(
    {this.errorMessage,
    this.locale = const Locale('en'),
    this.status = LanguageStatus.initial,
  });

  LanguageState copyWith({Locale? locale, LanguageStatus? status,String? errorMessage}){
    return LanguageState(
      errorMessage : errorMessage?? this.errorMessage,
      locale: locale ?? this.locale,
      status: status ?? this.status,
    );
  }

  @override
  String toString() => 'LanguageState(locale: $locale, status: $status, errorMessage: $errorMessage)';
}
