import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_xproject/core/theme/app_color.dart';
import 'package:news_xproject/features/search/presentation/widgets/search_bar_widget.dart';
import 'package:news_xproject/features/search/presentation/widgets/search_results_list.dart';
import 'package:news_xproject/features/search/presentation/widgets/search_videos_section.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  
  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      extendBody: true, // Important for floating nav bar
      resizeToAvoidBottomInset: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Non-scrollable content
          SizedBox(height: 30.h),
          SearchBarWidget(),
          SizedBox(height: 20.h),
          const SearchVideosSection(),
          SizedBox(height: 20.h),
          
          // Scrollable content - takes remaining space
          Expanded(
            child: const SearchResultsList(),
          ),
        ],
      ),
    );
  }
}
