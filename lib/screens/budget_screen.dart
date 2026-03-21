import 'package:flutter/material.dart';

class budgetScreen extends StatefulWidget {
  const budgetScreen({super.key});

  @override
  State<budgetScreen> createState() => _budgetScreenState();
}

class _budgetScreenState extends State<budgetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar:AppBar(title: Text("Budget"),));
  }
}