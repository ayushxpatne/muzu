import 'package:expense_tracker/model/expenses_model.dart';
import 'package:flutter/material.dart';

class ExpensesListCard extends StatelessWidget {
  const ExpensesListCard(this.expensesModelList, {super.key});

  final ExpenseDataModel expensesModelList;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  expensesModelList.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'Rs.${expensesModelList.amount.toString()}',
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(categoryIcons[expensesModelList.category] as String),
                Text(expensesModelList.formattedDate),
              ],
            )
          ],
        ),
      ),
    );
  }
}

