import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {

  final double width;
  final double height;
  final IconData icon;
  final String integerValue;
  final String label;
  final Color color;

  const DetailCard(
      {super.key,
      required this.width,
      required this.height,
      required this.icon,
      required this.integerValue,
      required this.label,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: color),
          const SizedBox(height: 8),
          Text(
            integerValue,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 24)
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
