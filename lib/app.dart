import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stays_hotel_booking/app/app_router.dart';
import 'package:stays_hotel_booking/app/theme/light_theme.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return ScreenUtilInit(
      designSize: const Size(430, 932),
      ensureScreenSize: true,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => MaterialApp.router(
        debugShowCheckedModeBanner: false,

        routerConfig: AppRoutes.router,
        theme: themeData,
      ),
    );
  }
}
