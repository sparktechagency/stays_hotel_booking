class SubscriptionPlan {
  const SubscriptionPlan({
    required this.title,
    required this.priceLabel,
    required this.perfectFor,
    required this.features,
  });

  final String title;
  final String priceLabel;
  final List<String> perfectFor;
  final List<String> features;
}