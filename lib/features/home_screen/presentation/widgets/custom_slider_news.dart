import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_xproject/core/constants/app_strings.dart';
import 'package:news_xproject/core/constants/images_icons.dart';
import 'package:news_xproject/core/helpers/nav_extension.dart';
import 'package:news_xproject/core/helpers/spacer.dart';
import 'package:news_xproject/core/router/route_names.dart';
import 'package:news_xproject/core/theme/app_text_styles.dart';
import 'package:news_xproject/features/home_screen/domain/entities/article_entity.dart';
import 'package:news_xproject/features/home_screen/presentation/cubit/home_cubit.dart';
import 'package:news_xproject/features/home_screen/presentation/cubit/home_state.dart';
import 'package:news_xproject/features/settings/presentation/cubit/language_cubit.dart';
import 'package:timeago/timeago.dart' as timeago;

class CustomSliderNews extends StatelessWidget {
  CustomSliderNews({super.key});

  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen:
          (previous, current) =>
              previous.status != current.status ||
              previous.lastArticles != current.lastArticles,
      builder: (context, state) {
        return _buildSlider(state);
      },
    );
  }

  Widget _buildSlider(HomeState state) {
    if (state.status == NewsStatus.loading) {
      return _buildLoadingIndicator();
    } else if (state.status == NewsStatus.failure) {
      return _buildErrorView(state.errorMessage);
    } else if (state.status == NewsStatus.initial) {
      return const SizedBox.shrink();
    } else if (state.articles?.isNotEmpty ?? false) {
      return _buildCarouselSlider(state.articles, _carouselController);
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildLoadingIndicator() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
      child: Container(
        height: 311.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: Colors.grey[300],
        ),
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildErrorView(String? errorMessage) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
      child: Container(
        height: 311.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: Colors.grey[200],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              SizedBox(height: 16.h),
              Text(
                errorMessage ?? 'Failed to load featured news',
                textAlign: TextAlign.center,
                style: AppTextStyles.font14TelegrafDarkGrayRegular,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarouselSlider(
    List<ArticleEntity>? articles,
    CarouselSliderController carouselController,
  ) {
    if (articles == null || articles.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
        child: Container(
          height: 311.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: Colors.grey[200],
          ),
          child: Center(
            child: Text(
              AppStrings.instance.noNewsAvailable,
              style: AppTextStyles.font14TelegrafDarkGrayRegular,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
      child: CarouselSlider.builder(
        carouselController: carouselController,
        itemCount: articles.length,
        itemBuilder: (context, index, realIndex) {
          return _buildNewsCard(articles[index], context);
        },
        options: CarouselOptions(
          height: 311.h,
          viewportFraction: 1,
          enlargeCenterPage: true,
          enableInfiniteScroll: true,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          onPageChanged: (index, reason) {
            // You can add page change handling here if needed
          },
        ),
      ),
    );
  }

  Widget _buildNewsCard(ArticleEntity article, BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
      child: InkWell(
        onTap: () {
          context.pushNamed(RouteNames.newsDetails, arguments: article);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Use CachedNetworkImage widget
              CachedNetworkImage(
                imageUrl: article.urlToImage ?? '',
                fit: BoxFit.cover,
                placeholder:
                    (context, url) => Container(
                      color: Colors.grey[300],
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                errorWidget:
                    (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.error, color: Colors.red),
                    ),
              ),
              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  ),
                ),
              ),
              // Content
              Padding(
                padding: EdgeInsets.all(24.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          article.source?.name?.toUpperCase() ?? 'NEWS',
                          style: AppTextStyles.font12TelegrafWhiteUltraBold,
                        ),
                        Text(
                          timeago.format(
                           DateTime.parse( article.publishedAt ??DateTime.now().toString()),
                            locale: context.read<LanguageCubit>().state.locale.languageCode,
                          ),
                          style: AppTextStyles.font8TelegrafWhiteRegular,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      article.title ?? '',
                      style: AppTextStyles.font18TelegrafWhiteUltraBold,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        _buildActioncCommentButton(),
                        horizontalSpace(24),
                        _buildActionBookmarkButton(context, article),
                        const Spacer(),
                        _buildActionShareButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActioncCommentButton() {
    return SvgPicture.asset(AppIcons.comment);
    // Handle other icon actions
  }

  Widget _buildActionShareButton() {
    return SvgPicture.asset(AppIcons.share);
    // Handle other icon actions
  }

  Widget _buildActionBookmarkButton(
    BuildContext context,
    ArticleEntity article,
  ) {
    return GestureDetector(
      onTap: () {
        context.read<HomeCubit>().toggleBookmark(article);
      },
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.all(8.r),
            child: SvgPicture.asset(
              AppIcons.bookmark,
              color:
                  context.read<HomeCubit>().checkBookmarkStatus(
                        article.url ?? "",
                      )
                      ? Colors.red
                      : null,
            ),
          );
        },
      ),
    );
    // Handle other icon actions
  }

  String _getTimeAgo(String? publishedAt) {
    if (publishedAt == null) return '';

    try {
      final DateTime publishDate = DateTime.parse(publishedAt);
      final Duration difference = DateTime.now().difference(publishDate);

      if (difference.inDays > 0) {
        return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} min ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return publishedAt;
    }
  }
}
