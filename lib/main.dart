import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:firebase_core/firebase_core.dart';

import 'controller/controller.dart';
import 'firebase_options.dart';

import 'screens/games/home.dart';
import 'screens/login/register.dart';
import 'screens/rank/select.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => Controller())],
      child: MaterialApp(home: MyApp())));
}

class MyApp extends StatelessWidget {
  var user = FirebaseAuth.instance.currentUser;
  var controller = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: user == null
            ? RegisterScreen()
            : PageView(
                controller: controller,
                onPageChanged: (page) {
                  Provider.of<Controller>(context, listen: false).selectedPageIndex = page;
                  Provider.of<Controller>(context, listen: false).changeBottomNavigation();
                },
                children: [HomeScreen(), const SelectScreen()]),
        bottomNavigationBar: user == null
            ? Container(height: 0)
            : Consumer<Controller>(
                builder: (context, value, child) {
                  return BottomNavigationBar(
                    backgroundColor: Colors.black,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: "Home",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.emoji_events),
                        label: "Rankings",
                      ),
                    ],
                    currentIndex: value.selectedPageIndex,
                    selectedItemColor: const Color.fromARGB(255, 0, 255, 8),
                    unselectedItemColor: const Color.fromARGB(188, 76, 175, 79),
                    onTap: (selected) {
                      controller.animateToPage(
                          duration: const Duration(milliseconds: 500), curve: Curves.easeOut, selected);
                      value.selectedPageIndex = selected;
                      value.changeBottomNavigation();
                    },
                  );
                },
              ));
  }
}
