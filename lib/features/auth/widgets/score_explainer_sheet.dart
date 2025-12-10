import 'package:flutter/material.dart';

class ScoreExplainerSheet extends StatelessWidget {
  const ScoreExplainerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'The AIP Score Explained',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "Your ability to age in place is a balance. We calculate how your Care Team supports your Health, while accounting for Home Safety risks.",
              style: TextStyle(fontSize: 16, height: 1.5),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          _buildPillarCard(
            context,
            icon: Icons.accessibility_new,
            color: Colors.blue,
            title: "Health & Independence",
            desc: "Measures physical capacity: ADLs, Walking Speed, Grip Strength.",
          ),
          const SizedBox(height: 12),
          _buildPillarCard(
            context,
            icon: Icons.diversity_3,
            color: Colors.purple,
            title: "The Multiplier",
            desc: "A strong support system multiplies your ability to stay home safely.",
          ),
          const SizedBox(height: 12),
          _buildPillarCard(
            context,
            icon: Icons.home_work,
            color: Colors.orange,
            title: "The Constraint",
            desc: "Home hazards act as a penalty, limiting your overall independence.",
          ),
          const SizedBox(height: 32),
          const Text(
            "Score = (Health × Support) - Home Hazards",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Courier',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Got it",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPillarCard(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String title,
    required String desc,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

