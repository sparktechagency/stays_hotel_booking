import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stays_hotel_booking/app/app_router.dart';
import 'package:stays_hotel_booking/component/button/common_button.dart';
import 'package:stays_hotel_booking/component/image/common_image.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_images.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';
import 'package:stays_hotel_booking/core/utils/extensions/extension.dart';
import 'package:stays_hotel_booking/features/subscription/domain/plan.dart';
import 'package:stays_hotel_booking/features/subscription/presentation/provider/subscription_providers.dart';

class SubscriptionScreen extends ConsumerWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plans = ref.watch(plansProvider);
    final controller = ref.watch(pageControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 24.w,
            color: AppColors.black,
          ),
        ),
        backgroundColor: const Color(0xFFFDFBFB),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const CommonText(
          text: AppStrings.subscriptionTitle,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
        ),
      ),
      backgroundColor: const Color(0xFFFDFBFB),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.center,
            end: Alignment.center,
            colors: [
              Color(0xFFFDFBFB),
              Color(0xFFFFFFFF),
              Color(0xFFF4F4F4),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: plans.length,
                onPageChanged: (i) =>
                    ref.read(currentPlanIndexProvider.notifier).state = i,
                itemBuilder: (context, index) {
                  final plan = plans[index];
                  return Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 10.w,
                      ),
                      child: _PlanCard(plan: plan),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({required this.plan});
  final Plan plan;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.16),
            blurRadius: 6,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              text: plan.title,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.text,
              bottom: 20,
              textAlign: TextAlign.center,
            ).center,

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CommonText(
                  text: plan.priceLabel,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: AppColors.base500,
                  right: 6,
                  textAlign: TextAlign.center,
                ),
                 CommonText(
                  text: AppStrings.subscriptionUnitMonthly, // or AppStrings.subscriptionUnitYearly
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.text,
                  textAlign: TextAlign.left,
                ),
              ],
            ),

            SizedBox(height: 16.h),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonImage(
                  imageSrc: AppImages.perfectFor,
                  width: 18.w,
                  height: 18.h,
                ),
                const CommonText(
                  left: 5,
                  text: AppStrings.subscriptionPerfectFor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.text,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            12.height,
            ...plan.perfectFor.map(
              (e) => _BulletRow(text: e, color: AppColors.black),
            ),

            SizedBox(height: 16.h),

            Row(
              children: [
                CommonImage(
                  imageSrc: AppImages.features,
                  width: 18.w,
                  height: 18.h,
                ),
                const CommonText(
                  left: 5,
                  text: AppStrings.subscriptionFeatures,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.text,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            12.height,
            ...plan.features.map(
              (e) => _BulletRow(text: e, color: AppColors.black),
            ),

            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.0.w),
              child: CommonButton(
                
                titleText: AppStrings.subscriptionBuyNow,
                buttonHeight: 42,
                onTap: () {
                 context.push(AppRoutes.signInOrRegister);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BulletRow extends StatelessWidget {
  const _BulletRow({required this.text, required this.color});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 5.h,
            width: 5.h,
            margin: EdgeInsets.only(top: 8.h),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: CommonText(
              text: text,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.subTitle,
              textAlign: TextAlign.left,
              maxLines: 6,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}