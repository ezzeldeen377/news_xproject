import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_xproject/core/constants/app_strings.dart';
import 'package:news_xproject/core/di/di.dart';
import 'package:news_xproject/core/router/app_router.dart';
import 'package:news_xproject/core/widgets/floating_bottom_nav_bar.dart';
import 'package:news_xproject/features/bookmark/presentation/cubit/bookmark_cubit.dart';
import 'package:news_xproject/features/bookmark/presentation/pages/bookmark_page.dart';
import 'package:news_xproject/features/home_screen/presentation/cubit/home_cubit.dart';
import 'package:news_xproject/features/home_screen/presentation/pages/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_xproject/features/news_details/presentation/pages/news_details_page.dart';
import 'package:news_xproject/features/search/presentation/cubit/search_cubit.dart';
import 'package:news_xproject/features/search/presentation/pages/search_page.dart';
import 'package:news_xproject/features/settings/presentation/cubit/language_cubit.dart';
import 'package:news_xproject/features/settings/presentation/cubit/language_state.dart';
import 'package:news_xproject/features/settings/presentation/pages/settings_page.dart';

class NewsApp extends StatefulWidget {
  const NewsApp({super.key});

  @override
  State<NewsApp> createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  int _currentIndex = 0;

  // Initialize AppStrings with context in didChangeDependencies

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'News App',
              locale: state.locale,
              theme: ThemeData(
                fontFamily: 'PPTelegraf',
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              ),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              builder: (context, child) {
                AppStrings.init(context);
                return child!;
              },
              onGenerateRoute: AppRouter.generateRoute,
              home: Scaffold(
                body: _buildBody(),
                extendBody: true, // Important for floating nav bar
                bottomNavigationBar: FloatingBottomNavBar(
                  currentIndex: _currentIndex,
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBody() {
    // Switch between different screens based on the selected tab
    switch (_currentIndex) {
      case 0:
        return BlocProvider(
          create:
              (context) =>
                  getIt<HomeCubit>()
                    ..getNews(context.read<LanguageCubit>().state.locale.languageCode)
                    ..getLatestNews(),
          child: const HomeScreen(),
        );
      case 1:
        return BlocProvider(
          create: (context) => getIt<BookmarkCubit>(),
          child: const BookmarkPage(),
        );
      case 2:
        return BlocProvider(
          create: (context) => getIt<SearchCubit>()..loadSearchHistory(),
          child: const SearchPage(),
        );
      case 3:
        return const Center(child: Text('Notifications'));
      case 4:
        return const SettingsPage();
      default:
        return const HomeScreen();
    }
  }
}
