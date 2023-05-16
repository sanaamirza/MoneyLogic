import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'home.dart';

class SalaryCalc extends StatefulWidget {
  const SalaryCalc({super.key});

  @override
  State<SalaryCalc> createState() => _SalaryCalcState();
}

class _SalaryCalcState extends State<SalaryCalc> {
  @override
  Widget build(BuildContext context) {
    final salaryController = TextEditingController();
    final taxController = TextEditingController();
    final takeHomeController = TextEditingController();
    var size = MediaQuery.of(context).size;
    double cal;
    double result;
    double salary;
    double tax;
    double sum;

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
          },
      ),
    ],
  ),
  body: SingleChildScrollView(
  child: Container(
    child: Column(
      children: [
        SizedBox(height:15),
        Text("Salary Calculator", style: TextStyle(
          fontSize: 30, 
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 45, 64, 89))),
        SizedBox(
          height: 15,
        ),
        TextField(
          controller: salaryController,
          decoration: InputDecoration(
            labelText: 'Salary',
            labelStyle: TextStyle(fontSize: 15, color: Colors.grey.shade400),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
          )
        ),
        SizedBox(height: 15),

        TextField(
          controller: taxController,
          decoration: InputDecoration(
            labelText: 'Tax',
            labelStyle: TextStyle(fontSize: 15, color: Colors.grey.shade400),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
          )
        ),
        SizedBox(height: 15),

        TextField(
          controller: takeHomeController,
          decoration: InputDecoration(
            labelText: 'Take Home Pay',
            labelStyle: TextStyle(fontSize: 15, color: Colors.grey.shade400),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
          )
        ),
        SizedBox(height: 15),

        GestureDetector(
          onTap: (){
            
            salary = double.parse(salaryController.text);

            if(salary <= 12500){
              tax = 0;
            }

            else if(salary <= 50000){
              tax = (salary - 12500) * 0.20;
            }

            else if(salary <= 150000){
              tax = (salary - 50000) * 0.40 + 7500;
            }

            else{
              tax = (salary - 150000) * 0.45 + 48750;
            }

            result = salary - tax;
            taxController.text = '£' + tax.toString();
            takeHomeController.text = '£' + result.toString();


          },

          child: Container(
            alignment: Alignment.center,
            height: size.height / 14,
            width: size.width,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 45, 64, 89), 
              borderRadius: BorderRadius.circular(5)
            ),
            child: Text(
              "Calculate",
              style:TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold)),  

              )

        )

      ],
    ),
  ),)
);
    
    
  }
}



