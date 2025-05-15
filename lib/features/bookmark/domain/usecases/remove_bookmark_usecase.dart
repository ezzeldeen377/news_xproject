import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:news_xproject/core/helpers/error_handler.dart';
import 'package:news_xproject/features/bookmark/data/repositories/bookmark_repository.dart';

@injectable
class RemoveBookmarkUseCase {
  final BookmarkRepository repository;

  RemoveBookmarkUseCase(this.repository);

  Future<Either<ApiException, bool>> call(String articleUrl) async {
    return await repository.removeBookmark(articleUrl);
  }
}