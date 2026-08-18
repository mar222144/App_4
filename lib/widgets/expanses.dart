
import 'package:flutter/material.dart';
import 'package:app_4/models/expense.dart';
import 'package:app_4/widgets/expenses_list.dart';
import 'package:app_4/widgets/new_expense.dart';

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

  // This method receives the new Expense
  // from NewExpense widget
  /*void _addExpense() {
    setState(() {
      // _registeredExpenses.add(newExpense!); //ffffffffffffffffffffffffff
    });
  }*/

  // Open Bottom Sheet
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,

       builder: (ctx) =>NewExpense(onAddExpense: _addExpense,),
      //   onAddExpense:  _addExpense(),

    );
  }
//lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll
void _addExpense(Expense expnse){
    setState(() {
      _registeredExpenses.add(expnse);
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


    Widget mainCount = const Center(
      child: Text(
        'No expenses found. Start adding some!',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainCount = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }



    return Scaffold(
      backgroundColor: Colors.black12,

      appBar: AppBar(
        centerTitle: true,
        title: const Text('flutter expense tracker'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 180, 180, 180),
                Color.fromARGB(255, 100, 100, 100),
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
            child: mainCount,
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