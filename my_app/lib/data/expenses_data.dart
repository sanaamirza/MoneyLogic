import 'dart:core';
import 'package:flutter/material.dart';
import '../dateTime/dateTime.dart';
import '../items/expenses.dart';

class ExpenseData extends ChangeNotifier{

  List<Expense> overallExpenseList = [];

  List <Expense> getAllExpenseList(){
    return overallExpenseList;
  }

  //adding an expense
  void addNewExpense(Expense newExpense){
   overallExpenseList.add(newExpense);
   notifyListeners();
  }


  //deleting an expense
  void deleteExpense(ExpenseData expense){
    overallExpenseList.remove(expense);
    notifyListeners();
  }

  //get the dates
  String getDayName(DateTime dateTime){
    switch(dateTime.weekday){
      case 1: return 'Mon';
      case 2: return 'Tue';
      case 3: return 'Wed';
      case 4: return 'Thurs';
      case 5: return 'Fri';
      case 6: return 'Sat';
      case 7: return 'Sun';
      default: return '';
    }
  }

  DateTime startOfWeekDate() {
    DateTime? startOfWeek;
    DateTime today = DateTime.now();
    for(int i = 0; i<7; i++){
      if(getDayName(today.subtract(Duration(days: i))) == 'Mon') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  //put data into chart
  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {
    };

    for(var expense in overallExpenseList){
      String date = convertDateTimeToString(expense.dateTime!);
      //String date = expense.dateTime.toString();
      //String date = expense.dateTime != null ? convertDateTimeToString(expense.dateTime!) : "";
      double amount = double.parse(expense.amount!);
      //double amount = expense.amount;

      if(dailyExpenseSummary.containsKey(date)){
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      }
      else{
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
}