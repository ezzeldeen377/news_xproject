import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_xproject/core/constants/app_strings.dart';
import 'package:news_xproject/core/helpers/hive_service.dart';
import 'package:news_xproject/core/helpers/nav_extension.dart';
import 'package:news_xproject/core/router/route_names.dart';
import 'package:news_xproject/core/theme/app_color.dart';
import 'package:news_xproject/core/theme/app_text_styles.dart';
import 'package:news_xproject/core/widgets/news_item.dart';
import 'package:news_xproject/features/search/presentation/cubit/search_cubit.dart';
import 'package:news_xproject/features/search/presentation/cubit/search_state.dart';

class SearchResultsList extends StatelessWidget {
  const SearchResultsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        // Initial state - show search suggestions or history
        if (state.status == SearchStatus.initial) {
          return _buildInitialState();
        }

        // Loading state
        if (state.status == SearchStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        // Error state
        if (state.status == SearchStatus.failure) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Add this to fix the constraint issue
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48.sp,
                  color: AppColor.darkGrey,
                ),
                SizedBox(height: 16.h),
                Text(
                  state.errorMessage ?? 'Something went wrong',
                  style: AppTextStyles.font16TelegrafBlackRegular,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                ElevatedButton(
                  onPressed: () {
                    if (state.query.isNotEmpty) {
                      context.read<SearchCubit>().searchNews(state.query);
                    }
                  },
                  child:  Text(AppStrings.instance.retry),
                ),
              ],
            ),
          );
        }

        // Success state with empty results
        if (state.status == SearchStatus.success &&
            state.searchResults.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Add this to fix the constraint issue
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off, size: 48.sp, color: AppColor.darkGrey),
                SizedBox(height: 16.h),
                Text(
                  '${AppStrings.instance.noReusltFoundFor}"${state.query}"',
                  style: AppTextStyles.font16TelegrafBlackRegular,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        // Success state with results
        return ListView.builder(
          // Keep shrinkWrap false for better performance
          shrinkWrap: false,
          // Use standard physics for better scrolling
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          itemCount: state.searchResults.length,
          itemBuilder: (context, index) {
            final article = state.searchResults[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: InkWell(
                onTap: () async {

                  await context.read<SearchCubit>().addToHistory(article);
                          context.pushNamed(RouteNames.newsDetails, arguments: article);

                },
                child: Text( article.title??'',style: AppTextStyles.font16TelegrafLightBlackBold,),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInitialState() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            Text(
              AppStrings.instance.popularTopics,
              style: AppTextStyles.font18TelegrafBlackIltraBold,
            ),
            SizedBox(height: 16.h),
            Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: [
                _buildTopicChip('Politics'),
                _buildTopicChip('Technology'),
                _buildTopicChip('Sports'),
                _buildTopicChip('Health'),
                _buildTopicChip('Science'),
                _buildTopicChip('Business'),
                _buildTopicChip('Entertainment'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicChip(String topic) {
    return Builder(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            context.read<SearchCubit>().searchNews(topic);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColor.lightGrey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              getTransString(topic),
              style: TextStyle(
                color: AppColor.darkGrey,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }
}
String getTransString(String text) {
  switch (text) {
    case 'Politics':
      return AppStrings.instance.politics;
    case 'Technology':
      return AppStrings.instance.technology;
    case 'Sports':
      return AppStrings.instance.sports;
    case 'Health':
      return AppStrings.instance.health;
    case 'Science':
      return AppStrings.instance.science;
    case 'Business':
      return AppStrings.instance.business;
    case 'Entertainment':
      return AppStrings.instance.entertainment;
    default:
      return text;
  }
}