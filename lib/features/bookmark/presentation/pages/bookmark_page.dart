import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_xproject/core/helpers/spacer.dart';
import 'package:news_xproject/core/theme/app_color.dart';
import 'package:news_xproject/features/bookmark/presentation/widgets/bookmark_collections.dart';
import 'package:news_xproject/features/bookmark/presentation/widgets/bookmark_list.dart';
import 'package:news_xproject/features/bookmark/presentation/widgets/bookmark_header.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  createState() => _BookmarkPage();
}

class _BookmarkPage extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      extendBody: true, // Important for floating nav bar

      appBar: const BookmarkHeader(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(24),
            const BookmarkCollections(),
            verticalSpace(32),
            const BookmarkList(),
                        verticalSpace(80),
      
          ],
        ),
      ),
    );
  }
}
