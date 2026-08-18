import 'package:flutter/material.dart';
import 'package:app_4/widgets/expenses_item.dart';
import 'package:app_4/models/expense.dart';
class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses, required this. onRemoveExpense});
  final List<Expense> expenses;
  final void Function (Expense expense) onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    //we use listview.builder lma ykon 3ndna list bs kbera awy w ahna msh 3rfeen 3ddha
    return  ListView.builder(
      //expenses fiha 3 expense
      itemCount: expenses.length ,
      itemBuilder: (ctx,index)=> Dismissible(
          key: ValueKey(expenses [index]),
          onDismissed:(direction) {
onRemoveExpense(expenses [index]);
          } ,
          child: ExpensesItem(
              expense: expenses[index]) ),
    );
  }
}
