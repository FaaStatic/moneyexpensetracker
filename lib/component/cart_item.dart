import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:habbitapp/util/list_habits.dart';
import 'package:habbitapp/util/util.dart';

class CartItem extends StatelessWidget {
  final double fract;
  final ListHabit typeHabit;
  final double count;
  const CartItem({super.key, required this.fract, required this.typeHabit, required this.count});

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    return FractionallySizedBox(
      heightFactor: fract > 0.3 ? fract : 0.3,
      child: Container(
        width: widthScreen * 0.25,
        height: 10,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: Util().colorHabit(typeHabit)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(16),
            Flexible(child: Util().iconHabit(value: typeHabit, fromCart: true)),
            const Gap(16),
            Flexible(
                child: Text(
              count.toString(),
              style:
                  const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
            )),
          ],
        ),
      ),
    );
  }
}
