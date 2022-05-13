import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
    return const CupertinoApp(
      title: 'Personal Expenses',
      theme: CupertinoThemeData(
        primaryColor: Colors.blueAccent,
        textTheme: CupertinoTextThemeData(
            navTitleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20.0,
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
            textStyle: TextStyle(
              fontSize: 18,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
            )),
      ),

      // theme: ThemeData(
      //   primaryColor: Colors.blueAccent,
      //   fontFamily: 'Quicksand',
      //   textTheme: ThemeData.light().textTheme.copyWith(
      //         headline6: const TextStyle(
      //           fontFamily: 'OpenSans',
      //           fontSize: 18.0,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //   appBarTheme: const AppBarTheme(
      //     titleTextStyle: TextStyle(
      //       fontFamily: 'OpenSans',
      //       fontSize: 20.0,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      home: MyHomePage(title: 'Personal Expenses'),
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
    showCupertinoModalPopup(
      context: context,
      builder: (_) {
        return GestureDetector(
          child: NewTransaction(addTransaction),
          // child: Text('42'),
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          // behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = CupertinoNavigationBar(
      middle: Text(
        widget.title,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => startNewTransaction(context),
            child: const Icon(CupertinoIcons.add),
          ),
        ],
      ),
    );
    final mediaQuery = MediaQuery.of(context);

    return CupertinoPageScaffold(
      navigationBar: appBar as ObstructingPreferredSizeWidget,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    (Orientation.landscape == mediaQuery.orientation
                        ? 0.5
                        : 0.3),
                child: Chart(recentTransactions),
              ),
              SizedBox(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.7,
                child: TransactionsList(transactions, deleteTransaction),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
