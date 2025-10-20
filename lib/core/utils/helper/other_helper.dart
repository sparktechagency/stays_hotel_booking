import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';

class OtherHelper {
  static RegExp emailRegexp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );
  static RegExp passRegExp = RegExp(r'(?=.*[a-z])(?=.*[0-9])');

  static String? validator(value) {
    if (value.isEmpty) {
      return AppStrings.thisFieldIsRequired;
    }
    return null;
  }

  static String? emailValidator(value) {
    if (value == null || value.isEmpty) {
      return AppStrings.thisFieldIsRequired;
    } else if (!emailRegexp.hasMatch(value)) {
      return AppStrings.enterValidEmail;
    }
    return null;
  }

  static String? passwordValidator(value) {
    if (value == null || value.isEmpty) {
      return AppStrings.thisFieldIsRequired;
    } else if (value.length < 8) {
      return AppStrings.passwordMustBeeEightCharacters;
    } else if (!passRegExp.hasMatch(value)) {
      return AppStrings.passwordMustBeeEightCharacters;
    }
    return null;
  }

  static String? confirmPasswordValidator(
    value,
    TextEditingController passwordController,
  ) {
    if (value == null || value.isEmpty) {
      return AppStrings.thisFieldIsRequired;
    } else if (value != passwordController.text) {
      return AppStrings.thePasswordDoesNotMatch;
    }
    return null;
  }


  static Future<String?> openGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    return image?.path;
  }

  static Future<String?> openGalleryForProfile() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      );

      return croppedFile?.path;
    }
    return null;
  }

  static Future<String?> pickVideoFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
    return video?.path;
  }

  static Future<String?> openCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    return image?.path;
  }

 
  static String formatTime(TimeOfDay time) {
    return "${time.hour > 12 ? (time.hour - 12).toString().padLeft(2, '0') : (time.hour == 0 ? 12 : time.hour).toString().padLeft(2, '0')}:"
        "${time.minute.toString().padLeft(2, '0')} ${time.hour >= 12 ? "PM" : "AM"}";
  }
}
