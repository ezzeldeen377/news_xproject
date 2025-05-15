import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_xproject/core/constants/images_icons.dart';
import 'package:news_xproject/core/constants/app_strings.dart';
import 'package:news_xproject/core/theme/app_color.dart';
import 'package:news_xproject/core/theme/app_text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget  {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w,),
      child: AppBar(
        surfaceTintColor: AppColor.white,
        backgroundColor: AppColor.white ,
        leading: Container(
          margin: EdgeInsets.all( 5.r),
          decoration: BoxDecoration(
            color: AppColor.black,
            shape: BoxShape.circle,
          ),
            padding:  EdgeInsets.symmetric(horizontal: 12.w,vertical: 16.h),
          child: SvgPicture.asset(
            AppIcons.menu,
            width: 10.w, // Increased width for better visibility
            height: 10.h, // Increased height for better visibility
          ),
        ),
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: AppStrings.instance.news,
                style: AppTextStyles.font16TelegrafLightBlackBold,
              ),
              TextSpan(
                text: AppStrings.instance.app,
                style: AppTextStyles.font16TelegrafLightBlackLight,
              ),
            ],
          ),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColor.black,
                width: 2.w,
              ),
              color: AppColor.white,
              shape: BoxShape.circle,
            ),
            padding:  EdgeInsets.symmetric(horizontal: 13.w,vertical: 11.h),
            child: SvgPicture.asset(AppIcons.mic,width: 14.w,height: 18.h,),
          ),
        ],
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}