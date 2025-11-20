import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stays_hotel_booking/app/app_router.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class StaysWebViewScreen extends StatefulWidget {
  const StaysWebViewScreen({super.key});

  @override
  State<StaysWebViewScreen> createState() => _StaysWebViewScreenState();
}

class _StaysWebViewScreenState extends State<StaysWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();




   
    // _controller = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(Colors.white)
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onPageStarted: (url) {
    //         if (url.contains('/payment/success')) {
    //           if (!mounted) return;
    //           context.go(AppRoutes.signIn);
    //         }
    //         setState(() => _isLoading = true);
    //       },
    //       onPageFinished: (_) {
    //         if (mounted) setState(() => _isLoading = false);
    //       },
    //     ),
    //   )
    //   ..loadRequest(Uri.parse('https://stays-app.com'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(child: WebViewWidget(controller: _controller)),
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      context.go(AppRoutes.registration);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration:  BoxDecoration(
          color: AppColors.bg ),
        child: const Center(
          child: CommonText(
            text: AppStrings.appName,
            fontSize: 48,
            fontWeight: FontWeight.w800,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}