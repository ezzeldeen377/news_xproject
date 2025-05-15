import 'package:flutter/material.dart';
import 'package:news_xproject/core/helpers/spacer.dart';
import 'package:news_xproject/core/theme/app_color.dart';
import 'package:news_xproject/core/widgets/floating_bottom_nav_bar.dart';
import 'package:news_xproject/features/home_screen/presentation/widgets/custom_app_bar.dart';
import 'package:news_xproject/features/home_screen/presentation/widgets/custom_slider_news.dart';
import 'package:news_xproject/features/home_screen/presentation/widgets/custom_last_news.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColor.white,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             CustomSliderNews(),
            const CustomLastNews(),
            // Add extra space at the bottom for the floating nav bar
            verticalSpace(80),
          ],
        ),
      ),
      extendBody: true, // Important for floating nav bar
     
    );
  }
}