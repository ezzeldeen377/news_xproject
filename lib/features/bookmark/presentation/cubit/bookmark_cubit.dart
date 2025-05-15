import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_xproject/features/bookmark/domain/usecases/get_bookmarks_usecase.dart';
import 'package:news_xproject/features/bookmark/domain/usecases/remove_bookmark_usecase.dart';
import 'package:news_xproject/features/bookmark/presentation/cubit/bookmark_state.dart';

@injectable
class BookmarkCubit extends Cubit<BookmarkState> {
  final GetBookmarksUseCase _getBookmarksUseCase;
  final RemoveBookmarkUseCase _removeBookmarkUseCase;

  BookmarkCubit(
    this._getBookmarksUseCase,
    this._removeBookmarkUseCase,
  ) : super(const BookmarkState());

  Future<void> getBookmarks()async {
    emit(state.copyWith(status: BookmarkStatus.loading));
    
    final result = _getBookmarksUseCase();
    
    result.fold(
      (failure) => emit(state.copyWith(
        status: BookmarkStatus.failure,
        errorMessage: failure.message,
      )),
      (bookmarks) => emit(state.copyWith(
        status: BookmarkStatus.success,
        bookmarks: bookmarks,
      )),
    );
  }

  Future<void> removeBookmark(String url) async {
    try {
      await _removeBookmarkUseCase(url);
      // Refresh bookmarks after removal
      await getBookmarks();
    } catch (e) {
      emit(state.copyWith(
        status: BookmarkStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void setItemSwiped(int index, bool isSwiped) {
    final updatedSwipedItems = Map<int, bool>.from(state.swipedItems);
    updatedSwipedItems[index] = isSwiped;
    emit(state.copyWith(swipedItems: updatedSwipedItems));
  }
  
  void onSlideChanged(int index, double ratio) {
    final isSwiping = ratio.abs() > 0.01;
    if (state.swipedItems[index] != isSwiping) {
      setItemSwiped(index, isSwiping);
    }
  }
  
  void cleanupController(int index) {
    final updatedSwipedItems = Map<int, bool>.from(state.swipedItems);
    updatedSwipedItems.remove(index);
    emit(state.copyWith(swipedItems: updatedSwipedItems));
  }
}