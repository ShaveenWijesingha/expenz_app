import 'package:flutter/material.dart';

enum IncomeCategory {
  Freelance,
  Salary,
  Business,
  Partime,
  Gift,
  Investment,
  Other,
}

//category image
final Map<IncomeCategory, String> IncomeCategoryImagesc = {
  IncomeCategory.Freelance: "assets/images/freelance.png",
  IncomeCategory.Salary: "assets/images/salaryIncome.png",
  IncomeCategory.Business: "assets/images/businus.png",
  IncomeCategory.Partime: "assets/images/parttime.png",
  IncomeCategory.Gift: "assets/images/gift.png",
  IncomeCategory.Investment: "assets/images/Investment.png",
  IncomeCategory.Other: "assets/images/otherIncoms.png",
};
//category colors
final Map<IncomeCategory, Color> incomeCategoryColor = {
  IncomeCategory.Freelance: const Color.fromARGB(255, 72, 176, 12),
  IncomeCategory.Salary: const Color.fromARGB(255, 201, 180, 14),
  IncomeCategory.Business: const Color.fromARGB(255, 123, 69, 9),
  IncomeCategory.Partime: const Color.fromARGB(255, 32, 19, 131),
  IncomeCategory.Gift: const Color.fromARGB(255, 8, 156, 92),
  IncomeCategory.Investment: const Color.fromARGB(255, 169, 19, 54),
  IncomeCategory.Other: const Color.fromARGB(255, 156, 10, 125),
};

final class Income {
  final int id;
  final String title;
  final double amount;
  final IncomeCategory category;
  final DateTime date;
  final DateTime time;
  final String description;

  Income({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.time,
    required this.description,
  });
  //Convert the income object to a json object

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category.index,
      'date': date.toIso8601String(),
      'time': time.toIso8601String(),
      'description': description,
    };
  }

  //create an income object from a JSON object

  factory Income.fromJSON(Map<String, dynamic> json) {
    return Income(
      id: json['id'],
      title: json['title'] ?? 'No Title',
      amount: json['amount'],
      category: IncomeCategory.values[json['category']],
      date: DateTime.parse(json['date']),
      time: DateTime.parse(json['time']),
      description: json['description'] ?? '',
    );
  }
}
