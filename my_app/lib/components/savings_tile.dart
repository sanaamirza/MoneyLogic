import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class SavingsTile extends StatelessWidget {

  final String amount;
  final DateTime dateTime;

  const SavingsTile(
    {super.key,
    required this.amount,
    required this.dateTime
    });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(amount),
      subtitle: Text('${dateTime.day}-${dateTime.month}-${dateTime.year}')
    );
  }
}