import 'package:flutter/material.dart';
import 'package:my_app/data/expenses_data.dart';
import 'package:provider/provider.dart';
import '../windows/chartView.dart';


class ExpenseTile extends StatelessWidget {

  final String expenseName;
  final String amount;
  final DateTime dateTime;
  final String? category;

  const ExpenseTile({
    super.key, 
    required this.expenseName, 
    required this.amount, 
    required this.dateTime, 
    required this.category});

  @override
  Widget build(BuildContext context) {
    
    ChartView chartView = ChartView();
    ExpenseData expenseData = ExpenseData();

    return ListTile(
      title: Text(expenseName),
      subtitle: Text('${dateTime.day}-${dateTime.month}-${dateTime.year} | $category'),
      trailing: Text('£$amount'),
      leading: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Delete Expense"),
              content: Text("Are you sure you want to delete this expense?"),
              actions: [
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: Text("Delete"),
                  onPressed: () {
                    //Provider.of<_ChartViewState>(context, listen: false).deleteExpense(index);
                    ExpenseData expenseData = Provider.of<ExpenseData>(context, listen: false);
                   // ExpenseData expenseToDelete = expenseData.getAllExpenseList()[index] as ExpenseData;
                    //expenseData.deleteExpense(expenseToDelete);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      )
    );
  }
}