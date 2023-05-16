import 'package:flutter/material.dart';
import 'package:my_app/charts/bar_graph.dart';
import 'package:my_app/dateTime/dateTime.dart';
import 'package:provider/provider.dart';

import '../data/expenses_data.dart';

class WeeklySummary extends StatelessWidget {
  final DateTime startOfWeek;
  const WeeklySummary({super.key, required this.startOfWeek});

  @override
  Widget build(BuildContext context) {
    //get date
    String monday  = convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String tuesday  = convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String wednesday  = convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String thursday  = convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String friday  = convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String saturday  = convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String sunday  = convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
      builder: (context, value, child) => SizedBox(
        height: 200,
        child: BarGraph(
          maxY: 100, 
          monAmount: value.calculateDailyExpenseSummary()[monday] ?? 0, 
          tueAmount: value.calculateDailyExpenseSummary()[tuesday] ?? 0, 
          wedAmount: value.calculateDailyExpenseSummary()[wednesday] ?? 0, 
          thursAmount: value.calculateDailyExpenseSummary()[thursday] ?? 0, 
          friAmount: value.calculateDailyExpenseSummary()[friday] ?? 0, 
          satAmount: value.calculateDailyExpenseSummary()[saturday] ?? 0, 
          sunAmount: value.calculateDailyExpenseSummary()[sunday] ?? 0
          )
      )
    );
  }
}