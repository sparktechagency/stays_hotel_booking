import 'package:flutter/material.dart';
import 'package:stays_hotel_booking/component/bottomNav/common_bottom_nav_bar.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking'),
      ),
      body: const Center(
        child: Text('Booking Screen'),
      ),

      bottomNavigationBar: CommonBottomNavBar(currentIndex: 1),
    );
  }
}