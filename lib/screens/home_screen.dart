import 'package:expens/models/expenz_modle.dart';
import 'package:expens/models/incom_modle.dart';
import 'package:expens/services/user_service.dart';
import 'package:expens/utils/colors.dart';
import 'package:expens/utils/constant.dart';
import 'package:expens/widgets/expense_card.dart';
import 'package:expens/widgets/income_expenz_card.dart';
import 'package:expens/widgets/line_chart.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final List<Expense> expenseList;
  final List<Income> incomeList;
  const HomeScreen({
    super.key,
    required this.expenseList,
    required this.incomeList,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //for store the username
  String username = "";
  double totalIncome = 0;
  double totalExpense = 0;
  @override
  void initState() {
    super.initState();
    //het the user name from the shared pref
    UserService.getUserData().then((value) {
      if (value["username"] != null) {
        setState(() {
          username = value["username"] ?? "";
          print("USERNAME: $username");
        });
      }
      setState(() {
        for (var i = 0; i < widget.expenseList.length; i++) {
          totalExpense += widget.expenseList[i].amount;
        }
        for (var i = 0; i < widget.incomeList.length; i++) {
          totalIncome += widget.incomeList[i].amount;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isExpanded = false;

    return Scaffold(
      backgroundColor: kMainColor.withOpacity(0.2),
      body: SafeArea(
        child: SingleChildScrollView(
          //main column
          child: Container(
            color: kWhite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    color: kMainColor.withOpacity(0.2),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: kMainColor,
                                    width: 3,
                                  ),
                                  color: kMainColor,
                                ),

                                child: ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    100,
                                  ),
                                  child: Image.asset(
                                    "assets/images/user.jpg",
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Welcome Shaveen",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 60),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.notifications,
                                  size: 30,
                                  color: kMainColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IncomeExpenzCard(
                              color: kGreen,
                              title: 'Income',
                              amount: totalIncome,
                              imageUrl: 'assets/images/income.png',
                            ),
                            IncomeExpenzCard(
                              color: kRed,
                              title: 'Expenses',
                              amount: totalExpense,
                              imageUrl: 'assets/images/expense.png',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                //line chart
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(KDefaltPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Spend Frequency",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        LineChartSample(),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.all(KDefaltPadding / 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Recent Transactions",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: kGrey.withOpacity(.25),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text(
                                      "See All",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: kMainColor.withOpacity(.8),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: isExpanded
                              ? widget.expenseList.length * 100
                              : MediaQuery.of(context).size.height * 0.35,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  widget.expenseList.isEmpty
                                      ? Center(
                                          child: Column(
                                            children: [
                                              Opacity(
                                                opacity: 0.4,
                                                child: Image.asset(
                                                  "assets/images/nothing.png",
                                                  width: 100,
                                                ),
                                              ),
                                              Text(
                                                "No incomes added yet.add some incomes to see them here.",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: kGrey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : ListView.builder(
                                          itemCount: widget.expenseList.length,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),

                                          itemBuilder: (context, index) {
                                            final expense =
                                                widget.expenseList[index];
                                            return ExpenseCard(
                                              title: expense.title,
                                              date: expense.date,
                                              amount: expense.amount.toInt(),
                                              category: expense.category,
                                              description: expense.description,
                                              time: expense.time,
                                            );
                                          },
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
