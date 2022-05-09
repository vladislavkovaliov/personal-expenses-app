import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionsList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.0,
      child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (ctx, index) {
            return Card(
              child: Row(children: [
                Container(
                  width: 100.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueAccent,
                      width: 1.0,
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: Center(
                    child: Text(
                        '\$${transactions[index].amount.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.blueAccent)),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transactions[index].title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    Text(
                      DateFormat('yyyy-mm-dd').format(transactions[index].date),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                )
              ]),
            );
          }),
    );
  }
}
