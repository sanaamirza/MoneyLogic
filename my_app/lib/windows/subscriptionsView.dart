import 'dart:ffi';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Subscriptions extends StatefulWidget {
  const Subscriptions({super.key});

  @override
  State<Subscriptions> createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {

  List<Map<String, dynamic>> subscriptions = [];
  

  void addSubscription(String subscription, double amount){
    setState(() {
      subscriptions.add({
        'subscription': subscription,
        'amount': amount,
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    String? subscription;
    double? amount;

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
      body: ListView.builder(
        itemCount: subscriptions.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(subscriptions[index]['subscription']),
            subtitle: Text('£${subscriptions[index]['amount'].toString()}'),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(onPressed: (){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String? subscription;
              double? amount;
              final formKey = GlobalKey<FormState>();
              return AlertDialog(
                title: Text('Enter a subscription and amount'),
                content: Form(
                  key: formKey,
                  child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Subscription',
                      ),
                      onSaved: (newSubscription) {
                        subscription = newSubscription!;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Amount',
                      ),
                      keyboardType: TextInputType.number,
                      onSaved: (newAmount) {
                        amount = double.tryParse(newAmount ?? "") ?? 0.0;
                      },
                    ),
                  ],
                ),
                ),
                actions: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),

                  MaterialButton(
                    onPressed: () {
                      final form = formKey.currentState;
                      if (form!.validate()) {
                        form.save();
                        if (subscription != null && amount != null) {
                          addSubscription(subscription!, amount!);
                          Navigator.of(context).pop(subscriptions);
                        }
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: Color.fromARGB(255, 45, 64, 89),
        child: Icon(Icons.add),
      ),
    );
  }

  List<Map<String, dynamic>> getSubscriptions() {
    return subscriptions;
  }

}


