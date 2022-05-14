import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/transaction_item.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  const TransactionsList(this.transactions, this.deleteTransaction, {Key? key})
      : super(key: key);

  Text buildNoTransactions(ThemeData theme) {
    return Text(
      'No transactions added yet!',
      style: theme.textTheme.headline6,
    );
  }

  SizedBox buildWaiting(BoxConstraints constraints, MediaQueryData mediaQuery) {
    return SizedBox(
      height: constraints.maxHeight *
          (mediaQuery.orientation == Orientation.landscape ? 0.3 : 0.6),
      child: Image.asset(
        'assets/images/waiting.png',
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);

    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(builder: ((context, constraints) {
              return Column(
                children: <Widget>[
                  buildNoTransactions(theme),
                  const SizedBox(
                    height: 20,
                  ),
                  buildWaiting(constraints, mediaQuery),
                ],
              );
            }))
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return TransactionItem(
                  key: ValueKey(transactions[index].id.toString()),
                  theme: theme,
                  transaction: transactions[index],
                  deleteTransaction: deleteTransaction,
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
