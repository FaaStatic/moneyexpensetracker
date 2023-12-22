import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:habbitapp/model/habit_model.dart';
import 'package:habbitapp/util/util.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class ListItem extends StatelessWidget {
  final HabitModel dataItem;
  const ListItem({super.key, required this.dataItem});

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final currency = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 2,
    );

    return Container(
      width: widthScreen,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)), color: HexColor("#1B4242")),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: widthScreen * 0.45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Util().iconHabit(value: dataItem.type, fromCart: false),
                const Gap(16),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dataItem.title,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                    const Gap(16),
                    Text(
                      dataItem.time,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 10, color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ],
                ))
              ],
            ),
          ),
          Flexible(
            child: Text(
              currency.format(double.parse(dataItem.money)),
              style:
                  const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }
}
