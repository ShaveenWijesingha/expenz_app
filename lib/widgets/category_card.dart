import 'package:expens/utils/colors.dart';
import 'package:expens/utils/constant.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  final String title;
  final double amount;
  final double total;
  final Color progressColor;
  final bool isExpense;
  const CategoryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.total,
    required this.progressColor,
    required this.isExpense,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    double progressWidth = widget.total != 0
        ? MediaQuery.of(context).size.width * (widget.amount / widget.total)
        : 0;
    return Container(
      padding: EdgeInsets.all(KDefaltPadding * .5),
      decoration: BoxDecoration(
        color: kGrey.withOpacity(0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: kGrey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),

                  child: Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: widget.progressColor,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: kBlack,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "${(widget.amount / widget.total * 100).toStringAsFixed(2)} %",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: kBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                widget.isExpense
                    ? "-${widget.amount.toString()} LKR"
                    : "+${widget.amount.toString()} LKR",
                style: TextStyle(
                  color: widget.isExpense ? kRed : kGreen,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: 10,

            width: progressWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: widget.progressColor,
            ),
          ),
        ],
      ),
    );
  }
}
