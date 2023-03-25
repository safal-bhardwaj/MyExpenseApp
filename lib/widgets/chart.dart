import 'package:flutter/material.dart';
import 'package:transactions/widgets/Chart_Bar.dart';
import '../models/transaction.dart';
import 'Chart_Bar.dart';
import 'package:intl/intl.dart';

class chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTranscationsValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index),);

      double totalSum =0.0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year)
          {
            totalSum += recentTransactions[i].amount;
          }
      }


      return {
        'day': DateFormat.E().format(weekDay).substring(0,1),
        'amount': totalSum};
    });
  }

  double get totalSpending
  {
    return groupedTranscationsValue.fold(0.0,(sum,item)
    {
      return sum+(item['amount'] as double) ;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),

        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
              groupedTranscationsValue.map((data) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: Chart_Bar(data['day'] as String, data['amount'] as double,
                      totalSpending == 0.0 ? 0.0 : (data['amount'] as double)/totalSpending ),
                );
              }).toList()
          ),
        ));
  }
}
