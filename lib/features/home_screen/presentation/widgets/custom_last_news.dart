import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_xproject/core/constants/app_strings.dart';
import 'package:news_xproject/core/helpers/spacer.dart';
import 'package:news_xproject/core/theme/app_color.dart';
import 'package:news_xproject/core/theme/app_text_styles.dart';
import 'package:news_xproject/core/widgets/news_item.dart';
import 'package:news_xproject/features/home_screen/domain/entities/article_entity.dart';
import 'package:news_xproject/features/home_screen/presentation/cubit/home_cubit.dart';
import 'package:news_xproject/features/home_screen/presentation/cubit/home_state.dart';
import 'package:news_xproject/features/settings/presentation/cubit/language_cubit.dart';

class CustomLastNews extends StatelessWidget {
  const CustomLastNews({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => 
          previous.status != current.status || 
          previous.lastArticles != current.lastArticles,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.instance.latestNews,
                    style: AppTextStyles.font14TelegrafDarkGrayRegular,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle see all news action
                    },
                    child: Icon(context.read<LanguageCubit>().state.locale.languageCode=='en'? Icons.arrow_circle_right_outlined: Icons.arrow_circle_left_outlined, color: AppColor.grey),
                  ),
                ],
              ),
            ),
            verticalSpace(16),
            _buildNewsList(state,context),
          ],
        );
      },
    );
  }

 Widget _buildNewsList(HomeState state, BuildContext context) {
  if (state.status == NewsStatus.loading) {
    return _buildLoadingIndicator();
  } else if (state.status == NewsStatus.failure) {
    return _buildErrorView(state.errorMessage, context);
  } else if (state.status == NewsStatus.initial) {
    return const SizedBox.shrink();
  } else if (state.lastArticles?.isNotEmpty??false) {
    return _buildNewsListView(state.lastArticles);
  } else {
    return const SizedBox.shrink();
  }
}


  Widget _buildLoadingIndicator() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorView(String? errorMessage,BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          verticalSpace(8),
          Text(
            errorMessage ?? 'Failed to load news',
            textAlign: TextAlign.center,
            style: AppTextStyles.font14TelegrafDarkGrayRegular,
          ),
          verticalSpace(16),
          ElevatedButton(
            onPressed: () {
              // Retry loading news
             context.read<HomeCubit>().refreshNews(context.read<LanguageCubit>().state.locale.languageCode);
            },
            child:  Text(            AppStrings.instance.retry),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsListView(List<ArticleEntity>? articles) {
    if (articles == null || articles.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            AppStrings.instance.noNewsAvailable,
            style: AppTextStyles.font14TelegrafDarkGrayRegular,
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return NewsItem(
          article: article,
        );
      },
    );
  }
}
