import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  const NewTransaction(this.addTransaction, {Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  void submitData() {
    final title = titleController.text;
    final double amount;

    if (amountController.text.isEmpty) {
      amount = 0;
    } else {
      amount = double.parse(amountController.text);
    }

    if (title.isEmpty || amount <= 0) {
      return;
    }

    widget.addTransaction(
      title,
      amount,
      selectedDate,
    );

    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021, 1, 1),
      lastDate: DateTime.now(),
    ).then((pressedDate) {
      if (pressedDate == null) return;

      setState(() {
        selectedDate = pressedDate;
      });
    });
  }

  TextField buildTextFieldAmount() {
    return TextField(
      controller: amountController,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
      decoration: const InputDecoration(
        labelText: 'Amount',
      ),
    );
  }

  TextField buildTextFieldTitle() {
    return TextField(
      controller: titleController,
      decoration: const InputDecoration(
        labelText: 'Title',
      ),
    );
  }

  TextButton buildPresentDatePickerButton(ThemeData theme) {
    return TextButton(
      onPressed: () => presentDatePicker(),
      child: Text(
        "Choose Date",
        style: TextStyle(
          color: theme.primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  TextButton buildAddTransactionTextButton() {
    return TextButton(
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.black87,
        primary: const Color.fromARGB(255, 56, 131, 245),
        minimumSize: const Size(88, 36),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
      ),
      onPressed: submitData,
      child: const Text(
        'Add Transaction',
        style: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Card(
        elevation: 4.0,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: mediaQuery.viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              buildTextFieldTitle(),
              buildTextFieldAmount(),
              SizedBox(
                height: 80,
                child: Row(
                  children: [
                    Text(
                      DateFormat.yMd().format(selectedDate),
                    ),
                    buildPresentDatePickerButton(theme)
                  ],
                ),
              ),
              buildAddTransactionTextButton(),
            ],
          ),
        ),
      ),
    );
  }
}
