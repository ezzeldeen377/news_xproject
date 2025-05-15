import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:news_xproject/core/helpers/error_handler.dart';
import 'package:news_xproject/features/home_screen/data/models/news_response.dart';
import 'package:news_xproject/features/home_screen/data/repositories/home_screen_repository.dart';
import 'package:news_xproject/features/home_screen/domain/entities/article_entity.dart';

@injectable
class GetLatestNewsUseCase {
  final HomeScreenRepository repository;

  GetLatestNewsUseCase(this.repository);

  Future<Either<ApiException, NewsResponseEntity>> call() async {
    final response = await repository.getLatestNews();
    return response.fold(
      (l) => Left(l),
      (r) => Right(r.toEntity()),
    );
  }
}
