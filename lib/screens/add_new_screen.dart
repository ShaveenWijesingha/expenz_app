import 'package:expens/models/expenz_modle.dart';
import 'package:expens/models/incom_modle.dart';
import 'package:expens/utils/colors.dart';
import 'package:expens/utils/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class addNewScreen extends StatefulWidget {
  const addNewScreen({super.key});

  @override
  State<addNewScreen> createState() => _addNewScreenState();
}

class _addNewScreenState extends State<addNewScreen> {
  //state to track the expence or incoms
  int _selectedMethod = 0;
  expenzCategory _expenceCategory = expenzCategory.Health;
  IncomeCategory _incomeCategory = IncomeCategory.Salary;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  DateTime _selectedTime = DateTime.now();

  Object? selectedCategory;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedMethod == 0
          ? kRed.withOpacity(.9)
          : kGreen.withOpacity(.9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: KDefaltPadding),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: KDefaltPadding),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedMethod = 1;
                              });
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: _selectedMethod == 0 ? kWhite : kGreen,
                              ),
                              child: Center(
                                child: Text(
                                  "Incoms",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: _selectedMethod == 1
                                        ? kWhite
                                        : kBlack,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedMethod = 0;
                              });
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: _selectedMethod == 1 ? kWhite : kRed,
                              ),
                              child: Center(
                                child: Text(
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: _selectedMethod == 1
                                        ? kBlack
                                        : kWhite,
                                  ),
                                  "Expense",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //amount feild
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: KDefaltPadding),
                  child: Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: kLightGrey,
                          ),
                          "How much? (LKR)",
                        ),
                        TextField(
                          style: TextStyle(
                            fontSize: 40,
                            color: kWhite,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            hintText: "0",
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: 50,
                              color: kWhite,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                //user data form
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.23,
                  ),
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Form(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          //category selector dropdown
                          DropdownButtonFormField<Object>(
                            hint: _selectedMethod == 1
                                ? Text(
                                    "Income Category",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: kGrey,
                                    ),
                                  )
                                : Text(
                                    "Expence Category",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: kGrey,
                                    ),
                                  ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 20,
                              ),
                            ),
                            value: getValidValue(),

                            items: _selectedMethod == 0
                                ? expenzCategory.values.map((category) {
                                    return DropdownMenuItem<Object>(
                                      value: category,
                                      child: Text(category.name),
                                    );
                                  }).toList()
                                : IncomeCategory.values.map((category) {
                                    return DropdownMenuItem<Object>(
                                      value: category,
                                      child: Text(category.name),
                                    );
                                  }).toList(),

                            onChanged: (value) {
                              setState(() {
                                selectedCategory = value;
                                _selectedMethod == 0
                                    ? _expenceCategory = value as expenzCategory
                                    : _incomeCategory = value as IncomeCategory;
                                print(
                                  _selectedMethod == 0
                                      ? _expenceCategory.name
                                      : _incomeCategory.name,
                                );
                              });
                            },
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: _titleController,
                            decoration: InputDecoration(
                              hint: Text(
                                "Title",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: kGrey,
                                ),
                              ),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 20,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              hint: Text(
                                "Description",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: kGrey,
                                ),
                              ),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 20,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hint: Text(
                                "Amount",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: kGrey,
                                ),
                              ),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 20,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          //date picker
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2025),
                                    lastDate: DateTime(2035),
                                  ).then((value) {
                                    if (value != null) {
                                      setState(() {
                                        _selectedDate = value;
                                      });
                                    } else {
                                      _selectedDate = DateTime.now();
                                    }
                                  });
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  decoration: BoxDecoration(
                                    color: kMainColor.withOpacity(0.88),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: KDefaltPadding,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month,
                                          color: kWhite,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "Select Date",
                                          style: TextStyle(
                                            color: kWhite,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                DateFormat.yMMMEd().format(_selectedDate),
                                style: TextStyle(
                                  color: kGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          //time picker
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    setState(() {
                                      if (value != null) {
                                        _selectedTime = DateTime(
                                          _selectedDate.year,
                                          _selectedDate.month,
                                          _selectedDate.day,
                                          value.hour,
                                          value.minute,
                                        );
                                      }
                                    });
                                  });
                                },

                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  decoration: BoxDecoration(
                                    color: kYellow.withOpacity(0.88),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: KDefaltPadding,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.access_time_filled,
                                          color: kWhite,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "Select Time",
                                          style: TextStyle(
                                            color: kWhite,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                DateFormat.jm().format(_selectedTime),
                                style: TextStyle(
                                  color: kGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Divider(color: kLightGrey, thickness: 5),
                            ],
                          ),

                          SizedBox(height: 30),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width * 1,
                            decoration: BoxDecoration(
                              color: _selectedMethod == 0
                                  ? kRed.withOpacity(.9)
                                  : kGreen,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: KDefaltPadding,
                              ),
                              child: Center(
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                    color: kWhite,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
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
      ),
    );
  }

  Object? getValidValue() {
    final items = _selectedMethod == 0
        ? expenzCategory.values
        : IncomeCategory.values;

    if (items.contains(selectedCategory)) {
      return selectedCategory;
    }
    return null;
  }
}
