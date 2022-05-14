import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/chart.dart';
import 'package:personal_expenses_app/widgets/new_transaction.dart';
import 'package:personal_expenses_app/widgets/transactions_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const MyHomePage(title: 'Personal Expenses'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [
    // Transaction(
    //   id: '1',
    //   title: "new laptop",
    //   amount: 2500,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: '1',
    //   title: "new iphone",
    //   amount: 1100,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: '1',
    //   title: "new tv",
    //   amount: 500,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get recentTransactions {
    return transactions
        .where(
          (element) => element.date.isAfter(
            DateTime.now().subtract(
              const Duration(
                days: 7,
              ),
            ),
          ),
        )
        .toList();
  }

  void addTransaction(String title, double amount, DateTime date) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    );

    setState(() {
      transactions.add(newTransaction);
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((x) => x.id == id);
    });
  }

  void startNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          child: NewTransaction(addTransaction),
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
      ),
      actions: [
        GestureDetector(
          child: const Icon(Icons.add),
          onTap: () => startNewTransaction(context),
        ),
      ],
    );
  }

  SizedBox buildTransactionsList(MediaQueryData mediaQuery, AppBar appBar) {
    return SizedBox(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionsList(transactions, deleteTransaction),
    );
  }

  SizedBox buildChart(MediaQueryData mediaQuery, AppBar appBar) {
    return SizedBox(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          (Orientation.landscape == mediaQuery.orientation ? 0.5 : 0.3),
      child: Chart(recentTransactions),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = buildAppBar(context);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildChart(mediaQuery, appBar),
            buildTransactionsList(mediaQuery, appBar),
          ],
        ),
      ),
    );
  }
}
