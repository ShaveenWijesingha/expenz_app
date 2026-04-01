import 'dart:convert';

import 'package:expens/models/incom_modle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeService {
  //define the key for storing incomes in shared preferences
  static const String _incomeKey = "income";

  //save the incomes to shared preferences
  Future<void> saveIncome(Income income, BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();

      List<String>? existingIncomes = pref.getStringList(_incomeKey);

      //convret the existing incomes to a list of income object
      List<Income> existingIncomeObject = [];
      if (existingIncomes != null) {
        existingIncomeObject = existingIncomes
            .map((e) => Income.fromJSON(json.decode(e)))
            .toList();
      }
      //add the new income to the list
      existingIncomeObject.add(income);
      //convert the list of incomes object back to a list of string
      List<String> updatedIncome = existingIncomeObject
          .map((e) => json.encode(e.toJSON()))
          .toList();

      //save the updated list of incomes to shared pref
      await pref.setStringList(_incomeKey, updatedIncome);

      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Income added!"),
          duration: Duration(seconds: 2),
        ),
      );
      }
      
    } catch (error) {
       if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error on adding expense!"),
          duration: Duration(seconds: 2),
        ),
      );
      }
    }
  }
  //load the icome from the shared pref
  Future <List<Income>> loadIncomes() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? existingIncomes =pref.getStringList(_incomeKey);

    //convert the existing incomes to a list of income object
    List<Income> loadedIncomes=[];
    if(existingIncomes!=null){
      loadedIncomes=existingIncomes.map((e)=>Income.fromJSON(json.decode(e))).toList();
    }
    return loadedIncomes;
  }

  //delete the incomes from the shared pref from the id
  Future<void> deleteIncome(int id, BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? existingIncomes = pref.getStringList(_incomeKey);
      //convert the existing incomes to a list of Expense objects
      List<Income> existingIncomeObjects = [];
      if (existingIncomes != null) {
        existingIncomeObjects = existingIncomes
            .map((e) => Income.fromJSON(json.decode(e)))
            .toList();
      }
      //remove the income with the given id from the list
      existingIncomeObjects.removeWhere((Income) => Income.id == id);
      //convert the list of income back to a list of strings
      List<String> updatedIncomes = existingIncomeObjects
          .map((e) => json.encode(e.toJSON()))
          .toList();
      //save the updated list of expenses to shared pref
      await pref.setStringList(_incomeKey, updatedIncomes);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Income deleted!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      print(error.toString());
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("error deleting income!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
