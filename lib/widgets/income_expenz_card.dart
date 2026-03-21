import 'dart:ffi';

import 'package:expens/utils/colors.dart';
import 'package:flutter/material.dart';

class IncomeExpenzCard extends StatefulWidget {
  final String title;
  final double amount;
  final String imageUrl;
  final Color color;

  const IncomeExpenzCard({
    super.key,
    required this.color,
    required this.title,
    required this.amount,
    required this.imageUrl,
  });

  @override
  State<IncomeExpenzCard> createState() => _IncomeExpenzCardState();
}

class _IncomeExpenzCardState extends State<IncomeExpenzCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.height * 0.09,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.15,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(child: Image.asset(widget.imageUrl, width: 60)),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: [
                SizedBox(height: 12),
                Text(
                  "${widget.title}(Rs)",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: kWhite,
                  ),
                ),

                Text(
                  "${widget.amount.toString()}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: kWhite,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
