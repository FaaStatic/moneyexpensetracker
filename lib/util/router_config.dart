import 'package:go_router/go_router.dart';
import 'package:habbitapp/screen/edit_screen.dart';
import 'package:habbitapp/screen/home_screen.dart';
import 'package:habbitapp/screen/splash_screen.dart';

class RouterMaster {
  static final RouterMaster _router = RouterMaster._internal();

  factory RouterMaster() {
    return _router;
  }

  RouterMaster._internal();

  final router = GoRouter(initialLocation: "/", routes: [
    GoRoute(
        path: "/",
        builder: (context, state) {
          return const SplashScreen();
        }),
    GoRoute(
        path: "/home",
        builder: (context, state) {
          return const HomeScreen();
        }),
    GoRoute(
        path: "/edit",
        builder: (context, state) {
          return const EditScreen();
        }),
  ]);
}
