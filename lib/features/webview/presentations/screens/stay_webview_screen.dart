import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stays_hotel_booking/app/app_router.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

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




   
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            if (url.contains('/payment/success')) {
              if (!mounted) return;
              context.go(AppRoutes.registration);
            }
            setState(() => _isLoading = true);
          },
          onPageFinished: (_) {
            if (mounted) setState(() => _isLoading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse('https://stays-app.com'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        actions: [
          InkWell(
            onTap: () {
              if (!mounted) return;
              context.go(AppRoutes.registration);
            },
            child: CommonText(
              color: AppColors.white,
              right: 20,
              text: "Skip", fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],

        title: const CommonText(
          color: AppColors.white,
          text: "Stays", fontSize: 24, fontWeight: FontWeight.w600),
      ),
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