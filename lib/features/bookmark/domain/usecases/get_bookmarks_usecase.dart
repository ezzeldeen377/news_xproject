import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:news_xproject/core/helpers/error_handler.dart';
import 'package:news_xproject/features/bookmark/data/repositories/bookmark_repository.dart';
import 'package:news_xproject/features/home_screen/domain/entities/article_entity.dart';

@injectable
class GetBookmarksUseCase {
  final BookmarkRepository repository;

  GetBookmarksUseCase(this.repository);

  Either<ApiException, List<ArticleEntity>> call() {
    return repository.getBookmarks();
  }
}