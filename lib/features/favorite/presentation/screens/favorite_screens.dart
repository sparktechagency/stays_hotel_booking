import 'package:flutter/material.dart';
import 'package:stays_hotel_booking/component/bottomNav/common_bottom_nav_bar.dart';

class FavoriteScreens extends StatefulWidget {
  const FavoriteScreens({super.key});

  @override
  State<FavoriteScreens> createState() => _FavoriteScreensState();
}

class _FavoriteScreensState extends State<FavoriteScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
      ),
      body: const Center(
        child: Text('Favorite Screen'),
      ),

      bottomNavigationBar: CommonBottomNavBar(currentIndex: 2),
    );
  }
}