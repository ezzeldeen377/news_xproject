import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_xproject/core/helpers/nav_extension.dart';
import 'package:news_xproject/core/helpers/spacer.dart';
import 'package:news_xproject/core/router/route_names.dart';
import 'package:news_xproject/core/theme/app_color.dart';
import 'package:news_xproject/core/theme/app_text_styles.dart';
import 'package:news_xproject/features/home_screen/domain/entities/article_entity.dart';

class NewsItem extends StatelessWidget {
  final ArticleEntity article;

  const NewsItem({
    super.key, required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(RouteNames.newsDetails, arguments: article);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),        color: AppColor.white,

                      ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: SizedBox(
                width: 100.w,
                height: 100.h,
                child: CachedNetworkImage(
                  imageUrl: article.urlToImage ?? '',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.error, color: Colors.red),
                  ),
                ),
              ),
            ),
            horizontalSpace(15),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                   article.title??"",
                    style: AppTextStyles.font12TelegrafDarkGreyUltraBold,
                    maxLines: 2,
                  ),
                  verticalSpace(4),
                  Text(
                    article.description??"",
                    style: AppTextStyles.font18TelegrafBlackIltraBold,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}