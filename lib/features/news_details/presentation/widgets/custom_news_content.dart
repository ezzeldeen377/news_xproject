import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_xproject/core/constants/images_icons.dart';
import 'package:news_xproject/core/helpers/spacer.dart';
import 'package:news_xproject/core/theme/app_color.dart';
import 'package:news_xproject/core/theme/app_text_styles.dart';

class CustomNewsContent extends StatelessWidget {
  final String authorName;
  final String authorImageUrl;
  final String category;
  final String date;
  final String title;
  final String content;

  const CustomNewsContent({
    super.key,
    required this.authorName,
    required this.authorImageUrl,
    required this.category,
    required this.date,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author info and date
          _buildAuthorSection(),
          verticalSpace(32),
          Text(
            category.toUpperCase(),
            style: AppTextStyles.font12TelegrafDarkGrayUltraBold,
          ),
          verticalSpace(14),

          Text(title, style: AppTextStyles.font22TelegrafBlackUltraBold),
          verticalSpace(16),
          Text(date, style: AppTextStyles.font12TelegrafDarkGrayRegular),
          verticalSpace(24),
          Divider(color: AppColor.lightGrey.withAlpha(20), thickness: 2.h),
          verticalSpace(24),

          // Content
          Text(content, style: AppTextStyles.font16TelegrafBlackRegular),

          // Bottom spacing for the action bar
          verticalSpace(100.h),
        ],
      ),
    );
  }

  Widget _buildAuthorSection() {
    return Row(
      children: [
        // Author image
        CircleAvatar(
          radius: 20.r,
          backgroundImage: NetworkImage(authorImageUrl),
        ),
        horizontalSpace(12.w),

        // Author name with overflow handling
        Expanded(
          child: Text(
            authorName,
            style: AppTextStyles.font14TelegrafBlackRegular,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
