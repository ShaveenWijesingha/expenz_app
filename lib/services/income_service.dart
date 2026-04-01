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
}
