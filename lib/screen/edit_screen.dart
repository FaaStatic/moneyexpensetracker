import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:habbitapp/main.dart';
import 'package:habbitapp/model/habit_model.dart';
import 'package:habbitapp/util/list_habits.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _controlTitle = TextEditingController();
  final _controlMoney = TextEditingController();
  String moneyHabit = "0";
  String titleHabit = "";
  String timeInput = "";
  ListHabit typeHabit = ListHabit.healing;

  void addMoney() {
    setState(() {
      moneyHabit = _controlMoney.text;
    });
  }

  void addTitle() {
    setState(() {
      titleHabit = _controlTitle.text;
    });
  }

  void showDate() async {
    if (Platform.isIOS) {
    } else {
      await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        initialDate: DateTime.now(),
      ).then((value) {
        if (value != null) {
          setState(() {
            timeInput = DateFormat("dd MMMM yyyy, hh:mm:ss").format(value);
          });
        }
      });
    }
  }

  @override
  void initState() {
    _controlTitle.addListener(addTitle);
    _controlMoney.addListener(addMoney);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        timeInput = DateFormat("dd MMMM yyyy, HH:mm:ss").format(DateTime.now());
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controlMoney.dispose();
    _controlTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Add Expense",
          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        width: widthScreen,
        height: heightScreen,
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Gap(24),
            const Text("Goal expense & amount money  Input:",
                style: TextStyle(fontSize: 12, color: Colors.black)),
            const Gap(16),
            SizedBox(
              width: widthScreen,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 52,
                      decoration: const BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        controller: _controlTitle,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Goal expense",
                          contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                      ),
                    ),
                  ),
                  const Gap(25),
                  Expanded(
                    child: Container(
                      height: 52,
                      decoration: const BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        controller: _controlMoney,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Money Expense",
                          contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(24),
            const Text("Date Input:", style: TextStyle(fontSize: 12, color: Colors.black)),
            const Gap(16),
            InkWell(
              onTap: () {
                showDate();
              },
              child: Container(
                width: widthScreen,
                height: 52,
                padding: const EdgeInsets.only(left: 28),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(timeInput, style: const TextStyle(fontSize: 14, color: Colors.black))
                  ],
                ),
              ),
            ),
            const Gap(24),
            Container(
              width: widthScreen,
              height: 52,
              padding: const EdgeInsets.only(left: 18, right: 18),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.white),
              child: DropdownButton<ListHabit>(
                underline: const SizedBox(),
                isExpanded: true,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                value: typeHabit,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      typeHabit = value;
                    });
                  }
                },
                hint: const Text(
                  "Choose Type",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                items: ListHabit.values
                    .map((item) => DropdownMenuItem<ListHabit>(
                          value: item,
                          child: Text(
                            item.name,
                            style: const TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ))
                    .toList(),
              ),
            ),
            const Gap(24),
            ElevatedButton(
                onPressed: () {
                  if (titleHabit.isEmpty || moneyHabit.isEmpty) {
                    Future.delayed(const Duration(milliseconds: 1000), () {
                      keyScaffold.currentState!.showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Fill Full Data First!"),
                          duration: Duration(milliseconds: 1000)));
                    });
                  } else {
                    context.pop(HabitModel(
                        title: titleHabit, money: moneyHabit, type: typeHabit, time: timeInput));
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor("#092635"), fixedSize: Size(widthScreen, 52)),
                child: const Text(
                  "Add Item",
                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700),
                )),
            const Gap(24),
          ],
        ),
      ),
    );
  }
}
