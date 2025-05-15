import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:news_xproject/core/helpers/error_handler.dart';
import 'package:news_xproject/features/home_screen/data/models/news_response.dart';
import 'package:news_xproject/features/home_screen/data/repositories/home_screen_repository.dart';
import 'package:news_xproject/features/home_screen/domain/entities/article_entity.dart';


@injectable
class AddBookmarkUseCase {
  final HomeScreenRepository repository;

  AddBookmarkUseCase(this.repository);

  Future<Either<ApiException, bool>> call(ArticleEntity article) async {
    return await repository.addBookmark(article);
  }
}