import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:awesome_circular_chart/awesome_circular_chart.dart';

import 'home.dart';

class Savings extends StatefulWidget {
  const Savings({super.key});

  @override
  State<Savings> createState() => _SavingsState();
}

class _SavingsState extends State<Savings> {

  final definedSize = Size(400, 400);
  double value = 0;
  final newSavingsController = TextEditingController();
  final savingsGoalController = TextEditingController();

 
  final GlobalKey<AnimatedCircularChartState> key = GlobalKey<AnimatedCircularChartState>();

//add savings function
  void addSaving(){
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text("Add new savings amount"),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(children: [
          Expanded(child: TextField(
            controller: newSavingsController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "Amount"),)),
        ],)
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


  void save(){
    setState(() {
      value += double.parse(newSavingsController.text);
      List<CircularStackEntry> data = chartData(value);
      key.currentState?.updateData(data);
    });
  }

  void cancel (){
    Navigator.pop(context);
    clear();
  }

   void clear() {
    newSavingsController.clear();
  }

  List<CircularStackEntry> chartData(double value){

    double goal = 0;
    if(savingsGoalController.text != null && savingsGoalController.text.trim().isNotEmpty && RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$').hasMatch(savingsGoalController.text.trim())) {
      goal = double.parse(savingsGoalController.text.trim());
    }

   // double goal = double.parse(savingsGoalController.text);
   //double max = goal > value ? goal : value;
   double percentage = value / (goal > 0 ? goal : 1) * 100;
    Color color = Color.fromARGB(255, 45, 64, 89);
    List<CircularStackEntry> data = <CircularStackEntry>[
      CircularStackEntry(<CircularSegmentEntry>[
        CircularSegmentEntry(percentage, color, rankKey: 'Percentage')
      ],
      rankKey: 'Percentage'
      )
    ];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: Column(
          children: [
            TextField(
              controller: savingsGoalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Current Savings Goal (£)'
              ),
            ),
            Center(
              child: AnimatedCircularChart(
                key: key,
                size: definedSize,
                initialChartData: chartData(value),
                holeLabel: '£$value' + '0',
                percentageValues: true,
                edgeStyle: SegmentEdgeStyle.round,
                chartType: CircularChartType.Radial,
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 64,
                  fontWeight: FontWeight.bold),
                ),
           ),

           


          ],),
        
        floatingActionButton: FloatingActionButton(
        onPressed: (addSaving),
        backgroundColor: Color.fromARGB(255, 45, 64, 89),
        child: Icon(Icons.add),
        ),
    );
  }
}