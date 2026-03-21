import 'package:flutter/material.dart';

class addNewScreen extends StatefulWidget {
  const addNewScreen({super.key});

  @override
  State<addNewScreen> createState() => _addNewScreenState();
}

class _addNewScreenState extends State<addNewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar:AppBar(title: Text("Add new"),));
  }
}