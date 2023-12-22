import 'package:habbitapp/util/list_habits.dart';

class HabitModel {
  final String title;
  final String money;
  final ListHabit type;
  final String time;

  HabitModel({required this.title, required this.money, required this.type, required this.time});
}
