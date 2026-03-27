//enum for expenz category
import 'package:flutter/material.dart';

enum expenzCategory { Food, Transport, Health, Shoping, Subscription, Other }

//category images
final Map<expenzCategory, String> expenzCategorieImages = {
  expenzCategory.Food: "assets/images/food.png",
  expenzCategory.Transport: "assets/images/transport.png",
  expenzCategory.Health: "assets/images/health.png",
  expenzCategory.Shoping: "assets/images/shopping.png",
  expenzCategory.Subscription: "assets/images/subscription.png",
  expenzCategory.Other: "assets/images/other.png",
};
//category colors
final Map<expenzCategory, Color> incomeCategoryColor = {
  expenzCategory.Food: const Color.fromARGB(255, 197, 23, 55),
  expenzCategory.Transport: const Color.fromARGB(255, 11, 176, 16),
  expenzCategory.Health: const Color.fromARGB(255, 147, 8, 89),
  expenzCategory.Shoping: const Color.fromARGB(255, 31, 18, 126),
  expenzCategory.Subscription: const Color.fromARGB(255, 73, 17, 129),
  expenzCategory.Other: const Color.fromARGB(255, 205, 143, 19),
};

//modle
class Expenz {
  final int id;
  final String title;
  final double amount;
  final expenzCategory category;
  final DateTime date;
  final DateTime time;
  final String description;
  Expenz({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.time,
    required this.description,
  });

  //Convert the expense object to a json object
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

  //create an expence object from a JSON object
  factory Expenz.fromJSON(Map<String, dynamic> json) {
    return Expenz(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
      category: expenzCategory.values[json['category']],
      date: DateTime.parse(json['data']),
      time: DateTime.parse(json['time']),
      description: json['description'],
    );
  }
}
