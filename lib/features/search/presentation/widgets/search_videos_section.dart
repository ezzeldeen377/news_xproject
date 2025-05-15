import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_xproject/core/constants/app_strings.dart';
import 'package:news_xproject/core/theme/app_color.dart';
import 'package:news_xproject/core/theme/app_text_styles.dart';
import 'package:news_xproject/features/search/presentation/cubit/search_cubit.dart';
import 'package:news_xproject/features/search/presentation/cubit/search_state.dart';
import 'package:news_xproject/features/search/presentation/widgets/video_item.dart';
import 'package:news_xproject/features/home_screen/domain/entities/article_entity.dart';

class SearchVideosSection extends StatelessWidget {
  const SearchVideosSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        // Get history from state
        final List<ArticleEntity> historyItems = state.searchHistory??[];
      
        
        // If history is empty, don't show the section
        if (historyItems.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                   AppStrings.instance.recentSearches,
                    style: AppTextStyles.font26TelegrafBlackRegular,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to full history page or clear history
                      // You can implement this functionality later
                    },
                    child: Icon(
                      Icons.arrow_circle_right_outlined,
                      color: AppColor.grey,
                      size: 20.r,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 150.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                itemCount: historyItems.length > 5 ? 5 : historyItems.length, // Limit to 5 items
                itemBuilder: (context, index) {
                  final article = historyItems[index];
                  return VideoItem(
                    title: article.title ?? 'No Title',
                    imageUrl: article.urlToImage ?? 'https://picsum.photos/200/200?random=${index + 1}',
                  
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}