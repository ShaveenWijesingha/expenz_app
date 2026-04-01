import 'package:expens/models/expenz_modle.dart';
import 'package:expens/models/incom_modle.dart';
import 'package:expens/screens/add_new_screen.dart';
import 'package:expens/screens/budget_screen.dart';
import 'package:expens/screens/home_screen.dart';
import 'package:expens/screens/profile_screen.dart';
import 'package:expens/screens/transaction_screen.dart';
import 'package:expens/services/expense_service.dart';
import 'package:expens/services/income_service.dart';
import 'package:expens/utils/colors.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //current page index
  int _currentPageIndex = 0;
  List<Expense> expenseList = [];
  List<Income> incomeList = [];
  //function to fetch expenses
  void fechAllExpenses() async {
    List<Expense> loadedExpenses = await ExpenseService().loadExpenses();
    setState(() {
      expenseList = loadedExpenses;
    });
  }

  //function to add a new expense
  void addNewExpense(Expense newExpense) {
    ExpenseService().saveExpenses(newExpense, context);
    // update the list of expense
    setState(() {
      expenseList.add(newExpense);
    });
  }

  //function to fetch incomee
  void fetchAllIncomes() async {
    List<Income> loadedIncomes = await IncomeService().loadIncomes();
    setState(() {
      incomeList = loadedIncomes;
    });
  }

  //function to add a new income
  void addNewIncome(Income newIncome) {
    IncomeService().saveIncome(newIncome, context);
    // update the list of income
    setState(() {
      incomeList.add(newIncome);
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      fechAllExpenses();
    });
  }

  @override
  Widget build(BuildContext context) {
    //screens list
    final List<Widget> pages = [
      HomeScreen(),
      transactionScreen(),
      addNewScreen(addExpense: addNewExpense, addIncome: addNewIncome),
      budgetScreen(),
      profileScreen(),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: kWhite,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGrey,

        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 28), // normal
            activeIcon: Icon(Icons.home, size: 32), // selected size
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded, size: 28), // normal
            activeIcon: Icon(Icons.list_rounded, size: 32), // selected size

            label: "Transactions",
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                color: kMainColor,
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(10),
              child: Icon(Icons.add, color: kWhite, size: 35),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket, size: 28), // normal
            activeIcon: Icon(Icons.rocket, size: 32), // selected size

            label: "Budget",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 28), // normal
            activeIcon: Icon(Icons.person, size: 32), // selected size

            label: "Profile",
          ),
        ],
      ),
      body: pages[_currentPageIndex],
    );
  }
}
