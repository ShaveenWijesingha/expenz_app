import 'package:expens/models/expenz_modle.dart';
import 'package:expens/models/incom_modle.dart';
import 'package:expens/widgets/expense_card.dart';
import 'package:expens/widgets/income_card.dart';
import 'package:flutter/material.dart';
import 'package:expens/utils/colors.dart';
import 'package:expens/utils/constant.dart';

class transactionScreen extends StatefulWidget {
  final List<Expense> expenseList;
  final List<Income> incomeList;
  final void Function(Expense) onDismissExpense;
  final void Function(Income) onDismissIncomes;
  const transactionScreen({
    super.key,
    required this.expenseList,
    required this.onDismissExpense,
    required this.incomeList,
    required this.onDismissIncomes,
  });

  @override
  State<transactionScreen> createState() => _transactionScreenState();
}

class _transactionScreenState extends State<transactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(KDefaltPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "See your financial report",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: kMainColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Expenses",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kBlack,
                        ),
                      ),
                      Icon(Icons.arrow_drop_down, color: kBlack, size: 45),
                    ],
                  ),
                  SizedBox(height: 20),
                  //list of expenses
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ListView.builder(
                              itemCount: widget.expenseList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),

                              itemBuilder: (context, index) {
                                final expense = widget.expenseList[index];
                                return Dismissible(
                                  key: ValueKey(expense),
                                  direction: DismissDirection.startToEnd,
                                  onDismissed: (direction) {
                                    setState(() {
                                      widget.onDismissExpense(expense);
                                    });
                                  },
                                  child: ExpenseCard(
                                    title: expense.title,
                                    date: expense.date,
                                    amount: expense.amount.toInt(),
                                    category: expense.category,
                                    description: expense.description,
                                    time: expense.time,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  Text(
                    "Incomes",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: kBlack,
                    ),
                  ),
                  SizedBox(height: 20),

                  //list of incomes
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ListView.builder(
                              itemCount: widget.incomeList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),

                              itemBuilder: (context, index) {
                                final Income = widget.incomeList[index];
                                return Dismissible(
                                  key: ValueKey(Income),
                                  direction: DismissDirection.startToEnd,
                                  onDismissed: (direction) {
                                    setState(() {
                                      widget.onDismissIncomes(Income);
                                    });
                                  },

                                  child: IncomeCard(
                                    title: Income.title,
                                    date: Income.date,
                                    amount: Income.amount.toInt(),
                                    category: Income.category,
                                    description: Income.description,
                                    time: Income.time,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
