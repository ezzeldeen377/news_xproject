import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_xproject/core/di/di.dart';
import 'package:news_xproject/core/router/route_names.dart';
import 'package:news_xproject/features/home_screen/domain/entities/article_entity.dart';
import 'package:news_xproject/features/home_screen/presentation/pages/home_screen.dart';
import 'package:news_xproject/features/news_details/presentation/cubit/news_details_cubit.dart';
import 'package:news_xproject/features/news_details/presentation/pages/news_details_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case RouteNames.newsDetails:
        // Extract arguments if passed
        final args = settings.arguments as ArticleEntity;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<NewsDetailsCubit>(),
                child: NewsDetailsPage(article: args),
              ),
        );

      default:
        // If the route is not defined, show an error page
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
