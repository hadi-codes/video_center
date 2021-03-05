import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:gui/theme/theme.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils.dart';

class Utils {
  static void launchEmail(String email) async {
    logger.i('Lunching URL $email');
    final Uri uri = Uri(
      path: email,
      scheme: 'mailto',
    );
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      logger.e('Could\'nt launch to email $email');
    }
  }

  static void launchPhone(String phoneNumber) async {
    final Uri uri = Uri(
      path: phoneNumber,
      scheme: 'tel',
    );
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      logger.e('Could\'nt launch to phone $phoneNumber');
    }
  }

  static void showErrorSnackbar(String message) {
    if (Get.isSnackbarOpen) Get.back();

    Get.snackbar('Error', message,
        maxWidth: 400,
        snackStyle: SnackStyle.GROUNDED,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP);
  }

  static void showInfoSnackbar(String message) {
    if (Get.isSnackbarOpen) Get.back();
    Get.rawSnackbar(
        messageText: Text(message),
        snackStyle: SnackStyle.GROUNDED,
        //backgroundColor: AppTheme.darkYellow,
        snackPosition: SnackPosition.BOTTOM);
  }

  static void showLoadingSnackbar(String message) {
    if (Get.isSnackbarOpen) Get.back();
    Get.rawSnackbar(
        message: message,
        snackStyle: SnackStyle.GROUNDED,
        backgroundColor: Colors.black,
        showProgressIndicator: true,
        snackPosition: SnackPosition.BOTTOM);
  }

  static void showSuccessSnackbar(String message) {
    if (Get.isSnackbarOpen) Get.back();
    Get.snackbar('Success', message,
        maxWidth: 400,
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP);
  }

  static void showSuccessDialog(
      String title, String body, void Function() onPressed) {
    Get.dialog(WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        title: Text('Submitting new task'),
        content: Container(
            height: 100.h,
            child: Center(
              child: Text('Task submitted successfully'),
            )),
        actions: [TextButton(onPressed: onPressed, child: Text('ok'))],
      ),
    ));
  }

  static bool isNull(dynamic value) => value == null;
  static bool _hasIsEmpty(dynamic value) {
    return value is Iterable || value is String || value is Map;
  }

  static bool isNullOrBlank(dynamic value) {
    if (isNull(value)) {
      return true;
    }

    if (value is String) {
      return value.toString().trim().isEmpty;
    }

    return _hasIsEmpty(value) ? value.isEmpty as bool : false;
  }
}

extension DynamicUtils on dynamic {
  bool get isNull => Utils.isNull(this);

  bool get isNullOrBlank => Utils.isNullOrBlank(this);
}
