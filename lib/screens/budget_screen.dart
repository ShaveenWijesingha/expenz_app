import 'package:expens/models/expenz_modle.dart';
import 'package:expens/models/incom_modle.dart';
import 'package:expens/utils/colors.dart';
import 'package:expens/utils/constant.dart';
import 'package:expens/widgets/category_card.dart';
import 'package:expens/widgets/pie_chart.dart';

import 'package:flutter/material.dart';

class budgetScreen extends StatefulWidget {
  final Map<expenzCategory, double> expenseCategoryTotals;
  final Map<IncomeCategory, double> incomeCategoryTotals;

  const budgetScreen({
    super.key,
    required this.expenseCategoryTotals,
    required this.incomeCategoryTotals,
  });

  @override
  State<budgetScreen> createState() => _budgetScreenState();
}

class _budgetScreenState extends State<budgetScreen> {
  int _slectedOption = 0;

  //method to find the category color from the category
  Color getCategoryColor(dynamic category) {
    if (category is expenzCategory) {
      return expenzCategoryColor[category]!;
    } else {
      return incomeCategoryColor[category]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = _slectedOption == 0
        ? widget.incomeCategoryTotals
        : widget.expenseCategoryTotals;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Financial Report",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: KDefaltHeight * 2),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: KDefaltPadding),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.086,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: kWhite,
                    boxShadow: [
                      BoxShadow(color: kBlack.withOpacity(0.1), blurRadius: 10),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _slectedOption = 0;
                            });
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.8,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: _slectedOption == 0 ? kGreen : kWhite,
                              boxShadow: [
                                BoxShadow(
                                  color: kBlack.withOpacity(0.1),
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                "Income",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: _slectedOption == 0 ? kWhite : kBlack,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _slectedOption = 1;
                            });
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.8,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: _slectedOption == 1 ? kRed : kWhite,
                              boxShadow: [
                                BoxShadow(
                                  color: kBlack.withOpacity(0.1),
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                "Expense",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: _slectedOption == 1 ? kWhite : kBlack,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              //pie chart
              PieChartWidget(
                expenseCategoryTotals: widget.expenseCategoryTotals,
                incomeCategoryTotals: widget.incomeCategoryTotals,
                isExpense: _slectedOption == 1,
              ),
              SizedBox(height: 20),

              //list of categories
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final Category = data.keys.toList()[index];
                    final total = data.values.toList()[index];
                    return CategoryCard(
                      title: Category.name,
                      amount: total,
                      total: data.values.reduce(
                        (value, Element) => value + Element,
                      ),
                      progressColor: getCategoryColor(Category),
                      isExpense: _slectedOption != 0,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
