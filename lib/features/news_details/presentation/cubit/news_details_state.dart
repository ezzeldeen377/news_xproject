// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:news_xproject/features/home_screen/domain/entities/article_entity.dart';

enum NewsDetailsStatus {
  initial,
  loading,
  success,
  failure,
}

class NewsDetailsState {
  final ArticleEntity? article;
  final NewsDetailsStatus status;
  final String? errorMessage;
  final bool? isBookmarked;
  NewsDetailsState({
    this.article,
    required this.status,
    this.errorMessage,
     this.isBookmarked,
  });
  

  NewsDetailsState copyWith({
    ArticleEntity? article,
    NewsDetailsStatus? status,
    String? errorMessage,
    bool? isBookmarked,
  }) {
    return NewsDetailsState(
      article: article ?? this.article,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }

  @override
  String toString() {
    return 'NewsDetailsState(article: $article, status: $status, errorMessage: $errorMessage, isBookmarked: $isBookmarked)';
  }
}
