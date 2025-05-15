import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_xproject/core/constants/app_strings.dart';
import 'package:news_xproject/core/helpers/spacer.dart';
import 'package:news_xproject/core/theme/app_color.dart';
import 'package:news_xproject/core/theme/app_text_styles.dart';
import 'package:news_xproject/features/settings/presentation/cubit/language_cubit.dart';
import 'package:news_xproject/features/settings/presentation/cubit/language_state.dart';
import 'package:news_xproject/features/settings/presentation/widgets/language_selector.dart';
import 'package:news_xproject/features/settings/presentation/widgets/settings_header.dart';
import 'package:news_xproject/features/settings/presentation/widgets/settings_item.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SettingsHeader(),
                  verticalSpace(20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      AppStrings.instance.settings,
                      style: AppTextStyles.font26TelegrafBlackRegular,
                    ),
                  ),
                  verticalSpace(30),

                  // Account Section
                  _buildSectionTitle(AppStrings.instance.account),
                  SettingsItem(
                    icon: Icons.person_outline,
                    title: AppStrings.instance.profile,
                    onTap: () {},
                  ),
                  SettingsItem(
                    icon: Icons.notifications_none_outlined,
                    title: AppStrings.instance.notifications,
                    isSwitch: true,
                    switchValue: _notificationsEnabled,
                    onSwitchChanged: (value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                  ),

                  SizedBox(height: 20.h),

                  // App Settings Section
                  _buildSectionTitle(AppStrings.instance.appSettings),
                  LanguageSelector(),
                  SettingsItem(
                    icon: Icons.color_lens_outlined,
                    title: AppStrings.instance.appearance,
                    subtitle: AppStrings.instance.light,
                    onTap: () {},
                  ),

                  SizedBox(height: 20.h),

                  // Other Section
                  _buildSectionTitle(AppStrings.instance.other),
                  SettingsItem(
                    icon: Icons.info_outline,
                    title: AppStrings.instance.about,
                    onTap: () {},
                  ),
                  SettingsItem(
                    icon: Icons.help_outline,
                    title: AppStrings.instance.helpAndSupport,
                    onTap: () {},
                  ),
                  SettingsItem(
                    icon: Icons.logout,
                    title: AppStrings.instance.logout,
                    titleColor: Colors.red,
                    onTap: () {},
                  ),

                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Text(title, style: AppTextStyles.font14TelegrafBlackRegular),
    );
  }
}
