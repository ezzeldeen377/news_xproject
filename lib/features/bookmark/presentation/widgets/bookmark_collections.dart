import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_xproject/core/constants/app_strings.dart';
import 'package:news_xproject/core/helpers/spacer.dart';
import 'package:news_xproject/core/theme/app_color.dart';
import 'package:news_xproject/core/theme/app_text_styles.dart';

class BookmarkCollections extends StatelessWidget {
  const BookmarkCollections({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Text(
           AppStrings.instance.collections,  
            style: AppTextStyles.font36TelegrafBlackUltraBold
          ),
        ),
        verticalSpace(20),
        SizedBox(
          height: 120.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            children: [
              _buildCollectionItem(
                AppStrings.instance.sports, 
                'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'
              ),
              _buildCollectionItem(
                AppStrings.instance.tech, 
                'https://images.unsplash.com/photo-1518770660439-4636190af475?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'
              ),
              _buildCollectionItem(
                AppStrings.instance.health, 
                'https://images.unsplash.com/photo-1505576399279-565b52d4ac71?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCollectionItem(String title, String imageUrl) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Container(
        width: 120.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
            // Add placeholder and error handling
            onError: (exception, stackTrace) => const AssetImage('assets/images/placeholder.jpg'),
          ),
        ),
        child: Stack(
          children: [
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            // Category text
            Center(
              child: Text(
                title,
                style: AppTextStyles.font12TelegrafWhiteUltraBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
