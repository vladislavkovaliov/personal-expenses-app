import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/NewTransaction.dart';
import 'package:personal_expenses_app/widgets/TransactionsList.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({Key? key}) : super(key: key);

  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> transactions = [
    Transaction(
        id: '1', title: "new laptop", amount: 2500, date: DateTime.now()),
    Transaction(
        id: '1', title: "new iphone", amount: 1100, date: DateTime.now()),
    Transaction(id: '1', title: "new tv", amount: 500, date: DateTime.now()),
  ];

  void addTransaction(String title, double amount) {
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: DateTime.now());

    setState(() {
      transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(addTransaction),
        TransactionsList(transactions),
      ],
    );
  }
}
