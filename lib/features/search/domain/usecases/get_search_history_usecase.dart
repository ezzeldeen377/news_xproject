import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:news_xproject/core/helpers/error_handler.dart';
import 'package:news_xproject/features/home_screen/domain/entities/article_entity.dart';
import 'package:news_xproject/features/search/data/repositories/search_repository.dart';


@injectable
class GetSearchHistoryUseCase {
  final SearchRepository repository;
  
  GetSearchHistoryUseCase(this.repository);
  
  Future<Either<ApiException,List<ArticleEntity>>> call() {
    return repository.getSearchHistory();
  }
}