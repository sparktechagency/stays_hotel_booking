import 'package:flutter/material.dart';

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String timeAgo;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.timeAgo,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    this.isRead = false,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      timeAgo: json['timeAgo'] ?? '',
      icon: _getIconFromString(json['icon'] ?? ''),
      iconColor: _getColorFromString(json['iconColor'] ?? ''),
      iconBackgroundColor: _getColorFromString(json['iconBackgroundColor'] ?? ''),
      isRead: json['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'timeAgo': timeAgo,
      'icon': icon.toString(),
      'iconColor': iconColor.toString(),
      'iconBackgroundColor': iconBackgroundColor.toString(),
      'isRead': isRead,
    };
  }

  NotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    String? timeAgo,
    IconData? icon,
    Color? iconColor,
    Color? iconBackgroundColor,
    bool? isRead,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      timeAgo: timeAgo ?? this.timeAgo,
      icon: icon ?? this.icon,
      iconColor: iconColor ?? this.iconColor,
      iconBackgroundColor: iconBackgroundColor ?? this.iconBackgroundColor,
      isRead: isRead ?? this.isRead,
    );
  }

  static IconData _getIconFromString(String iconString) {
    switch (iconString) {
      case 'check':
        return Icons.check;
      case 'percent':
        return Icons.percent;
      case 'message':
        return Icons.message;
      case 'explore':
        return Icons.explore;
      default:
        return Icons.notifications;
    }
  }

  static Color _getColorFromString(String colorString) {
    switch (colorString) {
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'orange':
        return Colors.orange;
      case 'purple':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
