// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:news_xproject/features/home_screen/domain/entities/article_entity.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState {
  final List<ArticleEntity> searchResults;
  final SearchStatus status;
  final String? errorMessage;
  final String query;
  final bool hasText;
  final List<ArticleEntity>? searchHistory;

  const SearchState({
    this.searchResults = const [],
    this.status = SearchStatus.initial,
    this.errorMessage,
    this.query = '',
    this.hasText=false,
     this.searchHistory,
  });

  SearchState copyWith({
    List<ArticleEntity>? searchResults,
    SearchStatus? status,
    String? errorMessage,
    String? query,
    bool? hasText,
    List<ArticleEntity>? searchHistory,
  }) {
    return SearchState(
      searchResults: searchResults ?? this.searchResults,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      query: query ?? this.query,
      hasText: hasText ?? this.hasText,
      searchHistory: searchHistory ?? this.searchHistory,
    );
  }

  @override
  String toString() {
    return 'SearchState(searchResults: $searchResults, status: $status, errorMessage: $errorMessage, query: $query, hasText: $hasText, searchHistory: $searchHistory)';
  }
}
