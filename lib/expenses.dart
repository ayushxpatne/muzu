// ignore: file_names
// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:expense_tracker/model/expenses_model.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses_listview.dart';
import 'package:expense_tracker/widgets/add_expense_page.dart';
import 'package:expense_tracker/data/database_list.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/chat_screen.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List<ExpenseDataModel> expensesDBList = databaseList.map((data) {
    return ExpenseDataModel(
        title: data['title'],
        amount: double.parse(data['amount']),
        date: DateFormat('E, MMM d, yyyy').parse(data['date']),
        category: parseCategory(data['category']));
  }).toList();

  void _onPressAddExpenseButton() {
    //opens overlay
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return AddNewExpense(
            onAddExpense: _addExpense,
          );
        });
  }

  void _addExpense(ExpenseDataModel newExpenseEntry) {
    setState(
      () {
        expensesDBList.add(newExpenseEntry);
      },
    );
  }

  void _removeExpense(ExpenseDataModel removeExpenseEntry) {
    int indexOfRemovedExpense = expensesDBList.indexOf(removeExpenseEntry);
    setState(
      () {
        expensesDBList.remove(removeExpenseEntry);
      },
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 233, 112, 103),
        duration: const Duration(seconds: 3),
        content: const Text(
          'Record Deleted',
        ),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                expensesDBList.insert(
                    indexOfRemovedExpense, removeExpenseEntry);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No Records Found"),
    );

    if (expensesDBList.isNotEmpty) {
      mainContent = ShowExpensesListView(
        expensesdb: expensesDBList,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('muzu',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28)),
        actions: [
          IconButton(
            onPressed: _onPressAddExpenseButton,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: mainContent,
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatScreen()),
          );
        },
        child: const Text('Chat'),
      ),
    );
  }
}

// ElevatedButton(
//           onPressed: () async {
//             // Make a POST request to the Flask API
//             var response = await http.post(
//               Uri.parse('http://127.0.0.1:5000//predict'),
//               headers: {'Content-Type': 'application/json'},
//               body: jsonEncode({'month': 12}),  // Example input feature
//             );

//             if (response.statusCode == 200) {
//               var data = jsonDecode(response.body);
//               var prediction = data['prediction'];
//               // Handle the prediction in your app
//               print('Predicted value: $prediction');
//             } else {
//               print('Error fetching prediction: ${response.statusCode}');
//             }
//           },
//           child: Text('Get Prediction'),
//         ),
      