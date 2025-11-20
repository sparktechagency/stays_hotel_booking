import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../subscription/domain/plan.dart';

final plansProvider = Provider<List<Plan>>((ref) {
  return const [
    Plan(
      title: 'GCC plan',
      priceLabel: '\$49',
      perfectFor: ['New users and those planning a single, simple trip'],
      features: [
        'Full hotels access up to -70% off - Available for: UAE - QATAR - OMAN - SAUDIA - BAHREIN - KUWAIT',
        'Generate 1 sample itinerary',
        'Earn 1 free full itinerary by successfully inviting 2 friends to the app',
        'Basic access to the conversational AI assistant for travel questions.',
      ],
    ),
 ];
});

final currentPlanIndexProvider = StateProvider<int>((ref) => 0);

// Controller held in provider (autoDispose cleans it up when screen is gone)
final pageControllerProvider = Provider.autoDispose<PageController>((ref) {
  final controller = PageController(viewportFraction: 0.9, initialPage: 0);
  ref.onDispose(controller.dispose);
  return controller;
});