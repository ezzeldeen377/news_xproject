import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_xproject/core/di/di.dart';
import 'package:news_xproject/core/helpers/hive_service.dart';
import 'package:news_xproject/core/utils/app_bloc_observer.dart';
import 'package:news_xproject/features/settings/presentation/cubit/language_cubit.dart';
import 'package:news_xproject/news_app.dart';
import 'package:timeago/timeago.dart' as timeago;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    timeago.setLocaleMessages('ar', timeago.ArMessages());

  // Initialize BlocObserver
  Bloc.observer = AppBlocObserver();
   configureDependencies();  

  
  // Load environment variables
  await dotenv.load(fileName: ".env");
    await HiveService.init();

  runApp(
    BlocProvider(
      create: (context) => LanguageCubit(),
      child: const NewsApp(),
    ),
  );
}


