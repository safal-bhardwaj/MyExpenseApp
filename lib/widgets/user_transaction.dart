import 'dart:ffi';

import 'package:flutter/material.dart';
import 'new_transaction.dart';
import 'transaction_list.dart';
import '../models/transaction.dart';

class user_transaction extends StatefulWidget {
  const user_transaction({Key? key}) : super(key: key);

  @override
  State<user_transaction> createState() => _user_transactionState();
}

class _user_transactionState extends State<user_transaction> {
  final List<Transaction> transaction = [
    Transaction('t1', 'Shoes', 1000, DateTime.now()),
    Transaction('t2', 'Dress', 5000, DateTime.now()),
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final tx = Transaction(
        DateTime.now().toString(),
        txTitle,
        txAmount,
        DateTime.now());
    setState(() {
      transaction.add(tx);
      print(transaction);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[new_transaction(_addNewTransaction)],
    );
  }
}
