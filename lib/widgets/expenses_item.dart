import 'package:app_4/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:app_4/models/expense.dart';
class ExpensesItem extends StatelessWidget {
  const ExpensesItem({super.key, required this.expense});
final Expense expense;
  @override
  Widget build(BuildContext context) {
    return   Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 30
          ),
          child: Column(
            children: [
              Text(expense.title),
              SizedBox(height: 4),
              Row(
                children: [
                  Text('\$${expense.amount.toStringAsFixed(2)}'),
                 const Spacer(),
                  Row(
                    children: [
                      Icon(CategoryIcons[expense.category]),
                      SizedBox(width: 6),
                      Text(expense.formattedData)
                    ],
                  ),
                ],
              )
            ],
          ),
        ),

    );
  }
}
