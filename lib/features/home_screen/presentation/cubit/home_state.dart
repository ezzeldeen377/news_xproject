// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:news_xproject/features/home_screen/domain/entities/article_entity.dart';

enum NewsStatus { initial, loading, successGetNews,successGetLastNews, failure }

enum BookmarkStatus { initial, loading, success, failure }

class HomeState {
  final List<ArticleEntity>? lastArticles;

  final List<ArticleEntity>? articles;
  final NewsStatus status;
  final BookmarkStatus bookmarkStatus;
  final String? errorMessage;
  final String? bookmarkErrorMessage;
  final bool isBookmarked;

  const HomeState({
    this.lastArticles,
    this.articles,
    this.status = NewsStatus.initial,
    this.bookmarkStatus = BookmarkStatus.initial,
    this.errorMessage,
    this.bookmarkErrorMessage,
    this.isBookmarked = false,
  });

  HomeState copyWith({
    List<ArticleEntity>? lastArticles,
    List<ArticleEntity>? articles,
    NewsStatus? status,
    BookmarkStatus? bookmarkStatus,
    String? errorMessage,
    String? bookmarkErrorMessage,
    bool? isBookmarked,
  }) {
    return HomeState(
      lastArticles: lastArticles ?? this.lastArticles,
      articles: articles ?? this.articles,
      status: status ?? this.status,
      bookmarkStatus: bookmarkStatus ?? this.bookmarkStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      bookmarkErrorMessage: bookmarkErrorMessage ?? this.bookmarkErrorMessage,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }

  @override
  String toString() {
    return 'HomeState(status: $status, bookmarkStatus: $bookmarkStatus, errorMessage: $errorMessage, bookmarkErrorMessage: $bookmarkErrorMessage, isBookmarked: $isBookmarked)';
  }
}
