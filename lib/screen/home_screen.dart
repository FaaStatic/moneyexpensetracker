import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:habbitapp/component/cart_item.dart';
import 'package:habbitapp/component/list_item.dart';
import 'package:habbitapp/main.dart';
import 'package:habbitapp/model/habit_model.dart';
import 'package:habbitapp/util/list_habits.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _controller = ScrollController();
  final currency = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp ',
    decimalDigits: 2,
  );
  final TextEditingController _moneyChanger = TextEditingController();
  List<HabitModel> dataParser = [];
  double workLabel = 0;
  double clarityLabel = 0;
  double healingLabel = 0;
  double savingLabel = 0;
  double moneyInitial = 0;

  @override
  void initState() {
    _moneyChanger.addListener(changeMoney);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalMoney();
    });
    super.initState();
  }

  void changeMoney() {
    if (_moneyChanger.text.isNotEmpty) {
      setState(() {
        moneyInitial = double.parse(_moneyChanger.text);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void addButtonFunc() async {
    await context.push("/edit").then((value) {
      if (value != null) {
        var dataParam = value as HabitModel;
        if (double.parse(dataParam.money) > moneyInitial) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            keyScaffold.currentState!.showSnackBar(const SnackBar(
              backgroundColor: Colors.red,
              content: Text("Money amount too big!"),
              duration: Duration(milliseconds: 1000),
            ));
          });
        } else {
          switch (value.type) {
            case ListHabit.healing:
              setState(() {
                dataParser.add(dataParam);
                healingLabel += 1;
                moneyInitial -= double.parse(value.money);
              });

              break;
            case ListHabit.carity:
              setState(() {
                dataParser.add(dataParam);
                clarityLabel += 1;
                moneyInitial -= double.parse(value.money);
              });

              break;
            case ListHabit.saving:
              setState(() {
                dataParser.add(dataParam);
                savingLabel += 1;
                moneyInitial -= double.parse(value.money);
              });

              break;

            case ListHabit.work:
              setState(() {
                dataParser.add(dataParam);
                workLabel += 1;
                moneyInitial -= double.parse(value.money);
              });

              break;
            default:
              print("nothing");
              break;
          }
          Future.delayed(const Duration(milliseconds: 1000), () {
            keyScaffold.currentState!.showSnackBar(const SnackBar(
              backgroundColor: Colors.green,
              content: Text("Item Added!"),
              duration: Duration(milliseconds: 1000),
            ));
          });
        }
      }
    });
  }

  void deleteItemHabit(HabitModel item, int index) async {
    switch (item.type) {
      case ListHabit.healing:
        setState(() {
          dataParser.removeAt(index);
          healingLabel -= 1;
          moneyInitial += double.parse(item.money);
        });

        break;
      case ListHabit.carity:
        setState(() {
          dataParser.removeAt(index);
          clarityLabel -= 1;
          moneyInitial += double.parse(item.money);
        });

        break;
      case ListHabit.saving:
        setState(() {
          dataParser.removeAt(index);
          savingLabel -= 1;
          moneyInitial += double.parse(item.money);
        });

        break;

      case ListHabit.work:
        setState(() {
          dataParser.removeAt(index);
          workLabel -= 1;
          moneyInitial += double.parse(item.money);
        });

        break;
      default:
        print("nothing");
        break;
    }
    Future.delayed(const Duration(milliseconds: 1000), () {
      keyScaffold.currentState!.showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Item Removed!"),
          duration: Duration(milliseconds: 1000)));
    });
  }

  void showModalMoney() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        isDismissible: false,
        enableDrag: false,
        builder: (context) {
          final widthScreen = MediaQuery.of(context).size.width;
          final heightScreen = MediaQuery.of(context).size.height;
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              width: widthScreen,
              height: heightScreen * 0.3,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: HexColor("#5C8374")),
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Input Your Money",
                      style:
                          TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const Gap(24),
                  Container(
                      height: 52,
                      decoration: const BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextFormField(
                        controller: _moneyChanger,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Money Expenses",
                          contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                      )),
                  const Gap(24),
                  ElevatedButton(
                      onPressed: () {
                        if (moneyInitial > 0) {
                          context.pop();
                        } else {}
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor("#092635"), fixedSize: Size(widthScreen, 52)),
                      child: const Text(
                        "Add Item",
                        style: TextStyle(
                            fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700),
                      )),
                ],
              ),
            ),
          );
        });
  }

  void resetExpense() async {
    setState(() {
      dataParser.clear();
      workLabel = 0;
      clarityLabel = 0;
      healingLabel = 0;
      savingLabel = 0;
      moneyInitial = 0;
    });
    _moneyChanger.clear();
    showModalMoney();
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                resetExpense();
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ))
        ],
        title: const Text(
          "Dashboard Money Expense Tracker",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          addButtonFunc();
        },
        child: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(shape: BoxShape.circle, color: HexColor("#163020")),
          child: const Center(
            child: Icon(
              Icons.add,
              size: 28,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        width: widthScreen,
        height: heightScreen,
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: Column(
          children: [
            const Gap(24),
            Text(
              "Your Balance : ${currency.format(moneyInitial).toString()}",
              style: TextStyle(
                fontSize: 14,
                color: HexColor("#1B4242"),
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(24),
            SizedBox(
              width: widthScreen,
              height: heightScreen * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Gap(24),
                  Flexible(
                      child: CartItem(
                    fract: healingLabel > 0 ? healingLabel / dataParser.length : 0,
                    typeHabit: ListHabit.healing,
                    count: healingLabel > 0 ? healingLabel : 0,
                  )),
                  const Gap(24),
                  Flexible(
                      child: CartItem(
                    fract: workLabel > 0 ? workLabel / dataParser.length : 0,
                    typeHabit: ListHabit.work,
                    count: workLabel > 0 ? workLabel : 0,
                  )),
                  const Gap(24),
                  Flexible(
                      child: CartItem(
                    fract: savingLabel > 0 ? savingLabel / dataParser.length : 0,
                    typeHabit: ListHabit.saving,
                    count: savingLabel > 0 ? savingLabel : 0,
                  )),
                  const Gap(24),
                  Flexible(
                      child: CartItem(
                    fract: clarityLabel > 0 ? clarityLabel / dataParser.length : 0,
                    typeHabit: ListHabit.carity,
                    count: clarityLabel > 0 ? clarityLabel : 0,
                  )),
                  const Gap(24),
                ],
              ),
            ),
            const Gap(32),
            Expanded(
                child: SingleChildScrollView(
              controller: _controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Builder(builder: (context) {
                    if (dataParser.isNotEmpty) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: dataParser.length,
                          itemBuilder: (context, index2) {
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Dismissible(
                                    key: ValueKey(dataParser.elementAt(index2)),
                                    direction: DismissDirection.endToStart,
                                    background: Container(
                                      color: Colors.red.shade400,
                                      width: 200,
                                      child: const Center(
                                          child: Icon(
                                        Icons.delete_outline,
                                        color: Colors.white,
                                        size: 24,
                                      )),
                                    ),
                                    onDismissed: (dismiss) {
                                      deleteItemHabit(dataParser.elementAt(index2), index2);
                                    },
                                    child: ListItem(dataItem: dataParser.elementAt(index2))));
                          });
                    } else {
                      return const Center(
                        child: Text(
                          "Habit Data Is Empty, Lets add item",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                      );
                    }
                  })
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
