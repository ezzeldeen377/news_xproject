import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppStrings {
  // Singleton instance
  static AppStrings? _instance;
  
  // Localization instance
  late AppLocalizations _l10n;
  
  // Private constructor
  AppStrings._();
  
  // Factory constructor
  static AppStrings get instance {
    if (_instance == null) {
      throw Exception("AppStrings not initialized. Call AppStrings.init(context) first.");
    }
    return _instance!;
  }
  
  // Initialize with context
  static void init(BuildContext context) {
    _instance ??= AppStrings._();
    _instance!._l10n = AppLocalizations.of(context)!;
  }
  
  // Localized strings
  String get news => _l10n.news;
  String get app => _l10n.app;
  
  // New strings
  String get latestNews => _l10n.latestNews;
  String get shareVia => _l10n.shareVia;
  String get copyLink => _l10n.copyLink;
  String get linkCopied => _l10n.linkCopied;
  String get whatsApp => _l10n.whatsApp;
  String get more => _l10n.more;
  String get search => _l10n.search;
  String get collections => _l10n.collections;
  String get latestBookmarks => _l10n.latestBookmarks;
  
  // Settings page strings
  String get settings => _l10n.settings;
  String get account => _l10n.account;
  String get profile => _l10n.profile;
  String get notifications => _l10n.notifications;
  String get appSettings => _l10n.appSettings;
  String get language => _l10n.language;
  String get english => _l10n.english;
  String get arabic => _l10n.arabic;
  String get appearance => _l10n.appearance;
  String get light => _l10n.light;
  String get other => _l10n.other;
  String get about => _l10n.about;
  String get helpAndSupport => _l10n.helpAndSupport;
  String get logout => _l10n.logout;
  String get selectLanguage => _l10n.selectLanguage;
  String get retry => _l10n.retry;
  String get failedToLoadNews => _l10n.failedToLoadNews;
  String get noNewsAvailable => _l10n.noNewsAvailable;
  String get sports => _l10n.sports;
  String get tech => _l10n.tech;
  String get health => _l10n.health;
  String get noBookmarksYet => _l10n.noBookmarksYet;
  String get failedToLoadBookmarks => _l10n.failedToLoadBookmarks;
  String get recentSearches => _l10n.recentSearches;
  String get popularTopics => _l10n.popularTopics;
  String get politics => _l10n.politics;
  String get technology => _l10n.failedToLoadBookmarks;
  String get science => _l10n.science;
  String get business => _l10n.business;
  String get entertainment => _l10n.entertainment;
  String get noReusltFoundFor => _l10n.noReusltFoundFor;
  

  
  // Fallback constants for reference only
  // These should match the keys in your ARB files
}