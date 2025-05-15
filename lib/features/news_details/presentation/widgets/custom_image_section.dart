import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_xproject/core/helpers/nav_extension.dart';
import 'package:news_xproject/features/settings/presentation/cubit/language_cubit.dart';

class CustomImageSection extends StatelessWidget {
  final String imageUrl;


  const CustomImageSection({
    super.key,
    required this.imageUrl,
    
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Featured Image
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32.r),
            bottomRight: Radius.circular(32.r),
          ),
          child: SizedBox(
            height: 375.h,
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey[300],
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.error, color: Colors.red),
              ),
            ),
          ),
        ),
        
        // Gradient overlay
    
        
        // Back button
        Positioned(
          top: 40.h,
          left:context.read<LanguageCubit>().state.locale.languageCode=='en'? 25.w:null,
          right:context.read<LanguageCubit>().state.locale.languageCode=='ar'? 25.w:null,
          child: GestureDetector(
            onTap: ()=>context.pop(),
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_back, color: Colors.white)
            ),
          ),
        ),
        
        // Category and date
       
        
      ],
    );
  }
}