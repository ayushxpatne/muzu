import 'package:flutter/material.dart';
import 'package:expense_tracker/expenses.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 131, 197, 255));
var kDarkScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Color.fromARGB(255, 0, 0, 0),
);
void main() {
  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
      colorScheme: kDarkScheme,
      useMaterial3: true,
      appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kDarkScheme.secondaryContainer,
          foregroundColor: kDarkScheme.secondary),
      scaffoldBackgroundColor: kDarkScheme.secondaryContainer,
      // cardTheme: const CardTheme().copyWith(
      //     color: kDarkScheme.onSecondaryContainer,
      //     surfaceTintColor: kDarkScheme.onSecondary),
      textTheme: ThemeData().textTheme.copyWith(
            titleMedium: TextStyle(
                fontWeight: FontWeight.w700,
                color: kDarkScheme.onSecondaryContainer),
            bodyMedium: TextStyle(color: kDarkScheme.onSecondaryContainer),
          ),
      // iconTheme: IconThemeData(color: kDarkScheme.primaryContainer),
      snackBarTheme: const SnackBarThemeData().copyWith(
        backgroundColor: Colors.red,
        contentTextStyle:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        actionTextColor: Colors.white,
      ),
      // inputDecorationTheme: const InputDecorationTheme().copyWith(
      //   labelStyle: TextStyle(color: kDarkScheme.onSecondary),
      //   focusedBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: kDarkScheme.onSecondary)),
      //   enabledBorder: const UnderlineInputBorder(
      //     borderSide: BorderSide(color: Colors.white),
      //   ),
      // ),
    ),
    theme: ThemeData().copyWith(
      useMaterial3: true,
      colorScheme: kColorScheme,
      appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.secondaryContainer,
          foregroundColor: kColorScheme.secondary),
      scaffoldBackgroundColor: kColorScheme.secondaryContainer,
      // cardTheme: const CardTheme().copyWith(
      //     color: kColorScheme.onSecondaryContainer,
      //     surfaceTintColor: kColorScheme.onSecondary),
      textTheme: ThemeData().textTheme.copyWith(
            titleMedium: TextStyle(
                fontWeight: FontWeight.w700,
                color: kColorScheme.onSecondaryContainer),
            bodyMedium: TextStyle(color: kColorScheme.onSecondaryContainer),
          ),
      // inputDecorationTheme: const InputDecorationTheme().copyWith(
      //   labelStyle: TextStyle(color: kColorScheme.onSecondary),
      //   focusedBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: kColorScheme.onSecondary)),
      //   enabledBorder: const UnderlineInputBorder(
      //     borderSide: BorderSide(color: Colors.white),
      //   ),
      // ),
      // iconTheme: IconThemeData(color: kColorScheme.primaryContainer),
      snackBarTheme: const SnackBarThemeData().copyWith(
        backgroundColor: Colors.red,
        contentTextStyle:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        actionTextColor: Colors.white,
      ),
      // textButtonTheme: TextButtonThemeData(
      //   style: TextButton.styleFrom(
      //     foregroundColor: kColorScheme.onSecondary,
      //   ),
      // ),
    ),
    debugShowCheckedModeBanner: false,
    home: const Expenses(),
  ));
}
