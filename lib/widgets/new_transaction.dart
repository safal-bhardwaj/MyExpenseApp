import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class new_transaction extends StatefulWidget {
  final Function addtx;

  new_transaction(this.addtx);

  @override
  State<new_transaction> createState() => _new_transactionState();
}

class _new_transactionState extends State<new_transaction> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController amountController = TextEditingController();
   DateTime selectedDate = DateTime.now() ;

  void submitData() {
    if(amountController.text.isEmpty)
      {
        return;
      }
    final enteredtitle = titleController.text;
    final enteredamount = double.parse(amountController.text);
    if (enteredtitle.isEmpty || enteredamount <= 0) {
      return;
    }

    widget.addtx(enteredtitle, enteredamount,selectedDate);
    Navigator.of(context).pop();
  }

  void preseDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return null;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                autofocus: true,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                autofocus: true,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Text(
                      selectedDate == null
                          ? 'No Date Chosen!'
                          : DateFormat.yMd().format(selectedDate),
                    ),
                    TextButton(
                      child: Text('Choose Date'),
                      style: TextButton.styleFrom(primary: Colors.blue),
                      onPressed: preseDatePicker,
                    )
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: submitData,
                  child: const Text('Add Transaction'),
                  style: ElevatedButton.styleFrom(primary: Colors.green))
            ],
          )),
    );
  }
}
