import 'package:news_xproject/features/home_screen/domain/entities/article_entity.dart';

enum BookmarkStatus { initial, loading, success, failure }

class BookmarkState  {
  final List<ArticleEntity> bookmarks;
  final BookmarkStatus status;
  final String? errorMessage;
  final Map<int, bool> swipedItems;

  const BookmarkState({
    this.bookmarks = const [],
    this.status = BookmarkStatus.initial,
    this.errorMessage,
    this.swipedItems = const {},
  });

  BookmarkState copyWith({
    List<ArticleEntity>? bookmarks,
    BookmarkStatus? status,
    String? errorMessage,
    Map<int, bool>? swipedItems,
  }) {
    return BookmarkState(
      bookmarks: bookmarks ?? this.bookmarks,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      swipedItems: swipedItems ?? this.swipedItems,
    );
  }

 
}