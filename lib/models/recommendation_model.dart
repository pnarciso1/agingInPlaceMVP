class Recommendation {
  final String title;
  final String description;
  final String type; // Health, Home, Care
  final String actionLabel;

  const Recommendation({
    required this.title,
    required this.description,
    required this.type,
    required this.actionLabel,
  });
}

