import 'package:flutter/material.dart';

class transactionScreen extends StatefulWidget {
  const transactionScreen({super.key});

  @override
  State<transactionScreen> createState() => _transactionScreenState();
}

class _transactionScreenState extends State<transactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Transaction")));
  }
}
