import 'dart:convert';

import 'package:expens/models/expenz_modle.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseService {
  //expence list
  List<Expense> expensesList = [];

  //define to key for storing expenses in shared prif
  static const String _expenseKey = "expenses";

  //save the expense to shared pref
  Future<void> saveExpenses(Expense expense, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingExpenses = prefs.getStringList(_expenseKey);

      //convert the existing expenses to a list of Expense objects
      List<Expense> existingExpensesObjects = [];
      if (existingExpenses != null) {
        existingExpensesObjects = existingExpenses
            .map((e) => Expense.fromJSON(json.decode(e)))
            .toList();
      }
      //add the expense to the list
      existingExpensesObjects.add(expense);
      //convert the list of expense back to a list of strings
      List<String> updateExxpenses = existingExpensesObjects
          .map((e) => json.encode(e.toJSON()))
          .toList();

      //save the updated list of expenses to sharedd pref
      await prefs.setStringList(_expenseKey, updateExxpenses);

      //showMessage
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Expense added !"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error on adding expense !"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  //Load the expenses from shared pref
  Future<List<Expense>> loadExpenses() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? existingExpenses = pref.getStringList(_expenseKey);

    //convert the existing expenses to a list of Expense objects
    List<Expense> loadedExpenses = [];
    if (existingExpenses != null) {
      loadedExpenses = existingExpenses
          .map((e) => Expense.fromJSON(json.decode(e)))
          .toList();
          
    }
    return loadedExpenses;
  }
}
