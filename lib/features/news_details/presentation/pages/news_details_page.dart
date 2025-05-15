import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_xproject/core/theme/app_color.dart';
import 'package:news_xproject/features/home_screen/domain/entities/article_entity.dart';
import 'package:news_xproject/features/news_details/presentation/widgets/custom_image_section.dart';
import 'package:news_xproject/features/news_details/presentation/widgets/custom_news_content.dart';
import 'package:news_xproject/features/news_details/presentation/widgets/custom_news_action_bar.dart';

class NewsDetailsPage extends StatelessWidget {
  const NewsDetailsPage({super.key, required this.article});
  final ArticleEntity article;

  @override
  Widget build(BuildContext context) {
    // Format the date if available
    String formattedDate = '';
    if (article.publishedAt != null) {
      try {
        final DateTime publishDate = DateTime.parse(article.publishedAt!);
        formattedDate = DateFormat('dd MMMM, yyyy — h:mm a').format(publishDate);
      } catch (e) {
        formattedDate = article.publishedAt ?? '';
      }
    }

    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image section at the top
            CustomImageSection(
              imageUrl: article.urlToImage ?? 'https://picsum.photos/800/500?random=5',
            ),
            
            // News content
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: CustomNewsContent(
                authorName: article.author ?? 'Unknown Author',
                authorImageUrl: 'https://picsum.photos/100/100?random=1', // Default author image
                category: article.sourceName ?? 'News',
                date: formattedDate,
                title: article.title ?? 'No Title Available',
                content: article.content ?? article.description ?? 'No content available',
              ),
            ),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: CustomNewsActionBar(
        article: article,
      ),
    );
  }
}
