import 'package:flutter/material.dart';
import 'package:gojjo/constants/color.dart';
import 'package:gojjo/provider/user.dart';
import 'package:gojjo/ui/about.dart';
import 'package:gojjo/ui/contact.dart';
import 'package:gojjo/ui/privacy.dart';
import 'package:gojjo/ui/product/create.dart';
import 'package:gojjo/ui/profile.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  // void changeT() {
  //   ThemeBuilder.of(context)!.changeTheme();
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
         Container(
           color: appBarColor,
           height: 100,
         ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text("Post product"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProductPage()));
            },
          ),
          ListTile(
              title: Text("About Us"),
              leading: Icon(Icons.person),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutPage()));
              }),
          ListTile(
              title: Text("Contact Us"),
              leading: Icon(Icons.contact_page),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactPage()));
              }),
          ListTile(
              title: Text("Privacy & policy"),
               leading: Icon(Icons.security),
               onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>PrivacyPage()));
               },
          ),
          ListTile(
            title: Text("Logout"),
            leading: Icon(Icons.logout),
            onTap: () {
              Provider.of<UserProvider>(context, listen: false).logout();
            },
          ),
        ],
      ),  
    );
  }
}
