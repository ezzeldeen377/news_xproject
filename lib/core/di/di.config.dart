// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/bookmark/data/datasources/bookmark_data_source.dart'
    as _i172;
import '../../features/bookmark/data/repositories/bookmark_repository.dart'
    as _i533;
import '../../features/bookmark/domain/usecases/get_bookmarks_usecase.dart'
    as _i761;
import '../../features/bookmark/domain/usecases/remove_bookmark_usecase.dart'
    as _i173;
import '../../features/bookmark/presentation/cubit/bookmark_cubit.dart'
    as _i340;
import '../../features/home_screen/data/datasources/home_screen_data_source.dart'
    as _i908;
import '../../features/home_screen/data/repositories/home_screen_repository.dart'
    as _i661;
import '../../features/home_screen/domain/usecases/add_bookmark_usecase.dart'
    as _i159;
import '../../features/home_screen/domain/usecases/delete_bookmark_usecase.dart'
    as _i779;
import '../../features/home_screen/domain/usecases/get_latest_news_usecase.dart'
    as _i231;
import '../../features/home_screen/domain/usecases/get_news_usecase.dart'
    as _i896;
import '../../features/home_screen/presentation/cubit/home_cubit.dart' as _i881;
import '../../features/news_details/presentation/cubit/news_details_cubit.dart'
    as _i301;
import '../../features/search/data/datasources/search_data_source.dart'
    as _i545;
import '../../features/search/data/repositories/search_repository.dart'
    as _i708;
import '../../features/search/domain/usecases/add_to_history_usecase.dart'
    as _i825;
import '../../features/search/domain/usecases/get_search_history_usecase.dart'
    as _i345;
import '../../features/search/domain/usecases/search_news_usecase.dart'
    as _i334;
import '../../features/search/presentation/cubit/search_cubit.dart' as _i341;
import '../helpers/api_services.dart' as _i517;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i517.ApiService>(() => _i517.ApiService());
    gh.factory<_i545.SearchDataSource>(
        () => _i545.SearchDataSourceImpl(gh<_i517.ApiService>()));
    gh.factory<_i908.HomeScreenDataSource>(() =>
        _i908.HomeScreenDataSourceImpl(apiService: gh<_i517.ApiService>()));
    gh.factory<_i172.BookmarkDataSource>(() => _i172.BookmarkDataSourceImpl());
    gh.factory<_i533.BookmarkRepository>(
        () => _i533.BookmarkRepositoryImpl(gh<_i172.BookmarkDataSource>()));
    gh.factory<_i661.HomeScreenRepository>(() => _i661.HomeScreenRepositoryImpl(
        dataSource: gh<_i908.HomeScreenDataSource>()));
    gh.factory<_i708.SearchRepository>(
        () => _i708.SearchRepositoryImpl(gh<_i545.SearchDataSource>()));
    gh.factory<_i159.AddBookmarkUseCase>(
        () => _i159.AddBookmarkUseCase(gh<_i661.HomeScreenRepository>()));
    gh.factory<_i779.DeleteBookmarkUseCase>(
        () => _i779.DeleteBookmarkUseCase(gh<_i661.HomeScreenRepository>()));
    gh.factory<_i231.GetLatestNewsUseCase>(
        () => _i231.GetLatestNewsUseCase(gh<_i661.HomeScreenRepository>()));
    gh.factory<_i896.GetNewsUsecase>(
        () => _i896.GetNewsUsecase(gh<_i661.HomeScreenRepository>()));
    gh.factory<_i761.GetBookmarksUseCase>(
        () => _i761.GetBookmarksUseCase(gh<_i533.BookmarkRepository>()));
    gh.factory<_i173.RemoveBookmarkUseCase>(
        () => _i173.RemoveBookmarkUseCase(gh<_i533.BookmarkRepository>()));
    gh.factory<_i301.NewsDetailsCubit>(() => _i301.NewsDetailsCubit(
          gh<_i159.AddBookmarkUseCase>(),
          gh<_i779.DeleteBookmarkUseCase>(),
        ));
    gh.factory<_i825.AddToHistoryUseCase>(
        () => _i825.AddToHistoryUseCase(gh<_i708.SearchRepository>()));
    gh.factory<_i345.GetSearchHistoryUseCase>(
        () => _i345.GetSearchHistoryUseCase(gh<_i708.SearchRepository>()));
    gh.factory<_i334.SearchNewsUseCase>(
        () => _i334.SearchNewsUseCase(gh<_i708.SearchRepository>()));
    gh.factory<_i340.BookmarkCubit>(() => _i340.BookmarkCubit(
          gh<_i761.GetBookmarksUseCase>(),
          gh<_i173.RemoveBookmarkUseCase>(),
        ));
    gh.factory<_i881.HomeCubit>(() => _i881.HomeCubit(
          gh<_i231.GetLatestNewsUseCase>(),
          gh<_i896.GetNewsUsecase>(),
          gh<_i159.AddBookmarkUseCase>(),
          gh<_i779.DeleteBookmarkUseCase>(),
        ));
    gh.factory<_i341.SearchCubit>(() => _i341.SearchCubit(
          gh<_i334.SearchNewsUseCase>(),
          gh<_i825.AddToHistoryUseCase>(),
          gh<_i345.GetSearchHistoryUseCase>(),
        ));
    return this;
  }
}
