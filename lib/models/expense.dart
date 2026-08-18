
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();

enum Category {
  food,
  travel,
  leisure,
  work,
}
//map from each Category
const CategoryIcons= {
  Category.food : Icons.lunch_dining,
  Category.travel : Icons.flight_takeoff,
  Category.leisure : Icons.movie,
  Category.work : Icons.work,


};

// For describing a single expense
class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  String get formattedData{  //accessing a fun like a var not need of ()
    return formatter.format(date);  //Take the date and convert it into a formatted text (String)
  }




  // Constructor
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();
}