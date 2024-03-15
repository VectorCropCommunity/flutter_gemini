import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wa_bot/app/data/theme.dart';
import 'package:wa_bot/app/data/themeController.dart';

import 'app/routes/app_pages.dart';

void main() {
  ThemeController themeController = Get.put(ThemeController());

  runApp(Obx(
    () => GetMaterialApp(
      title: "Bot",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: themeController.isDarkMode ? darkTheme : lightTheme,
    ),
  ));
}
