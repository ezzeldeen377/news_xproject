import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:news_xproject/core/constants/app_strings.dart';
import 'package:news_xproject/core/theme/app_color.dart';
import 'package:news_xproject/core/theme/app_text_styles.dart';
import 'package:news_xproject/core/widgets/news_item.dart';
import 'package:news_xproject/features/bookmark/presentation/cubit/bookmark_cubit.dart';
import 'package:news_xproject/features/bookmark/presentation/cubit/bookmark_state.dart';
import 'package:news_xproject/features/home_screen/domain/entities/article_entity.dart';

class BookmarkList extends StatelessWidget {
  const BookmarkList({super.key});

  void _deleteBookmark(BuildContext context, ArticleEntity article, int index) {
    // Use the cubit to remove the bookmark
    if (article.url != null) {
      context.read<BookmarkCubit>().removeBookmark(article.url!);
      context.read<BookmarkCubit>().cleanupController(index);
    }
  }

  @override
      Widget build(BuildContext context) {
    // Get the text direction to determine if we're in RTL mode
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    
    // Fetch bookmarks when widget builds for the first time
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<BookmarkCubit>();
      if (cubit.state.status == BookmarkStatus.initial) {
        cubit.getBookmarks();
      }
    });
    
    return BlocBuilder<BookmarkCubit, BookmarkState>(
      builder: (context, state) {
        if (state.status == BookmarkStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == BookmarkStatus.failure) {
          return Center(
            child: Text(
              state.errorMessage ?? AppStrings.instance.failedToLoadBookmarks,
              style: AppTextStyles.font16TelegrafBlackRegular,
            ),
          );
        }

        if (state.bookmarks.isEmpty) {
          return Center(
            child: Text(
              AppStrings.instance.noBookmarksYet,
              style: AppTextStyles.font16TelegrafBlackRegular,
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Text(
                AppStrings.instance.latestBookmarks,
                style: AppTextStyles.font26TelegrafBlackRegular,
              ),
            ),
            SizedBox(height: 10.h),
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.bookmarks.length,
              itemBuilder: (context, index) {
                final article = state.bookmarks[index];
                final cubit = context.read<BookmarkCubit>();
                final isSwiped = state.swipedItems[index] == true;

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Slidable(
                      key: ValueKey(index),
                      // Use startActionPane for RTL and endActionPane for LTR
                      // This ensures the action is always on the right side visually
                      startActionPane: isRTL ? ActionPane(
                        extentRatio: 0.25,
                        motion: const BehindMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_) => _deleteBookmark(context, article, index),
                            backgroundColor: AppColor.lightGrey.withAlpha(10),
                            foregroundColor: AppColor.black,
                            icon: Icons.cancel_outlined,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.r),
                              bottomLeft: Radius.circular(12.r),
                            ),
                          ),
                        ],
                      ) : null,
                      endActionPane: !isRTL ? ActionPane(
                        extentRatio: 0.25,
                        motion: const BehindMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_) => _deleteBookmark(context, article, index),
                            backgroundColor: AppColor.lightGrey.withAlpha(10),
                            foregroundColor: AppColor.black,
                            icon: Icons.cancel_outlined,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12.r),
                              bottomRight: Radius.circular(12.r),
                            ),
                          ),
                        ],
                      ) : null,
                      closeOnScroll: false,
                      // Remove the listener property as it doesn't exist
                      child: NotificationListener<Notification>(
                        onNotification: (notification) {
                          // Track slide ratio changes
                          if (notification is SlidableRatioNotification) {
                            cubit.onSlideChanged(index,.02);
                          }         
                          return false;
                        },
                        child: Container(
                          color: AppColor.lightGrey.withAlpha(10),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            padding: isSwiped
                                ? EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 8.h,
                                  )
                                : EdgeInsets.zero,
                            child: NewsItem(article: article),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
