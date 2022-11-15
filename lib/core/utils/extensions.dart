import 'package:flutter/material.dart';
import 'package:flutter_challenge/core/utils/colors.dart';

extension CustomContext on BuildContext {
  double screenHeight([double percent = 1]) =>
      MediaQuery.of(this).size.height * percent;

  double screenWidth([double percent = 1]) =>
      MediaQuery.of(this).size.width * percent;

  void showError(String str) {
    final snackBar = SnackBar(
      elevation: 0,
      content: Text(
        '🚨 $str',
        style: const TextStyle(
          fontSize: 16,
          color: kNeutral950,
          fontWeight: FontWeight.w500,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(92),
      ),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      dismissDirection: DismissDirection.up,
    );
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}

extension ListExtensions<E> on List<E> {
  bool get containsDuplicates => getDuplicates().length > 1;

  List<E> removeAll(Iterable<E> allToRemove) {
    for (final element in allToRemove) {
      remove(element);
    }
    return this;
  }

  bool containsAny(Iterable<E> collection) {
    for (final element in collection) {
      if (contains(element)) return true;
    }
    return false;
  }

  List<E> getDuplicates() => removeAll(toSet().toList());
}
