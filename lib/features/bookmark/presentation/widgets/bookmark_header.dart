import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_xproject/core/constants/images_icons.dart';
import 'package:news_xproject/core/constants/app_strings.dart';
import 'package:news_xproject/core/theme/app_color.dart';
import 'package:news_xproject/core/theme/app_text_styles.dart';

class BookmarkHeader extends StatelessWidget implements PreferredSizeWidget  {
  const BookmarkHeader({super.key});

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
       
        actions: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color:AppColor.black,width: 2.r),
            ),
            child: Center(
              child: SvgPicture.asset(
                AppIcons.search,
                width: 20.w,
                height: 20.h,
             color: AppColor.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}