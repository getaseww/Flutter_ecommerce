import 'package:gojjo/provider/product.dart';
import 'package:gojjo/ui/product/create.dart';
import 'package:gojjo/widget/drawer.dart';
import 'package:provider/provider.dart';
import 'package:gojjo/provider/image_picker.dart';

import '/ui/home.dart';
import 'package:flutter/material.dart';

import 'constants/color.dart';
import 'provider/user.dart';
import 'ui/profile.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>UserProvider()),
        ChangeNotifierProvider(create: (context)=>ProductProvider()),
        ChangeNotifierProvider(create:(context)=>ImagePickerProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
        home: MainPage()
      );
    
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  List _screens = [HomePage(),AddProductPage(),ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedFontSize: 18,
        unselectedFontSize: 17,
        selectedItemColor: selectedBottomBarColor,
         unselectedItemColor: unselectedBottomBarColor,
        currentIndex: _currentIndex,
        onTap: (index) => {
          setState(() {
            _currentIndex = index;
          })
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Sell",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

