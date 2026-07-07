import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  const CategoryCard({
    super.key,
    required this.categoryName,
    required this.icon,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = color ?? theme.primaryColor.withAlpha(20);
    final iconColor = color != null ? Colors.white : theme.primaryColor;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: color == null ? theme.primaryColor.withAlpha(31) : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
            const SizedBox(width: 10),
            Text(
              categoryName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: color != null ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
