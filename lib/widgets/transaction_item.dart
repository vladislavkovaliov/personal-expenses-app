import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:personal_expenses_app/models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.theme,
    required this.transaction,
    required this.deleteTransaction,
  }) : super(key: key);

  final ThemeData theme;
  final Transaction transaction;
  final Function deleteTransaction;

  Card buildLeading() {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: theme.primaryColor,
            width: 2,
          ),
        ),
        child: SizedBox(
          width: 90,
          child: FittedBox(
            child: Text(
              '\$${transaction.amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: theme.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconButton buildTrailing() {
    return IconButton(
      icon: const Icon(
        Icons.delete,
      ),
      color: theme.errorColor,
      onPressed: () => deleteTransaction(transaction.id),
    );
  }

  Text buildSubtitle() {
    return Text(
      DateFormat.yMMMd().format(transaction.date),
      style: const TextStyle(
        color: Colors.grey,
      ),
    );
  }

  Text buildTitle() {
    return Text(
      transaction.title,
      style: theme.textTheme.headline6,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: buildLeading(),
      title: buildTitle(),
      subtitle: buildSubtitle(),
      trailing: buildTrailing(),
    );
  }
}
