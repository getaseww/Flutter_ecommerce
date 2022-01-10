import 'package:flutter/material.dart';
import 'package:gojjo/constants/color.dart';
import 'package:gojjo/main.dart';
import 'package:gojjo/provider/user.dart';
import 'package:provider/provider.dart';

import 'login.dart';
class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  late String fullName;
  late String email;
  late String password;
  Future<void> submitForm() async {
    bool result = await Provider.of<UserProvider>(context, listen: false).register(fullName, email, password);
    if (!result) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('not registered')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<UserProvider>(builder: (context,user,child){
          if(user.isAuthenticated){
            return MainPage();
          }else{
               return ListView(
                children:[ 
                  ClipPath(
                    clipper: WaveClip(),
                    child: Container(
                      child: Center(child: Text("Gojjo",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      decoration: BoxDecoration(
                          color: appBarColor
        
                      ),
                    )
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Icon(
                                      Icons.person,
                                    )),
                                hintText: 'Full Name',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                            },
                            onSaved: (value) => fullName = value!,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Icon(
                                      Icons.email,
                                    )),
                                hintText: 'Email',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                            },
                            onSaved: (value) => email = value!,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Icon(
                                      Icons.vpn_key,
                                    )),
                                hintText: 'Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Password';
                              }
                            },
                            onSaved: (value) => password = value!,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      Colors.amber),minimumSize: MaterialStateProperty.all(Size(300, 50))),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  submitForm();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing Data')),
                                  );
                                }
                              },
                              child: const Text('Sign Up'),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Row(
                              children: [
                                Text("have an account?",style: TextStyle(fontSize: 18),),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: TextButton(
                                    child: Text("Sign In",style: TextStyle(fontSize: 18)),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => LoginPage()));
                                    },
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
                ]);
     
          }
           } )
          );
  }
  
}

class WaveClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * .7, size.height - 40);
    var firstControlPoint = Offset(size.width * .25, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 45);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}