import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:provider/provider.dart";
import 'package:firebase_core/firebase_core.dart';

import 'controller/controller.dart';
import 'firebase_options.dart';

import 'screens/gamescreens/home.dart';
import 'screens/loginscreens/register.dart';
import 'screens/rankscreens/select.dart';

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
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 27, 27, 27),
          elevation: 0,
          centerTitle: true,
          title: Text("/ProgEdu",
              style: GoogleFonts.vt323(
                  fontSize: screenWidth / 15, color: const Color.fromARGB(255, 0, 255, 8))),
          leading: IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut().then((value) {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return RegisterScreen();
                    },
                  ));
                });
              },
              icon: Icon(Icons.arrow_back,
                  size: screenWidth / 10, color: const Color.fromARGB(255, 0, 255, 8))),
        ),
        body: user == null
            ? RegisterScreen()
            : PageView(
                controller: controller,
                onPageChanged: (page) {
                  Provider.of<Controller>(context, listen: false).selectedPageIndex = page;
                  Provider.of<Controller>(context, listen: false).changeBottomNavigation();
                },
                children: [HomeScreen(), SelectScreen()]),
        bottomNavigationBar: Consumer<Controller>(
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
