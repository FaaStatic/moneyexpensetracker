import 'package:flutter/material.dart';
import 'package:habbitapp/util/list_habits.dart';

class Util {
  static final Util _util = Util._instance();

  factory Util() {
    return _util;
  }

  Util._instance();

  Widget iconHabit({required ListHabit value, bool fromCart = false}) {
    switch (value) {
      case ListHabit.healing:
        return Icon(
          Icons.travel_explore,
          size: 24,
          color: fromCart ? Colors.white : Colors.blue,
        );
      case ListHabit.carity:
        return Icon(
          Icons.supervisor_account_sharp,
          size: 24,
          color: fromCart ? Colors.white : Colors.pink,
        );
      case ListHabit.saving:
        return Icon(
          Icons.monetization_on,
          size: 24,
          color: fromCart ? Colors.white : Colors.green,
        );
      case ListHabit.work:
        return Icon(
          Icons.work_rounded,
          size: 24,
          color: fromCart ? Colors.white : Colors.amber,
        );
      default:
        return Icon(
          Icons.travel_explore,
          size: 24,
          color: fromCart ? Colors.white : Colors.blue,
        );
    }
  }

  Color colorHabit(ListHabit value) {
    switch (value) {
      case ListHabit.healing:
        return Colors.blue;
      case ListHabit.carity:
        return Colors.pink;
      case ListHabit.saving:
        return Colors.green;

      case ListHabit.work:
        return Colors.amber;
      default:
        return Colors.blue;
    }
  }
}
