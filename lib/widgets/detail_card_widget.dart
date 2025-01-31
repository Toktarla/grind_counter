import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


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
          FaIcon(icon, size: 40, color: color),
          const SizedBox(height: 8),
          Text(
            integerValue,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
