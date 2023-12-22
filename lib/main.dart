import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habbitapp/util/router_config.dart';
import 'package:hexcolor/hexcolor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['fonts'], license);
  });
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(const MyApp());
  });
}

final GlobalKey<ScaffoldMessengerState> keyScaffold = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: keyScaffold,
      routerConfig: RouterMaster().router,
      theme: ThemeData(
        fontFamily: "Rubik",
        useMaterial3: true,
      ).copyWith(
        scaffoldBackgroundColor: HexColor("#9EC8B9"),
        appBarTheme: AppBarTheme(
          backgroundColor: HexColor("#1B4242"),
          toolbarHeight: 52,
        ),
      ),
    );
  }
}
