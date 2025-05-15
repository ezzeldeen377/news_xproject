import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:news_xproject/core/helpers/error_handler.dart';
import 'package:news_xproject/core/utils/try_catch.dart';
import 'package:news_xproject/features/home_screen/data/datasources/home_screen_data_source.dart';
import 'package:news_xproject/features/home_screen/data/models/news_response.dart';
import 'package:news_xproject/features/home_screen/domain/entities/article_entity.dart';

abstract class HomeScreenRepository {
  Future<Either<ApiException, NewsResponse>> getLatestNews();
  Future<Either<ApiException, NewsResponse>> getNews(String languageCode);
  Future<Either<ApiException, bool>> addBookmark(ArticleEntity article);
  Future<Either<ApiException, bool>> deleteBookmark(String articleUrl);
}
@Injectable(as: HomeScreenRepository)
class HomeScreenRepositoryImpl implements HomeScreenRepository {
  final HomeScreenDataSource dataSource;

  HomeScreenRepositoryImpl({required this.dataSource});

  @override
  Future<Either<ApiException, NewsResponse>> getLatestNews() async {
    return  executeTryCatchRepo(() async {
      final response = await dataSource.getLatestNews();
      return NewsResponse.fromJson(response);
    });
  }
  
  @override
  Future<Either<ApiException, NewsResponse>> getNews(String languageCode) {
  return  executeTryCatchRepo(() async {
      final response = await dataSource.getNews(languageCode);

      return NewsResponse.fromJson(response);
    });
  }
  @override
Future<Either<ApiException, bool>> addBookmark(ArticleEntity article) async {
  try {
    final result = await dataSource.addBookmark(article);
    return Right(result);
  } on ApiException catch (e) {
    return Left(e);
  } catch (e) {
    return Left(ApiException( e.toString()));
  }
}

@override
Future<Either<ApiException, bool>> deleteBookmark(String articleUrl) async {
  try {
    final result = await dataSource.deleteBookmark(articleUrl);
    return Right(result);
  } on ApiException catch (e) {
    return Left(e);
  } catch (e) {
    return Left(ApiException( e.toString()));
  }
}
}