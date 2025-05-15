import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:news_xproject/core/helpers/error_handler.dart';
import 'package:news_xproject/features/home_screen/data/models/news_response.dart';
import 'package:news_xproject/features/home_screen/domain/entities/article_entity.dart';
import 'package:news_xproject/features/search/data/repositories/search_repository.dart';

@injectable
class SearchNewsUseCase {
  final SearchRepository repository;

  SearchNewsUseCase(this.repository);

  Future<Either<ApiException, NewsResponseEntity>> call(String query) async {
    final response = await repository.searchNews(query);
   return  response.fold((l) => Left(l), (r) => Right(r.toEntity()));
  }
}
