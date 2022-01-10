import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gojjo/constants/color.dart';
import 'package:gojjo/provider/product.dart';
import 'package:gojjo/provider/user.dart';
import 'package:gojjo/ui/home.dart';
import 'package:gojjo/ui/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  late String dropdownvalue = 'Electronics';
  late var items = [
    'Electronics',
    'Food',
    'Clothes',
    'Vehicles',
    'Properties',
    'Health',
  ];
  late String title;
  late String desc;
  late double price;
  late String phone;
  late String location;

  late File _image;
  bool isPicked = false;
  final ImagePicker _picker = ImagePicker();
  void pickImage() async {
    try {
      var pickedImage = await _picker.getImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
          isPicked = true;
        });
      }
    } catch (error) {
      print("Image picker error " + "$error");
    }
  }

  submitForm() async {
    var response = await Provider.of<ProductProvider>(context, listen: false)
        .postProduct(
            title, desc, _image, dropdownvalue, price, phone, location);
    if (response) {
      return AlertDialog(
        title: Text("Successful"),
        content: Text("Your product posted  successfully!"),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Ok"),
          )
        ],
      );
    } else {
      return AlertDialog(
        title: Text("Not Successful"),
        content: Text("Your product was not posted  successfully!"),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Retry"),
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, user, child) {
      if (user.isAuthenticated) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: appBarColor,
            title: Text("Post Product"),
          ),
          body: SingleChildScrollView(
              child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter product name';
                      }
                    },
                    onSaved: (value) => title = value!,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Price",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter price of the product!';
                            }
                          },
                          onSaved: (value) => price = double.parse(value!),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: Colors.black26,
                                  style: BorderStyle.solid)),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: DropdownButton(
                              value: dropdownvalue,
                              icon: Icon(Icons.keyboard_arrow_down),
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                    value: items,
                                    child: Text(
                                      items,
                                      overflow: TextOverflow.clip,
                                    ));
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  dropdownvalue = newValue.toString();
                                });
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Location",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your location!';
                            }
                          },
                          onSaved: (value) => location = value!,
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "phone number",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number!';
                            }
                          },
                          onSaved: (value) => phone = value!,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Upload image"),
                      ElevatedButton(
                          onPressed: () {
                            pickImage();
                          },
                          child: Icon(Icons.add_a_photo))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.grey),
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: isPicked
                        ? Image.file(
                            File(_image.path),
                            fit: BoxFit.fill,
                          )
                        : Center(child: Text("select an image!")),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter description of the product!';
                      }
                    },
                    onSaved: (value) => desc = value!,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        submitForm();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    child: Text("Submit"),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                        minimumSize: MaterialStateProperty.all<Size>(
                            Size(MediaQuery.of(context).size.width, 50))),
                  ),
                ],
              ),
            ),
          )),
        );
      } else {
        return LoginPage();
      }
    });
  }
}
