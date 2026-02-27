import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';
import 'package:stays_hotel_booking/features/faq/domain/models/faq_model.dart';
import 'package:stays_hotel_booking/features/faq/presentation/providers/faq_provider.dart';

class FaqScreen extends ConsumerStatefulWidget {
  const FaqScreen({super.key});

  @override
  ConsumerState<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends ConsumerState<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(faqNotifierProvider);

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
              text: AppStrings.faq,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.text,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(FaqState state) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.base500,
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: state.faqItems.length,
      itemBuilder: (context, index) {
        final faqItem = state.faqItems[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: _buildFaqCard(faqItem),
        );
      },
    );
  }

  Widget _buildFaqCard(FaqModel faqItem) {
    return GestureDetector(
      onTap: () {
        ref.read(faqNotifierProvider.notifier).toggleFaqItem(faqItem.id);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.overlayBox,
          borderRadius: BorderRadius.circular(12.r),
         // border: Border.all(color: AppColors.strokeColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.40),
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question row
            Row(
              children: [
                // Question text
                Expanded(
                  child: CommonText(
                    text: faqItem.question,
                    fontSize: 14,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w500,
                    color: AppColors.text,
                  ),
                ),
                
                SizedBox(width: 12.w),
                
                // Expand/collapse icon
                Container(
                  width: 24.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                   // shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(4.r),
                    border: Border.all(
                      color: AppColors.subTitle,
                      width: 1,
                    ),
                    color: AppColors.black,
                  ),
                  child: Center(
                    child: Icon(
                      faqItem.isExpanded ? Icons.remove : Icons.add,
                      color: AppColors.subTitle,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
            
            // Answer (only if expanded)
            if (faqItem.isExpanded) ...[
              SizedBox(height: 12.h),
              CommonText(
                text: faqItem.answer,
                fontSize: 14,
                maxLines: 5,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w400,
                color: AppColors.subTitle,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
