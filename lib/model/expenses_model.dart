import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final dateFormatter = DateFormat.yMMMEd('en_US');

enum Category { food, entertainment, transportation, shopping, fitness, other }

const categoryIcons = {
  Category.food: 'Food',
  Category.entertainment: 'Entertainment',
  Category.transportation: 'Transport',
  Category.shopping: 'Shopping',
  Category.fitness: 'Fitness',
  Category.other: 'Misc',
};

class ExpenseDataModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  ExpenseDataModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  String get formattedDate {
    return dateFormatter.format(date);
  }
}

Category parseCategory(String categoryString) {
  switch (categoryString.toLowerCase()) {
    case 'food':
      return Category.food;
    case 'entertainment':
      return Category.entertainment;
    case 'transportation':
      return Category.transportation;
    case 'shopping':
      return Category.shopping;
    case 'fitness':
      return Category.fitness;
    case 'other':
      return Category.other;
    default:
      throw ArgumentError('Invalid category string: $categoryString');
  }
}
