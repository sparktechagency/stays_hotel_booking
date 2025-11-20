import 'package:flutter/material.dart';

class ProfileMenuItemModel {
  final String id;
  final String title;
  final IconData icon;
  final bool isDestructive;

  ProfileMenuItemModel({
    required this.id,
    required this.title,
    required this.icon,
    this.isDestructive = false,
  });
}

