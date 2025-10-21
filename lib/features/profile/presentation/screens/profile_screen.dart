import 'package:flutter/material.dart';
import 'package:stays_hotel_booking/component/bottomNav/common_bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(
        child: Text('Profile Screen'),
      ),

      bottomNavigationBar: CommonBottomNavBar(currentIndex: 3),
    );
  }
}