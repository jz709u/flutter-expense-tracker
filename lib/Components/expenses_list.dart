import 'package:expense_tracking_app/Components/expenses_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracking_app/Model/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final Function(Expense expense) onRemoveExpense;
  final List<Expense> expenses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
          key: ValueKey(expenses[index]),
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.7),
            margin: EdgeInsets.symmetric(
                horizontal:
                    Theme.of(context).cardTheme.margin?.horizontal ?? 0),
          ),
          onDismissed: (direction) => {onRemoveExpense(expenses[index])},
          child: ExpensesItem(expense: expenses[index])),
    );
  }
}
