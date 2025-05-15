import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:news_xproject/core/helpers/error_handler.dart';
import 'package:news_xproject/features/bookmark/data/datasources/bookmark_data_source.dart';
import 'package:news_xproject/features/home_screen/domain/entities/article_entity.dart';

abstract class BookmarkRepository {
  /// Get all bookmarked articles
  Either<ApiException, List<ArticleEntity>> getBookmarks();

  /// Remove a bookmark by article URL
  Future<Either<ApiException, bool>> removeBookmark(String articleUrl);
}

@Injectable(as: BookmarkRepository)
class BookmarkRepositoryImpl implements BookmarkRepository {
  final BookmarkDataSource dataSource;

  BookmarkRepositoryImpl(this.dataSource);

  @override
  Either<ApiException, List<ArticleEntity>> getBookmarks() {
    try {
      final bookmarks = dataSource.getBookmarks();
      return Right(bookmarks);
    } catch (e) {
      return Left(ApiException('Failed to get bookmarks: ${e.toString()}'));
    }
  }

  @override
  Future<Either<ApiException, bool>> removeBookmark(String articleUrl) async {
    try {
      final result = await dataSource.removeBookmark(articleUrl);
      return Right(result);
    } catch (e) {
      return Left(ApiException('Failed to remove bookmark: ${e.toString()}'));
    }
  }
}
