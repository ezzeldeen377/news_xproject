import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_xproject/core/constants/app_strings.dart';
import 'package:news_xproject/core/theme/app_color.dart';
import 'package:news_xproject/core/theme/app_text_styles.dart';
import 'package:news_xproject/features/search/presentation/cubit/search_cubit.dart';
import 'package:news_xproject/features/search/presentation/cubit/search_state.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        final searchCubit = context.read<SearchCubit>();
        
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Container(
            height: 50.h,
            decoration: BoxDecoration(
              color: AppColor.black,
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: TextField(
              controller: searchCubit.searchController,
              style: AppTextStyles.font14TelegrafWhiteUltraBold,
              onSubmitted: (_) => searchCubit.searchNews(context.read<SearchCubit>().state.query),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                border: InputBorder.none,
                hintText: AppStrings.instance.search,  
                hintStyle: AppTextStyles.font14TelegrafWhiteUltraBold,
                suffixIcon: GestureDetector(
                  onTap: state.hasText 
                      ? () => searchCubit.clearSearch()
                      : () => searchCubit.searchNews(context.read<SearchCubit>().state.query),
                  child: Container(
                    margin: EdgeInsets.all(5.r),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      state.hasText ? Icons.close : Icons.search,
                      color: AppColor.black,
                      size: 20.r,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}