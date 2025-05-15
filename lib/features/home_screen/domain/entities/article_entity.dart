// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:news_xproject/features/home_screen/data/models/news_response.dart';

part 'article_entity.g.dart'; // required for code generation

@HiveType(typeId: 0)
class NewsResponseEntity {
  @HiveField(0)
  final String? status;
  
  @HiveField(1)
  final int? totalResults;
  
  @HiveField(2)
  final List<ArticleEntity>? articles;
  
  NewsResponseEntity({
    this.status,
    this.totalResults,
    this.articles,
  });
}

@HiveType(typeId: 1)
class ArticleEntity {
  @HiveField(0)
  final SourceEntity? source;
  
  @HiveField(1)
  final String? title;
  
  @HiveField(2)
  final String? description;
  
  @HiveField(3)
  final String? content;
  
  @HiveField(4)
  final String? author;
  
  @HiveField(5)
  final String? url;
  
  @HiveField(6)
  final String? urlToImage;
  
  @HiveField(7)
  final String? publishedAt;
  
  @HiveField(8)
  final String? sourceName;

  const ArticleEntity({
    this.source,
    this.title,
    this.description,
    this.content,
    this.author,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.sourceName,
  });
}

@HiveType(typeId: 2)
class SourceEntity {
  @HiveField(0)
  final String? id;
  
  @HiveField(1)
  final String? name;

  const SourceEntity({this.id, this.name});
}

extension ArticleEntityX on ArticleEntity {
  Article toDto() {
    return Article(
      source: source?.toDto(),
      title: title,
      description: description,
      content: content,
      author: author,
      url: url,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
    );
  }
}

extension SourceEntityX on SourceEntity {
  Source toDto() {
    return Source(
      id: id,
      name: name,
    );
  }
}