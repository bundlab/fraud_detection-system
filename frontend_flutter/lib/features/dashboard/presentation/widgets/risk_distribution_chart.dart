import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class RiskDistributionChart extends StatelessWidget {
  const RiskDistributionChart({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      _RiskSlice('Low', 68, AppColors.riskLow),
      _RiskSlice('Medium', 18, AppColors.riskMedium),
      _RiskSlice('High', 10, AppColors.riskHigh),
      _RiskSlice('Critical', 4, AppColors.riskCritical),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 160,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 42,
                  sections: data.map((slice) {
                    return PieChartSectionData(
                      color: slice.color,
                      value: slice.percentage.toDouble(),
                      title: '${slice.percentage}%',
                      radius: 38,
                      titleStyle: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: data.map((slice) {
                return SizedBox(
                  width: 110,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: slice.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          '${slice.label} (${slice.percentage}%)',
                          style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _RiskSlice {
  final String label;
  final int percentage;
  final Color color;

  _RiskSlice(this.label, this.percentage, this.color);
}
