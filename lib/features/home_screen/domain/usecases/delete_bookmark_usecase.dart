import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:news_xproject/core/helpers/error_handler.dart';
import 'package:news_xproject/features/home_screen/data/repositories/home_screen_repository.dart';

@injectable
class DeleteBookmarkUseCase {
  final HomeScreenRepository repository;

  DeleteBookmarkUseCase(this.repository);

  Future<Either<ApiException, bool>> call(String articleUrl) async {
    return await repository.deleteBookmark(articleUrl);
  }
}