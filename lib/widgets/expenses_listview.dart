import 'package:expense_tracker/widgets/expenses_list_card_view.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expenses_model.dart';


class ShowExpensesListView extends StatelessWidget {
  const ShowExpensesListView(
      {super.key, required this.expensesdb, required this.onRemoveExpense});

  final List<ExpenseDataModel> expensesdb;
  final void Function(ExpenseDataModel expenseToBeRemoved) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expensesdb.length,
      // reverse: true,
      itemBuilder: ((context, index) {
        int reverseIndex = expensesdb.length - index - 1;
        return Dismissible(
          resizeDuration: const Duration(seconds: 1),
          background: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error,
                borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            child: Center(
              child: Text(
                'Expense Deleted',
                style: TextStyle(color: Theme.of(context).colorScheme.onError),
              ),
            ),
          ),
          onDismissed: (direction) {
            onRemoveExpense(expensesdb[reverseIndex]);
          },
          key: ValueKey(expensesdb[reverseIndex]),
          child: ExpensesListCard(expensesdb[reverseIndex]),
        );
      }),
    );
  }
}

