import 'package:expens/models/expenz_modle.dart';
import 'package:expens/models/incom_modle.dart';

import 'package:expens/utils/colors.dart';
import 'package:expens/utils/constant.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';

class PieChartWidget extends StatefulWidget {
  final Map<expenzCategory, double> expenseCategoryTotals;
  final Map<IncomeCategory, double> incomeCategoryTotals;

  final bool isExpense;

  const PieChartWidget({
    super.key,
    required this.expenseCategoryTotals,
    required this.incomeCategoryTotals,
    required this.isExpense,
  });

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  //section data
  List<PieChartSectionData> getSections() {
    if (widget.isExpense) {
      return [
        PieChartSectionData(
          color: expenzCategoryColor[expenzCategory.Food],
          value: widget.expenseCategoryTotals[expenzCategory.Food] ?? 0,
          showTitle: false,
          radius: 40,
        ),
        PieChartSectionData(
          color: expenzCategoryColor[expenzCategory.Health],
          value: widget.expenseCategoryTotals[expenzCategory.Health] ?? 0,
          showTitle: false,
          radius: 40,
        ),
        PieChartSectionData(
          color: expenzCategoryColor[expenzCategory.Shoping],
          value: widget.expenseCategoryTotals[expenzCategory.Shoping] ?? 0,
          showTitle: false,
          radius: 40,
        ),
        PieChartSectionData(
          color: expenzCategoryColor[expenzCategory.Subscription],
          value: widget.expenseCategoryTotals[expenzCategory.Subscription] ?? 0,
          showTitle: false,
          radius: 40,
        ),
        PieChartSectionData(
          color: expenzCategoryColor[expenzCategory.Transport],
          value: widget.expenseCategoryTotals[expenzCategory.Transport] ?? 0,
          showTitle: false,
          radius: 40,
        ),
        PieChartSectionData(
          color: expenzCategoryColor[expenzCategory.Other],
          value: widget.expenseCategoryTotals[expenzCategory.Other] ?? 0,
          showTitle: false,
          radius: 40,
        ),
      ];
    } else {
      return [
        PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.Business],
          value: widget.incomeCategoryTotals[IncomeCategory.Business] ?? 0,
          showTitle: false,
          radius: 40,
        ),
        PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.Freelance],
          value: widget.incomeCategoryTotals[IncomeCategory.Freelance] ?? 0,
          showTitle: false,
          radius: 40,
        ),
        PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.Gift],
          value: widget.incomeCategoryTotals[IncomeCategory.Gift] ?? 0,
          showTitle: false,
          radius: 40,
        ),
        PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.Investment],
          value: widget.incomeCategoryTotals[IncomeCategory.Investment] ?? 0,
          showTitle: false,
          radius: 40,
        ),
        PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.Partime],
          value: widget.incomeCategoryTotals[IncomeCategory.Partime] ?? 0,
          showTitle: false,
          radius: 40,
        ),
        PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.Salary],
          value: widget.incomeCategoryTotals[IncomeCategory.Salary] ?? 0,
          showTitle: false,
          radius: 40,
        ),
        PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.Other],
          value: widget.incomeCategoryTotals[IncomeCategory.Other] ?? 0,
          showTitle: false,
          radius: 40,
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final PieChartData pieChartData = PieChartData(
      sectionsSpace: 0,
      centerSpaceRadius: 90,
      startDegreeOffset: -90,
      sections: getSections(),
      borderData: FlBorderData(show: false),
    );
    return Container(
      height: 300,
      padding: EdgeInsets.all(KDefaltPadding),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: Stack(
        children: [
          PieChart(pieChartData),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text("Total amount", style: TextStyle(color: kGrey)),
                SizedBox(height: 8),
                Text(
                  "",
                  style: TextStyle(
                    color: kBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
