import 'package:news_xproject/features/home_screen/domain/entities/article_entity.dart';

class NewsResponse  {
  final String? status;
  final int? totalResults;
  final List<Article>? articles;

  const NewsResponse({this.status, this.totalResults, this.articles});

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
  return NewsResponse(
    status: json['status'] as String?,
    totalResults: json['totalResults'] as int?,
    articles: json['articles'] != null
        ? List<Article>.from(
            (json['articles'] as List<dynamic>).map((v) => Article.fromJson(v)))
        : null,
  );

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['totalResults'] = totalResults;
    if (articles != null) {
      data['articles'] = articles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

/// Model class representing a news article.
class Article {
  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  const Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: json['source'] != null ? Source.fromJson(json['source']) : null,
      author: json['author'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String?,
      urlToImage: json['urlToImage'] as String?,
      publishedAt: json['publishedAt'] as String?,
      content: json['content'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (source != null) {
      data['source'] = source!.toJson();
    }
    data['author'] = author;
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    data['urlToImage'] = urlToImage;
    data['publishedAt'] = publishedAt;
    data['content'] = content;
    return data;
  }
}

/// Model class representing the source of a news article.
class Source {
  final String? id;
  final String? name;

  const Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
extension NewsResponseExtension on NewsResponse {
  NewsResponseEntity toEntity() {
    return NewsResponseEntity(
      status: status,
      totalResults: totalResults,
      articles: articles?.map((article) => article.toEntity()).toList(),
    );
  }
}
extension ArticleExtension on Article {
  ArticleEntity toEntity() {
    return ArticleEntity(
      source: source?.toEntity(),
      author: author,
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
      content: content,
    );
  }
}
extension SourceExtension on Source {
  SourceEntity toEntity() {
    return SourceEntity(
      id: id,
      name: name,
    );
  }
}