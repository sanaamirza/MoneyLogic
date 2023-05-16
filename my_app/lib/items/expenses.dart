import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/items/users.dart';

class Expense{
  String? uid;
  String? expenseName;
  String? amount;
  DateTime? dateTime;
  String? currentCategory;

  Expense({this.uid, this.expenseName, this.amount, this.dateTime, required this.currentCategory});

  factory Expense.fromMap(map){
    return Expense(
      uid: map['uid'],
      expenseName: map['expenseName'], 
      amount: map['amount'], 
      dateTime: map['dateTime'],
      currentCategory: map['currentCategory']);
  }

   Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'expenseName': expenseName,
      'amount': amount,
      'dateTime': dateTime,
      'currentCategory' : currentCategory

    };
  }

  //factory Expense.fromMap(map){
   // return Expense(
   //   name: data['name'], 
     // amount: data['amount'], 
   //   dateTime: data['dateTime']);
  //}

 //Map<String, dynamic> toMap(){
   // return{
     // 'name': name,
      //'amount': amount,
      //'dateTime': dateTime
    //} ; 

  //}


}