import 'dart:core';
import 'package:flutter/material.dart';
import '../dateTime/dateTime.dart';
import '../items/expenses.dart';
import '../items/savings.dart';
import '../windows/savingsView.dart';

class SavingsData extends ChangeNotifier{

  List<Savings> overallSavingsList = [];

  List <Savings> getAllSavingsList(){
    return overallSavingsList;
  }

  //adding a new savings
  void addNewSavings(Savings newSavings){
   overallSavingsList.add(newSavings);
   notifyListeners();
  }


  //deleting a savings
  void deleteSavings(SavingsData saving){
    overallSavingsList.remove(saving);
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


}