import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:news_xproject/core/helpers/error_handler.dart';
import 'package:news_xproject/core/utils/try_catch.dart';
import 'package:news_xproject/features/home_screen/data/models/news_response.dart';
import 'package:news_xproject/features/home_screen/domain/entities/article_entity.dart';
import 'package:news_xproject/features/search/data/datasources/search_data_source.dart';

abstract class SearchRepository {
  /// Search for news articles by query
  Future<Either<ApiException, NewsResponse>> searchNews(String query);
  Future<Either<ApiException,void>> addToHistory(ArticleEntity article);
    Future<Either<ApiException,List<ArticleEntity>>> getSearchHistory();

}

@Injectable(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  final SearchDataSource dataSource;

  SearchRepositoryImpl(this.dataSource);

  @override
  Future<Either<ApiException, NewsResponse>> searchNews(String query) async {
    return executeTryCatchRepo(() async {
      final response = await dataSource.searchNews(query);
      return NewsResponse.fromJson(response);
    });
  }
   @override
    Future<Either<ApiException,void>> addToHistory(ArticleEntity article) {
    return executeTryCatchRepo(() async {
      return dataSource.addToHistory(article);
    });
  }
  
  @override
  Future<Either<ApiException,List<ArticleEntity>>> getSearchHistory() {
    return executeTryCatchRepo(() async {
      return dataSource.getSearchHistory();
    });
  }
}
