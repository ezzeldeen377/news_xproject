import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_xproject/core/helpers/hive_service.dart';
import 'package:news_xproject/features/home_screen/domain/entities/article_entity.dart';
import 'package:news_xproject/features/home_screen/domain/usecases/add_bookmark_usecase.dart';
import 'package:news_xproject/features/home_screen/domain/usecases/delete_bookmark_usecase.dart';
import 'package:news_xproject/features/news_details/presentation/cubit/news_details_state.dart';
@injectable
class NewsDetailsCubit extends Cubit<NewsDetailsState>{

  NewsDetailsCubit(this._addBookmarkUseCase, this._deleteBookmarkUseCase):super(NewsDetailsState(status: NewsDetailsStatus.initial));
  final AddBookmarkUseCase _addBookmarkUseCase ;
  final DeleteBookmarkUseCase _deleteBookmarkUseCase ;
  
  Future<void> addBookmark(ArticleEntity article) async {
    emit(state.copyWith(status: NewsDetailsStatus.loading));
    
    final result = await _addBookmarkUseCase(article);
    
    result.fold(
      (failure) => emit(state.copyWith(
        status: NewsDetailsStatus.failure,
        errorMessage: failure.message,
      )),
      (success) => emit(state.copyWith(
        status: NewsDetailsStatus.success,
                isBookmarked: true,

      )),
    );
  }

  /// Removes an article from bookmarks
  Future<void> removeBookmark(String articleUrl) async {
    emit(state.copyWith(status: NewsDetailsStatus.loading));
    
    final result = await _deleteBookmarkUseCase(articleUrl);
    
    result.fold(
      (failure) => emit(state.copyWith(
        status: NewsDetailsStatus.failure,
        errorMessage: failure.message,
      )),
      (success) => emit(state.copyWith(
        status: NewsDetailsStatus.success,
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