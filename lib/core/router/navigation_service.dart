import 'package:flutter/material.dart';

class NavigationService {
  // Singleton instance
  static final NavigationService _instance = NavigationService._internal();
  
  // Factory constructor
  factory NavigationService() => _instance;
  
  // Private constructor
  NavigationService._internal();
  
  // Global navigation key
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  // Navigation methods
  Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }
  
  Future<dynamic> navigateToReplacement(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: arguments);
  }
  
  Future<dynamic> navigateToAndRemoveUntil(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName, 
      (Route<dynamic> route) => false,
      arguments: arguments
    );
  }
  
  void goBack() {
    return navigatorKey.currentState!.pop();
  }
}