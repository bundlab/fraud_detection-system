import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class RiskFilterChips extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelected;

  const RiskFilterChips({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [
      ('all', 'All', null),
      ('low', 'Low', AppColors.riskLow),
      ('medium', 'Medium', AppColors.riskMedium),
      ('high', 'High', AppColors.riskHigh),
      ('critical', 'Critical', AppColors.riskCritical),
    ];

    return SizedBox(
      height: 52,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final (value, label, color) = filters[index];
          final isSelected = selected == value;

          return FilterChip(
            label: Text(label),
            selected: isSelected,
            onSelected: (_) => onSelected(value),
            selectedColor: color?.withOpacity(0.15) ??
                AppColors.primary.withOpacity(0.12),
            checkmarkColor: color ?? AppColors.primary,
            labelStyle: TextStyle(
              color: isSelected
                  ? (color ?? AppColors.primary)
                  : AppColors.textSecondary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              fontSize: 13,
            ),
            side: BorderSide(
              color: isSelected
                  ? (color ?? AppColors.primary)
                  : AppColors.border,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          );
        },
      ),
    );
  }
}
