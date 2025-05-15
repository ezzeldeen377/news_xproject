import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_xproject/core/theme/app_color.dart';

class AppTextStyles {
  // Title styles
  static TextStyle font16TelegrafLightBlackBold = TextStyle(
    fontFamily: 'telegraf',
    color: AppColor.lightBlack,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font16TelegrafLightBlackLight = TextStyle(
    fontFamily: 'telegraf',
    color: AppColor.lightBlack,
    fontSize: 16.sp,
    fontWeight: FontWeight.w200,
  );
  static TextStyle font12TelegrafWhiteUltraBold = TextStyle(
    fontFamily: 'telegraf',
    color: AppColor.white,
    fontSize: 12.sp,
    fontWeight: FontWeight.w900,
  );
  static TextStyle font18TelegrafWhiteUltraBold = TextStyle(
    fontFamily: 'telegraf',
    color: AppColor.white,
    fontSize: 18.sp,
    fontWeight: FontWeight.w900,
  );
  static TextStyle font8TelegrafWhiteRegular = TextStyle(
    fontFamily: 'telegraf',
    color: AppColor.white,
    fontSize: 8.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle font16TelegrafWhiteRegular = TextStyle(
    fontFamily: 'telegraf',
    color: AppColor.white,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle font16TelegrafBlackRegular = TextStyle(
    fontFamily: 'telegraf',
    color: AppColor.black,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );
  
  // Add these styles if they don't exist
  static TextStyle font14TelegrafDarkGrayRegular = TextStyle(
    fontFamily: 'PPTelegraf',
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColor.darkGrey.withAlpha(122),
  );
  static TextStyle font12TelegrafDarkGrayRegular = TextStyle(
    fontFamily: 'PPTelegraf',
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColor.darkGrey.withAlpha(122),
  );
  static TextStyle font12TelegrafDarkGrayUltraBold = TextStyle(
    fontFamily: 'PPTelegraf',
    fontSize: 12.sp,
    fontWeight: FontWeight.w900,
    color: AppColor.darkGrey.withAlpha(122),
  );
  static TextStyle font14TelegrafWhiteUltraBold = TextStyle(
    fontFamily: 'PPTelegraf',
    fontSize: 14.sp,
    fontWeight: FontWeight.w900,
    color: AppColor.white,
  );
  
  static TextStyle font12TelegrafDarkGreyUltraBold = TextStyle(
    fontFamily: 'PPTelegraf',
    fontSize: 12.sp,
    fontWeight: FontWeight.w900,
    color: AppColor.darkGrey.withAlpha(122),
  );
  
  static TextStyle font18TelegrafBlackIltraBold = TextStyle(
    fontFamily: 'PPTelegraf',
    fontSize: 18.sp,
    fontWeight: FontWeight.w900,
    color: AppColor.black,
  );
  static TextStyle font14TelegrafBlackRegular = TextStyle(
    fontFamily: 'PPTelegraf',
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColor.black,
  );
  static TextStyle font22TelegrafBlackUltraBold = TextStyle(
    fontFamily: 'PPTelegraf',
    fontSize: 22.sp,
    fontWeight: FontWeight.w900,
    color: AppColor.black,
  );
  static TextStyle font36TelegrafBlackUltraBold = TextStyle(
    fontFamily: 'PPTelegraf',
    fontSize: 36.sp,
    fontWeight: FontWeight.w900,
    color: AppColor.black,
  );
  static TextStyle font26TelegrafBlackRegular = TextStyle(
    fontFamily: 'PPTelegraf',
    fontSize: 26.sp,
    fontWeight: FontWeight.w400,
    color: AppColor.black,
  );
}