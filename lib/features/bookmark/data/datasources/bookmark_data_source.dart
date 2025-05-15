import 'package:injectable/injectable.dart';
import 'package:news_xproject/core/helpers/hive_service.dart';
import 'package:news_xproject/core/utils/try_catch.dart';
import 'package:news_xproject/features/home_screen/domain/entities/article_entity.dart';

abstract class BookmarkDataSource {
  List<ArticleEntity> getBookmarks();
  Future<bool> removeBookmark(String articleUrl);
}

@Injectable(as: BookmarkDataSource)
class BookmarkDataSourceImpl implements BookmarkDataSource {
  @override
  List<ArticleEntity> getBookmarks() {
    // Get all bookmarks as a map and convert to a list of ArticleEntity
    try {
      final bookmarksMap = HiveService.getAllBookmarks();
      return bookmarksMap.values.toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> removeBookmark(String articleUrl) async {
    try {
      await HiveService.deleteBookmark(articleUrl);
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
