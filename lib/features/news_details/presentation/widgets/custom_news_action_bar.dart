import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_xproject/core/constants/app_strings.dart';
import 'package:news_xproject/core/constants/images_icons.dart';
import 'package:news_xproject/core/theme/app_color.dart';
import 'package:news_xproject/features/home_screen/domain/entities/article_entity.dart';
import 'package:news_xproject/features/news_details/presentation/cubit/news_details_cubit.dart';
import 'package:news_xproject/features/news_details/presentation/cubit/news_details_state.dart';
import 'package:share_plus/share_plus.dart';

class CustomNewsActionBar extends StatelessWidget {
  const CustomNewsActionBar({super.key, required this.article});

  final ArticleEntity article;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 30.h),
        child: Container(
          height: 56.h,
          width: 193.w,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton(
                icon: AppIcons.commentNav,
                onPressed: () {
                  // TODO: Implement comment functionality
                },
              ),
              BlocBuilder<NewsDetailsCubit, NewsDetailsState>(
                builder: (context, state) {
                  return _buildActionButton(
                    icon: AppIcons.bookmarkNav,
                    onPressed: () {
                      context.read<NewsDetailsCubit>().toggleBookmark(article);
                    },
                    isSelected: context.read<NewsDetailsCubit>().checkBookmarkStatus(article.url?? ""),
                  );
                },
              ),
              _buildActionButton(
                icon: AppIcons.shareNav,
                onPressed: () => _showShareOptions(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showShareOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder:
          (context) => Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.instance.shareVia,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildShareOption(
                      context,
                      icon: Icons.copy,
                      label: AppStrings.instance.copyLink,
                      onTap: () async {
                        await Clipboard.setData(
                          ClipboardData(text: article.url ?? ""),
                        );
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(AppStrings.instance.linkCopied),
                          ),
                        );
                      },
                    ),
                    _buildShareOption(
                      context,
                      icon: Icons.call,
                      label: AppStrings.instance.whatsApp,
                      onTap: () {
                        Navigator.pop(context);
                        SharePlus.instance.share(
                          ShareParams(
                            uri: Uri.parse('https://example.com/news'),
                          ),
                        );
                      },
                    ),
                    _buildShareOption(
                      context,
                      icon: Icons.share,
                      label: AppStrings.instance.more,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildShareOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50.r,
            height: 50.r,
            decoration: BoxDecoration(
              color: AppColor.lightGrey.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColor.black, size: 24.r),
          ),
          SizedBox(height: 8.h),
          Text(label, style: TextStyle(fontSize: 12.sp)),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String icon,
    required VoidCallback onPressed,
    Color color = AppColor.darkGrey,
    bool isSelected = false,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SvgPicture.asset(
          icon,
          width: 24.w,
          height: 24.h,
          colorFilter: ColorFilter.mode(
            isSelected ? Colors.red : color,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
