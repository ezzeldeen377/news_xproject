import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_xproject/features/home_screen/domain/entities/article_entity.dart';
import 'package:news_xproject/features/search/domain/usecases/search_news_usecase.dart';
import 'package:news_xproject/features/search/domain/usecases/add_to_history_usecase.dart';
import 'package:news_xproject/features/search/domain/usecases/get_search_history_usecase.dart';
import 'package:news_xproject/features/search/presentation/cubit/search_state.dart';
import 'dart:async';

@injectable
class SearchCubit extends Cubit<SearchState> {
  final SearchNewsUseCase _searchNewsUseCase;
  final AddToHistoryUseCase _addToHistoryUseCase;
  final GetSearchHistoryUseCase _getSearchHistoryUseCase;
  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  SearchCubit(
    this._searchNewsUseCase,
    this._addToHistoryUseCase,
    this._getSearchHistoryUseCase,
  ) : super(const SearchState()) {
    searchController.addListener(_onSearchControllerChanged);
    loadSearchHistory();
  }

  void _onSearchControllerChanged() {
    onQueryChanged(searchController.text);
  }

  void onQueryChanged(String query) {
    emit(state.copyWith(query: query, hasText: query.isNotEmpty));

    if (query.isEmpty) {
      clearSearch();
    } else {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        if (query.isNotEmpty) {
          searchNews(query);
        }
      });
    }
  }

  Future<void> searchNews(String query) async {
    if (query.isEmpty) {
      emit(const SearchState());
      return;
    }

    emit(state.copyWith(status: SearchStatus.loading, query: query));

    final result = await _searchNewsUseCase(query);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: SearchStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (response) => emit(
        state.copyWith(
          status: SearchStatus.success,
          searchResults: response.articles,
        ),
      ),
    );
  }

  Future<void> loadSearchHistory() async {
      final history = await _getSearchHistoryUseCase();
      history.fold(
        (error) => emit(
          state.copyWith(
            status: SearchStatus.failure,
            errorMessage: error.message,
          ),
        ),
        (response) => emit(state.copyWith(searchHistory: response)),
      );
    
  }

  Future<void> addToHistory(ArticleEntity article) async {
      await _addToHistoryUseCase(article);
      await loadSearchHistory(); // Reload history after adding
   
  }

  void clearSearch() {
    searchController.clear();
    emit(
      state.copyWith(
        query: '',
        hasText: false,
        status: SearchStatus.initial,
        searchResults: [],
      ),
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    searchController.removeListener(_onSearchControllerChanged);
    searchController.dispose();
    return super.close();
  }
}
