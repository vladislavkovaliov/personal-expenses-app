import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.theme,
    required this.transaction,
  }) : super(key: key);

  final ThemeData theme;
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
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
}
