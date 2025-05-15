import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_xproject/core/theme/app_color.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: AppColor.black,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Center(
              child: Icon(
                Icons.menu,
                color: Colors.white,
                size: 20.r,
              ),
            ),
          ),
          CircleAvatar(
            radius: 20.r,
            backgroundImage: const NetworkImage(
              'https://s3.amazonaws.com/37assets/svn/765-default-avatar.png',
            ),
          ),
        ],
      ),
    );
  }
}