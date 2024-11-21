import 'package:bot_toast/bot_toast.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maka_assessment/helpers/app_bloc_observer.dart';
import 'package:maka_assessment/repositories/api_repository.dart';
import 'package:maka_assessment/screens/inventory_screen.dart';
import 'package:maka_assessment/screens/show_screen.dart';

void main() {

  /// Observer to monitoring all bloc changes in console
  Bloc.observer = const AppBlocObserver();

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      /// provide us api repo in whole project
      create: (context) => ApiRepository(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          darkTheme: ThemeData.dark(),
          builder: BotToastInit(), /// package for display modals, toast-s ...
          navigatorObservers: [BotToastNavigatorObserver()],
          home: const ScreenBody()),
    );
  }
}

class ScreenBody extends StatefulWidget {
  const ScreenBody({super.key});

  @override
  State<ScreenBody> createState() => _ScreenBodyState();
}

class _ScreenBodyState extends State<ScreenBody> {
  int _currentIndex = 0;
  /// list of screens for botton navigationBar
  final List<Widget> _screens = [
    const ShowScreen(),
    const InventoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _screens[_currentIndex]),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.grey.shade600,
        color: Colors.black54,
        items: const [
          Icon(
            Icons.home,
          ),
          Icon(
            Icons.add,
          ),
        ],
        index: _currentIndex,
        onTap: (index) {
          //Handle button tap
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
