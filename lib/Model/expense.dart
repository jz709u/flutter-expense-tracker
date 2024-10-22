import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

class Expense {
  final String id;
  final String title;
  final double amount;
  final Category category;
  final DateTime date;
  Expense({required this.title, required this.amount, required this.category, required this.date})
      : id = uuid.v4();

  IconData get icon => categoryIcons[category] ?? Icons.disabled_by_default;

  String get formatted {
    return formatter.format(date);
  }
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

enum Category {
  food,
  travel,
  leisure,
  work,
}