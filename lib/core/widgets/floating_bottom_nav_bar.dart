import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_xproject/core/constants/images_icons.dart';
import 'package:news_xproject/core/theme/app_color.dart';

class FloatingBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const FloatingBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 44.w,
        right: 44.w,
        bottom: 30.h,
      ),
      child: Container(
        height: 56.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, AppIcons.home),
            _buildNavItem(1, AppIcons.bookmarkNav),
            _buildNavItem(2, AppIcons.search),
            _buildNavItem(3, AppIcons.notifications),
            _buildNavItem(4, AppIcons.settings),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String iconPath) {
    final bool isSelected = index == currentIndex;
    
    return InkWell(
      onTap: () {
        onTap(index);
        
        
      },
      child: Center(
        child: SvgPicture.asset(
          iconPath,
          width: 24.w,
          height: 24.h,
          colorFilter: ColorFilter.mode(
            AppColor.darkGrey.withAlpha(isSelected ? 255 : 100),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}