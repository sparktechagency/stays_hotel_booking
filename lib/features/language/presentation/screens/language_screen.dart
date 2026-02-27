import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';
import 'package:stays_hotel_booking/features/language/domain/models/language_model.dart';
import 'package:stays_hotel_booking/features/language/presentation/providers/language_provider.dart';

class LanguageScreen extends ConsumerStatefulWidget {
  const LanguageScreen({super.key});

  @override
  ConsumerState<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends ConsumerState<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(languageNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          backgroundColor: AppColors.bg,
          elevation: 0,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),
            
            // Content
            Expanded(
              child: _buildContent(state),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.text,
              size: 20,
            ),
          ),
          SizedBox(width: 16.w),
          const Expanded(
            child: CommonText(
              text: AppStrings.language,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.text,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(LanguageState state) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.base500,
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: state.languages.length,
      itemBuilder: (context, index) {
        final language = state.languages[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: _buildLanguageCard(language),
        );
      },
    );
  }

  Widget _buildLanguageCard(LanguageModel language) {
    return GestureDetector(
      onTap: () {
        ref.read(languageNotifierProvider.notifier).selectLanguage(language.id);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color:  language.isSelected?AppColors.overlayBox:AppColors.transparent,
          borderRadius: BorderRadius.circular(12.r),

          border: Border.all(color:language.isSelected? AppColors.transparent:AppColors.strokeColor),
        
    ),
        child: Row(
          children: [
            // Flag emoji
         Center(
                child: CommonText(
                  text: language.flagEmoji,
                  fontSize: 20,
                ),
              ),
     
            
            SizedBox(width: 16.w),
            
            // Language name
        
             CommonText(
                text: language.name,
                fontSize: 16,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w500,
                color:language.isSelected? AppColors.text:AppColors.subTitle,
              ),
              Spacer(),
        
            
            // Radio button
            Container(
              width: 20.w,
              height: 20.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.40),
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],


                border: Border.all(
                  color: language.isSelected ? AppColors.base500 : AppColors.subTitle,
                  width: 2,
                ),
                color: language.isSelected ? AppColors.black : Colors.transparent,
              ),
              child: language.isSelected
                  ? Center(
                      child: Container(
                        width: 10.w,
                        height: 10.h,
                        decoration:  BoxDecoration(
                          shape: BoxShape.circle,
                          color:language.isSelected ? AppColors.base500:AppColors.transparent,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
