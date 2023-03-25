import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'package:intl/intl.dart';


class transaction_list extends StatelessWidget {

  final List<Transaction> transaction;
  final Function deletetx;
  transaction_list(this.transaction,this.deletetx);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: 400,
        child:  transaction.isEmpty?  
            Column(

              children: [ Container(
                  margin: EdgeInsets.all(20),
                  child: Text('No Transations has been added')),

              Container(
                margin: EdgeInsets.all(20),
                height: 300,
                  child: Image.asset('images/pngwing.com.png'))
            ],): ListView(
        children: transaction.map((tx) {
          return Card(
              child: Row(children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 2 )
                 ,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    '\u{20B9} ${tx.amount.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.green),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx.title,
                      style:
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      DateFormat('yMMMMEEEEd').format(tx.date),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                new Spacer(),
                IconButton(onPressed: (){
                  deletetx(tx.id);
                }, icon: Icon(Icons.delete))
              ]));
        }).toList(),
    ),
      );
  }
}
