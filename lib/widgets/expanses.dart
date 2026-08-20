import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:app_4/models/expense.dart';
import 'package:app_4/widgets/expenses_list.dart';
import 'package:app_4/widgets/new_expense.dart';
import 'package:http/http.dart' as http;

class Expanses extends StatefulWidget {
  const Expanses({super.key});

  @override
  State<Expanses> createState() => _ExpansesState();
}

class _ExpansesState extends State<Expanses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.9,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'cinema',
      amount: 16.9,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: 'macdonalds',
      amount: 19,
      date: DateTime.now(),
      category: Category.food,
    ),
  ];




  @override
  void initState() {
    super.initState();
    //when the expenses page open get the data from firebas111111111111111111
    _loadItems();
  }

  Future<void> _loadItems() async {
    final url = Uri.https(

      //the place we want to get data back
      'flutter-prep-a1726-default-rtdb.firebaseio.com',
      'expenses.json',
    );


    final response = await http.get(url);

    print(response.body);
    print(response.statusCode);


    final Map<String, dynamic> listData =
    json.decode(response.body);


    if (listData.isEmpty) {
      return;
    }


    final int index = 0;

    final item = listData.entries.elementAt(index);


    final expenseData = item.value as Map<String,dynamic >;


    final loadedExpense = Expense(
      id: item.key,
      title: expenseData['title'],
      amount: (expenseData['amount'] as num).toDouble(),
      date: DateTime.parse(expenseData['date']),
      category: Category.values.firstWhere(
            (category) =>
        category.name == expenseData['category'],
      ),
    );

    setState(() {
      _registeredExpenses.clear();
      _registeredExpenses.add(loadedExpense);
    });
  }










  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: false,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.removeAt(expenseIndex);
    });

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(
                expenseIndex,
                expense,
              );
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text(
        'No expenses found. Start adding some!',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      backgroundColor: Colors.red,

      appBar: AppBar(
        centerTitle: true,
        title: const Text('flutter expense tracker'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 163, 126, 126),
                Color.fromARGB(255, 227, 155, 155),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
          ),
          Expanded(
            child: mainContent,
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 100, 100, 100),
        onPressed: _openAddExpenseOverlay,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}