import 'package:injectable/injectable.dart';
import 'package:news_xproject/core/constants/api_constants.dart';
import 'package:news_xproject/core/helpers/api_services.dart';
import 'package:news_xproject/core/helpers/hive_service.dart';
import 'package:news_xproject/core/utils/try_catch.dart';
import 'package:news_xproject/features/home_screen/domain/entities/article_entity.dart';

abstract class SearchDataSource {
  Future<Map<String, dynamic>> searchNews(String query);
  Future<void> addToHistory(ArticleEntity article);
  Future<List<ArticleEntity>> getSearchHistory();
}

@Injectable(as: SearchDataSource)
class SearchDataSourceImpl implements SearchDataSource {
  final ApiService apiService;
  final String historyBoxName = 'search_history';

  SearchDataSourceImpl(this.apiService);

  @override
  Future<Map<String, dynamic>> searchNews(String query) {
    return executeTryCatchData(() async {
      final response = await apiService.get(
        ApiConstants.everyThingEndPoint,
        queryParams: {'q': query},
      );

      return response;
    });
  }

  @override
  Future<void> addToHistory(ArticleEntity article) async {
    return executeTryCatchData(() async {
      return HiveService.addToHistory(article);
    });
  }

  @override
  Future<List<ArticleEntity>> getSearchHistory() async {
   return executeTryCatchData(() async {
      final response= HiveService.getAllHistory();
      print("############################$response");
      return response;
    });
   
  }
}
