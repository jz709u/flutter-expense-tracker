import 'package:expense_tracking_app/Screens/new_expense_widget.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracking_app/Model/expense.dart';
import 'package:expense_tracking_app/Components/expenses_list.dart';

final kColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.green,
);

final kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  runApp(const ExpenseAppMaterial());
}

class ExpenseAppMaterial extends StatelessWidget {
  const ExpenseAppMaterial({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
            disabledBackgroundColor: Colors.red[100],
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.w500,
                color: kColorScheme.onSecondaryContainer,
                fontSize: 17,
              ),
            ),
      ),
      themeMode: ThemeMode.system,
      home: const ExpenseApp(),
    );
  }
}

class ExpenseApp extends StatefulWidget {
  const ExpenseApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpenseAppState();
  }
}

class _ExpenseAppState extends State<ExpenseApp> {
  final List<Expense> expenses = [
    Expense(
      title: "Gas",
      amount: 10.00,
      category: Category.travel,
      date: DateTime.now().add(const Duration(days: 1)),
    ),
    Expense(
      title: "Chipotle",
      amount: 5.00,
      category: Category.food,
      date: DateTime.now().add(const Duration(days: 2)),
    ),
    Expense(
      title: "Workday",
      amount: 15.00,
      category: Category.work,
      date: DateTime.now().add(const Duration(days: 3)),
    ),
    Expense(
      title: "Movie Tickets",
      amount: 10.00,
      category: Category.leisure,
      date: DateTime.now().add(const Duration(days: 4)),
    ),
  ];

  _addExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  _removeExpense(Expense expense) {
    final removedIndex = expenses.indexOf(expense);
    setState(() {
      expenses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Expense Deleted"),
        duration: const Duration(seconds: 1),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              expenses.insert(removedIndex, expense);
            });
          },
        ),
      ),
    );
  }

  _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpenseWidget(
            didAddExpense: _addExpense,
          );
        });
  }

  Widget _scaffoldContent() {
    Widget mainContent = const Center(
      child: Text("No Expenses Found please add some"),
    );
    if (expenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: expenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: mainContent,
        )
      ],
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      actions: [
        IconButton(
          onPressed: _openAddExpenseOverlay,
          icon: const Icon(Icons.add),
        ),
      ],
      title: const Text("Expense App"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _scaffoldContent(),
    );
  }
}
