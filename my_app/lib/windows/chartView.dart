import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:my_app/components/expense_tile.dart';
import 'package:my_app/components/weekly_summary.dart';
import 'package:my_app/windows/home.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../data/expenses_data.dart';
import '../items/expenses.dart';
import '../items/users.dart';

class ChartView extends StatefulWidget {
  //final String? userId;
  //const ChartView({Key? key, this.userId}) : super(key: key);
  const ChartView({Key? key}) : super(key: key);

  @override
  State<ChartView> createState() => _ChartViewState();

void deleteExpense() {
  _ChartViewState().deleteExpense();
}
}

class _ChartViewState extends State<ChartView> {

//uploading to firestore
  //final firebase_authentication = FirebaseAuth.instance;
  final expense = FirebaseFirestore.instance
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser?.uid)
    .collection('expense');
  final newExpenseNameController = TextEditingController();
  final newExpensePoundController = TextEditingController();
  final newExpensePennyController = TextEditingController();
  List<String> categories = <String>['Food', 'Housing', 'Bills', 'Transportation', 'Other'];
  String? currentCategory = 'Food';
  //final newExpenseCategoryController = TextEditingController();


  //uploading to firestore
  /**Future uploadExpense(String name, String pound, String penny) async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Reference reference = FirebaseStorage.instance
    .ref()
    .child('${widget.userId}/expenses');
    //.child('post_')

    await firebaseFirestore
    .collection("users")
    .doc(widget.userId)
        .collection("expenses")
        .add({'expenseName': newExpenseNameController.text});
    
  }**/



  void addNewExpense() {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text("Add new expense"),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(
          controller: newExpenseNameController,
          decoration: InputDecoration(hintText: "Expense Name"),),
        Row(children: [
          Expanded(child: TextField(
            controller: newExpensePoundController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "Pounds"),)),
          Expanded(child: TextField(
            controller: newExpensePennyController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "Pence"),))
        ],),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(hintText: "Category"),
          //value: currentCategory,
          items: categories.map(
            (category) => DropdownMenuItem<String>(
              value: category,
              child: Text(category)
            )).toList(),
          onChanged: (category) => setState(() => currentCategory = category),
        )

      ]),
      actions: [
        MaterialButton(
          onPressed: save,
          child: Text("Submit")),
        MaterialButton(
          onPressed: cancel,
          child: Text("Cancel")),
      ],
    ));
  }


//delete an expense
void deleteExpense() async {
  User? user = FirebaseAuth.instance.currentUser;
  final expense = FirebaseFirestore.instance
      .collection("users")
      .doc(user!.uid)
      .collection("expenses");

   //ExpenseData expenseToDelete = Provider.of<ExpenseData>(context, listen: false).getAllExpenseList()[] as ExpenseData;
   //ExpenseData expenseToDelete = expense;
      
  
  //await expense.doc(Provider.of<ExpenseData>(context, listen: false).getAllExpenseList()[].uid).delete();

  //Provider.of<ExpenseData>(context, listen: false).deleteExpense(expenseToDelete);
}

  //save button
  void save(){
    User? user = FirebaseAuth.instance.currentUser;
    final expense = FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("expenses");
    
    expense.add({
      'expenseName': newExpenseNameController.text,
      'amount': newExpensePoundController.text + '.' + newExpensePennyController.text,
      'dateTime': DateTime.now(),
    });


    String amount = newExpensePoundController.text + '.' + newExpensePennyController.text;
    Expense newExpense = Expense(
      expenseName: newExpenseNameController.text, 
      amount: amount, 
      dateTime: DateTime.now(),
      currentCategory: currentCategory
      );
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);


    Navigator.pop(context);
    clear();
  }

  //cancel button
  void cancel (){
    Navigator.pop(context);
    clear();
  }

  //clear input screen
  void clear() {
    newExpenseNameController.clear();
    newExpensePoundController.clear();
    newExpensePennyController.clear();
  }

//scaffold
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Image.asset("assets/Logo_Name.png", fit: BoxFit.cover, height: 58,),
          backgroundColor: Color.fromARGB(255, 45, 64, 89),
          actions: [
            IconButton(
              icon: const Icon(Icons.home),
              tooltip: "Home Page",
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
              },)
          ],
        ),
        backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: addNewExpense,
        backgroundColor: Color.fromARGB(255, 45, 64, 89),
        child: Icon(Icons.add),
        ),
        body: ListView(children: [
          WeeklySummary(startOfWeek: value.startOfWeekDate()),
          const SizedBox(
            height: 20, 
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: value.getAllExpenseList().length,
            itemBuilder: (context, index) => ExpenseTile(
              expenseName: value.getAllExpenseList()[index].expenseName.toString(), 
              amount: value.getAllExpenseList()[index].amount.toString(), 
              dateTime: value.getAllExpenseList()[index].dateTime!,
              category: value.getAllExpenseList()[index].currentCategory,
              )
              )
        ],)
      ),
      );
  }

/**postDataToFirestore() async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = firebase_authentication.currentUser;
    UserGroup userGroup = UserGroup();

    userGroup.email = user!.email;
    userGroup.uid = user.uid;
    userGroup.expenseName = newExpenseNameController.text;
    //userGroup.pound = newExpensePoundController.text;
    //userGroup.penny = newExpensePennyController.text;

    await firebaseFirestore.collection("users").doc(user.uid).set(userGroup.toMap());


    Fluttertoast.showToast(msg: "Succesfully Added!");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => ChartView()),
        (route) => false);


}**/
}

//expenseName: value.getAllExpenseList()[index].expenseName, 
  //            amount: value.getAllExpenseList()[index].amount, 
    //          dateTime: value.getAllExpenseList()[index].dateTime