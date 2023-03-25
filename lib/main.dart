import 'dart:io';


import 'package:flutter/material.dart';
import 'package:transactions/widgets/new_transaction.dart';
import 'package:transactions/widgets/user_transaction.dart';
import '../models/transaction.dart';
import 'package:transactions/widgets/transaction_list.dart';
import 'widgets/chart.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final List<Transaction> transactions = [

  ];

  List<Transaction> get recentTransactions
  {
    return transactions.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount , DateTime chosenDate) {
    final tx = Transaction(
        DateTime.now().toString(),
        txTitle,
        txAmount,
        chosenDate);
    setState(() {
      transactions.add(tx);
      print(transactions);
    });
  }

  void startAddNewTransaction(BuildContext ctx )
  {
    showModalBottomSheet(context: ctx, builder: (_) {
      return GestureDetector(
        onTap: ()=>{} ,
       child: new_transaction(_addNewTransaction) ,
      behavior: HitTestBehavior.opaque,);
    } );
  }
  
  void deleteTransaction(String id)
  {
    setState(() {
      transactions.removeWhere((tx){
        return tx.id == id;
      });
    });

  }

  @override
  Widget build(BuildContext context) {

    final appBar = AppBar(
      title: const Text('My Expenses'),
      actions: [IconButton(onPressed:  ()=>{startAddNewTransaction(context)}, icon: Icon(Icons.add))],
    );
    return Scaffold(
      appBar: appBar,
      body: ListView(
            children:  <Widget>[
              Container(height : (MediaQuery.of(context).size.height - appBar.preferredSize.height -MediaQuery.of(context).padding.top )*0.25 ,child: chart(recentTransactions)),
              Container(height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top)*0.75,child: transaction_list (transactions, deleteTransaction))
            ],
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isAndroid ? FloatingActionButton(child: Icon(Icons.add), onPressed: ()=>{startAddNewTransaction(context)},) : Container(),
    );
  }
}
