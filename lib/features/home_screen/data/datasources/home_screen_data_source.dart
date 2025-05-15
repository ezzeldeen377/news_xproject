import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:news_xproject/core/constants/api_constants.dart';
import 'package:news_xproject/core/helpers/api_services.dart';
import 'package:news_xproject/core/helpers/hive_service.dart';
import 'package:news_xproject/core/utils/try_catch.dart';
import 'package:news_xproject/features/home_screen/data/models/news_response.dart';
import 'package:news_xproject/features/home_screen/domain/entities/article_entity.dart';

abstract class HomeScreenDataSource {

  Future<Map<String,dynamic>> getLatestNews();
  Future<Map<String,dynamic>> getNews(String languageCode);
  
  
  Future<bool> addBookmark(ArticleEntity article);
  
  
  Future<bool> deleteBookmark(String articleUrl);
}

@Injectable(as: HomeScreenDataSource)
class HomeScreenDataSourceImpl implements HomeScreenDataSource {
  final ApiService apiService;
  HomeScreenDataSourceImpl({required this.apiService});

  @override
  Future<Map<String,dynamic>> getLatestNews() async {
    return executeTryCatchData(() async {
      final response = await apiService.get(
        ApiConstants.topHeadLinesEndPoint,
        queryParams: {'country': 'us',},
      );
      return response;
    });
  }
  
  @override
  Future<Map<String, dynamic>> getNews(String languageCode) {
     return executeTryCatchData(() async {
      final response = await apiService.get(
        ApiConstants.everyThingEndPoint,
        queryParams: {'q': "news",'pageSize':"10","language":languageCode},
      );
      return response;
    });
  }
  
  @override
  Future<bool> addBookmark(ArticleEntity article) async {
return executeTryCatchData(() async {
      await HiveService.addBookmark(article.url ?? '', article);
      return true;
    });
  }
  
  @override
  Future<bool> deleteBookmark(String articleUrl) async {
    return executeTryCatchData(() async {
      await HiveService.deleteBookmark(articleUrl);
      return true;
    });
    
  }
}
