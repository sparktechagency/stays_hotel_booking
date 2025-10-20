import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stays_hotel_booking/app/app_router.dart';
import 'package:stays_hotel_booking/component/button/common_button.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';
import 'package:stays_hotel_booking/features/auth/presentation/provider/forgot_otp_provider.dart';

class ForgotOtpScreen extends ConsumerStatefulWidget {
  const ForgotOtpScreen({super.key});

  @override
  ConsumerState<ForgotOtpScreen> createState() => _ForgotOtpScreenState();
}

class _ForgotOtpScreenState extends ConsumerState<ForgotOtpScreen> {
  late final List<TextEditingController> ctrls;
  late final List<FocusNode> focuses;

  @override
  void initState() {
    super.initState();
    ctrls = List.generate(4, (_) => TextEditingController());
    focuses = List.generate(4, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in ctrls) c.dispose();
    for (final f in focuses) f.dispose();
    super.dispose();
  }

  void onChangedDigit(int index, String value) {
    final clean = value.replaceAll(RegExp(r'[^0-9]'), '');
    final digits = [...ref.read(otpDigitsProvider)];
    digits[index] = clean.isEmpty ? '' : clean.characters.first;
    ref.read(otpDigitsProvider.notifier).state = digits;

    // Reflect back into controller so it always has at most 1 char
    if (ctrls[index].text != digits[index]) {
      ctrls[index].text = digits[index];
      ctrls[index].selection = TextSelection.fromPosition(
        TextPosition(offset: ctrls[index].text.length),
      );
    }

    // Move focus
    if (digits[index].isNotEmpty && index < 3) {
      focuses[index + 1].requestFocus();
    } else if (digits[index].isEmpty && index > 0) {
      focuses[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final resend = ref.watch(resendCountdownProvider);


    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        leading: IconButton(
          onPressed: () => context.push(AppRoutes.forgotPassword),
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: constraints.maxHeight),

                child: IntrinsicHeight(
                  child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                              
                      const CommonText(
                        text: AppStrings.appName,
                        fontSize: 35,
                        fontWeight: FontWeight.w700,
                        color: AppColors.base500,
                      ),
                      SizedBox(height: 16.h),
                              
                      Row(
                        children: const [
                          CommonText(
                            text: 'Enter ',
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: AppColors.text,
                          ),
                          CommonText(
                            text: '4',
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blue,
                          ),
                          CommonText(
                            text: ' digits code',
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: AppColors.text,
                          ),
                        ],
                      ),
                      const CommonText(
                        text: 'Enter the four-digit code that was emailed\nto you.',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: AppColors.subTitle,
                        top: 12,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 24.h),
                              
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(4, (i) {
                          return Padding(
                            padding: EdgeInsets.only(right: i == 3 ? 0 : 20.w),
                            child: SizedBox(
                              width: 60.w,
                              height: 60.h,
                              child: TextFormField(
                                
                                
                                
                                
                                controller: ctrls[i],
                                focusNode: focuses[i],
                                onChanged: (v) => onChangedDigit(i, v),
                                textAlign: TextAlign.center,
                                
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black,
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(1),
                                ],
                                decoration: InputDecoration(
                                  filled: true,                                  hintText:"-",
                                  
                                  fillColor: AppColors.white,
                                  contentPadding: EdgeInsets.zero,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: BorderSide(
                                      color: AppColors.filledColor,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: BorderSide(
                                      color: AppColors.base500,
                                      width: 1.2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                              
                      SizedBox(height: 12.h),
                              
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CommonText(
                            text: 'Resend code in  ',
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: AppColors.subTitle,
                          ),
                          GestureDetector(
                            onTap: resend == 0
                                ? () => ref.read(resendCountdownProvider.notifier).resend()
                                : null,
                            child: CommonText(
                              text: resend == 0 ?'Resend':'${resend}s' ,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: resend == 0 ? AppColors.base500 : AppColors.blue,
                            ),
                          ),
                        ],
                      ),
                              
                      SizedBox(height: 32.h),
                              
               CommonButton(
  titleText: 'Reset Password',
  buttonHeight: 46,
  onTap: () {
  
      context.push(AppRoutes.createNewPassword);

  },
),     
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}