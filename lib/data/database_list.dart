import 'dart:convert';
import 'dart:io';

File jsonFile = File('/Users/ayushpatne/Documents/Flutter/expense_tracker/lib/data/transaction2.json');
String jsonContent = jsonFile.readAsStringSync();

List<dynamic> databaseList = json.decode(jsonContent);
