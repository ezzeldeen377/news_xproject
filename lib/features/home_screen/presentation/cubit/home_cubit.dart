import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_xproject/core/helpers/hive_service.dart';
import 'package:news_xproject/features/home_screen/domain/entities/article_entity.dart';
import 'package:news_xproject/features/home_screen/domain/usecases/add_bookmark_usecase.dart';
import 'package:news_xproject/features/home_screen/domain/usecases/delete_bookmark_usecase.dart';
import 'package:news_xproject/features/home_screen/domain/usecases/get_latest_news_usecase.dart';
import 'package:news_xproject/features/home_screen/domain/usecases/get_news_usecase.dart';
import 'package:news_xproject/features/home_screen/presentation/cubit/home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetLatestNewsUseCase _getLatestNewsUseCase;
  final GetNewsUsecase _getNewsUseCase;
final AddBookmarkUseCase _addBookmarkUseCase;
  final DeleteBookmarkUseCase _deleteBookmarkUseCase;
  HomeCubit(this._getLatestNewsUseCase, this._getNewsUseCase, this._addBookmarkUseCase, this._deleteBookmarkUseCase) : super(const HomeState());

  /// Fetches the latest news articles
  Future<void> getLatestNews() async {
    emit(state.copyWith(status: NewsStatus.loading));
    
    final result = await _getLatestNewsUseCase();
    
    result.fold(
      (failure) => emit(state.copyWith(
        status: NewsStatus.failure,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: NewsStatus.successGetLastNews,
        lastArticles: response.articles,
      )),
    );
  }
  Future<void> getNews(String languageCode) async {
    emit(state.copyWith(status: NewsStatus.loading));
    
    final result = await _getNewsUseCase(languageCode);
    
    result.fold(
      (failure) => emit(state.copyWith(
        status: NewsStatus.failure,
        errorMessage: failure.message,
      )),
      (response) => emit(state.copyWith(
        status: NewsStatus.successGetNews,
        articles: response.articles,
      )),
    );
  }

  /// Refreshes the latest news articles
  Future<void> refreshNews(String languageCode) async {
    await getLatestNews();
    await getNews(languageCode);
  }

  Future<void> addBookmark(ArticleEntity article) async {
    emit(state.copyWith(bookmarkStatus: BookmarkStatus.loading));
    
    final result = await _addBookmarkUseCase(article);
    
    result.fold(
      (failure) => emit(state.copyWith(
        bookmarkStatus: BookmarkStatus.failure,
        bookmarkErrorMessage: failure.message,
      )),
      (success) => emit(state.copyWith(
        bookmarkStatus: BookmarkStatus.success,
        isBookmarked: true,
      )),
    );
  }

  /// Removes an article from bookmarks
  Future<void> removeBookmark(String articleUrl) async {
    emit(state.copyWith(bookmarkStatus: BookmarkStatus.loading));
    
    final result = await _deleteBookmarkUseCase(articleUrl);
    
    result.fold(
      (failure) => emit(state.copyWith(
        bookmarkStatus: BookmarkStatus.failure,
        bookmarkErrorMessage: failure.message,
      )),
      (success) => emit(state.copyWith(
        bookmarkStatus: BookmarkStatus.success,
        isBookmarked: false,
      )),
    );
  }

  /// Checks if an article is bookmarked
  bool checkBookmarkStatus(String articleUrl) {
    final isBookmarked = HiveService.bookmarkExists(articleUrl);
    return isBookmarked;
  }

  /// Toggles bookmark status
  Future<void> toggleBookmark(ArticleEntity article) async {
    final articleUrl = article.url ?? '';
    final isBookmarked = HiveService.bookmarkExists(articleUrl);
    
    if (isBookmarked) {
      await removeBookmark(articleUrl);
    } else {
      await addBookmark(article);
    }
  }
 
}
