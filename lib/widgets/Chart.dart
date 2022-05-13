import 'package:flutter/material.dart'; // ignore: file_names
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions, {Key? key}) : super(key: key);

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(
          days: index,
        ),
      );

      double totalSum = 0.0;

      for (var element in recentTransactions) {
        final isSameDay = element.date.day == weekDay.day;
        final isSameMonth = element.date.month == weekDay.month;
        final isSameYear = element.date.year == weekDay.year;

        if (isSameYear && isSameMonth && isSameDay) {
          totalSum += element.amount;
        }
      }

      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalSum,
      };
    });
  }

  double get totalSpending {
    return groupedTransactionsValues.fold(0.0, (acc, element) {
      return acc + (element["amount"] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionsValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data["day"] as String,
                data["amount"] as double,
                totalSpending == 0.0
                    ? 0.0
                    : (data["amount"] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
