import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_xproject/core/constants/app_strings.dart';
import 'package:news_xproject/core/theme/app_color.dart';
import 'package:news_xproject/core/theme/app_text_styles.dart';
import 'package:news_xproject/features/settings/presentation/cubit/language_cubit.dart';
import 'package:news_xproject/features/settings/presentation/cubit/language_state.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    
    return InkWell(
      onTap: () {
        _showLanguageBottomSheet(context);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: AppColor.lightGrey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.language,
                color: AppColor.black,
                size: 20.r,
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                  AppStrings.instance.language,  
style: AppTextStyles.font16TelegrafLightBlackBold.copyWith(
                      fontWeight: FontWeight.w600,
                    ),                  ),
                  BlocBuilder<LanguageCubit, LanguageState>(
                    builder: (context, state) {
                      return Text(
                        state.locale.languageCode == 'en' ? 'English' : 'العربية',
                        style: AppTextStyles.font12TelegrafDarkGrayRegular
                      );
                    },
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColor.grey,
              size: 16.r,
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageBottomSheet(BuildContext context) {
    final languageCubit = context.read<LanguageCubit>();
    
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
AppStrings.instance.selectLanguage,                        style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              const Divider(),
              _buildLanguageOption(
                context,
                'English',
                'en',
                languageCubit,
              ),
              _buildLanguageOption(
                context,
                'العربية',
                'ar',
                languageCubit,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    String languageName,
    String languageCode,
    LanguageCubit languageCubit,
  ) {
    final isSelected = languageCubit.isCurrentLanguage(languageCode);
    
    return InkWell(
      onTap: () {
        languageCubit.changeLanguage(languageCode);
        print('languageCode: $languageCode');
        Navigator.pop(context);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              languageName,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? AppColor.primary : AppColor.black,
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppColor.primary,
                size: 20.r,
              ),
          ],
        ),
      ),
    );
  }
}