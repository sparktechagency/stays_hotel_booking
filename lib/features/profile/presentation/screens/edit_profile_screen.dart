import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stays_hotel_booking/component/button/common_button.dart';
import 'package:stays_hotel_booking/component/image/common_image.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/component/text_field/common_text_field.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_images.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';
import 'package:stays_hotel_booking/core/utils/extensions/extension.dart';
import 'package:stays_hotel_booking/features/profile/presentation/providers/personal_info_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(personalInfoNotifierProvider);
    _nameController = TextEditingController(text: state.fullName);
    _emailController = TextEditingController(text: state.email);
    _addressController = TextEditingController(text: state.address);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(personalInfoNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          backgroundColor: AppColors.bg,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              8.height,
              Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(Icons.arrow_back_ios, color: AppColors.text, size: 20),
                  ),
                  16.width,
                  const Expanded(
                    child: CommonText(
                      text: 'Edit Profile',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.text,
                    ),
                  ),
                ],
              ),
              24.height,

              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                    //  padding: EdgeInsets.all(3),

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.black400, width: 3)
                        ),
                        child: ClipOval(child: _ProfileImage(path: state.user.profileImageUrl))),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: InkWell(
                        onTap: _pickImage,
                        borderRadius: BorderRadius.circular(999),
                        child: Container(
                          height: 24.h,
                          width: 24.h,
                          decoration:  BoxDecoration(
                            color: AppColors.black400,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.camera_enhance_outlined, color: Colors.yellow, size: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              24.height,

              _label(AppStrings.fullName),
              8.height,
              CommonTextField(

                controller: _nameController,
                hintText: AppStrings.fullName,
                borderColor: AppColors.black,
                hintTextColor: AppColors.subTitle,
                fillColor: AppColors.overlayBox,
                borderRadius: 8,
                onChanged: (v) => ref.read(personalInfoNotifierProvider.notifier).updateFullName(v),
              ),

              20.height,

              _label(AppStrings.email),
              8.height,
              CommonTextField(
                controller: _emailController,
                hintText: AppStrings.email,
                borderColor: AppColors.black,
                hintTextColor: AppColors.subTitle,
                fillColor: AppColors.overlayBox,
                borderRadius: 8,
                keyboardType: TextInputType.emailAddress,
                onChanged: (v) => ref.read(personalInfoNotifierProvider.notifier).updateEmail(v),
              ),

              20.height,

              _label(AppStrings.address),
              8.height,
              CommonTextField(
                controller: _addressController,
                hintText: AppStrings.address,
                borderColor: AppColors.black,
                hintTextColor: AppColors.subTitle,
                fillColor: AppColors.overlayBox,
                borderRadius: 8,
                onChanged: (v) => ref.read(personalInfoNotifierProvider.notifier).updateAddress(v),
              ),

              150.height,

              CommonButton(
                titleText: 'Save & Continue',
                buttonHeight: 50,
                isLoading: state.isLoading,
                onTap: () async {
                  ref.read(personalInfoNotifierProvider.notifier).saveProfile();
                  await Future.delayed(const Duration(milliseconds: 1200));
                  if (mounted) context.pop();
                },
              ),
              16.height,
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => CommonText(
        text: text,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.text,
      );

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (file != null) {
     // ref.read(personalInfoNotifierProvider.notifier).updateProfileImage(file.path);
      if (mounted) setState(() {});
    }
  }
}

class _ProfileImage extends StatelessWidget {
  final String path;
  const _ProfileImage({required this.path});

  @override
  Widget build(BuildContext context) {
    final double w = 88.w;
    final double h = 88.h;
    if (path.isNotEmpty && !path.startsWith('assets/')) {
      return Image.file(
        File(path),
        width: w,
        height: h,
        fit: BoxFit.cover,
      );
    }
    return CommonImage(
      imageSrc: path.isNotEmpty ? path : AppImages.profile,
      width: w,
      height: h,
      fill: BoxFit.cover,
    );
  }
}