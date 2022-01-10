import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gojjo/constants/api.dart';
import 'package:gojjo/constants/color.dart';
import 'package:gojjo/provider/product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  final product;
  const EditProduct({Key? key, required this.product}) : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
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
  late String productId;
  late String title;
  late String desc;
  late double price;
  late String phone;
  late String location;
  late File _image;
  bool isPicked = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    productId = widget.product["_id"];
    super.initState();
  }

  void pickImage() async {
    try {
      var pickedImage = await _picker.getImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
          isPicked = true;
        });
      } else {
        setState(() {
          _image = File(widget.product["img"].path);
          isPicked = true;
        });
      }
    } catch (error) {
      print("Image picker error " + "$error");
    }
  }

  Future<void> submitForm() async {
    var response = await Provider.of<ProductProvider>(context, listen: false)
        .updateProduct(title, desc, _image, dropdownvalue, price, phone,
            location, productId);
    if (response) {
      print("sucess");
    } else {
      print("Not posted!" + "${_image.path}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            backgroundColor: appBarColor,
            title: Text("Edit Product"),
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
                initialValue: widget.product["title"],
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
                      initialValue: widget.product["price"].toString(),
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
                              color: Colors.black26, style: BorderStyle.solid)),
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
                      initialValue: widget.product["location"],
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
                      initialValue: widget.product["phone"],
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
                    : CachedNetworkImage(
                        imageUrl: "https://cdn.shopify.com/s/files/1/0019/4569/8379/products/Trooper_Profile_6616596f-a2e8-4883-b98d-8578a0aeb791_360x.jpg?v=1571839683",
                        fit: BoxFit.fill,
                        placeholder: (context, url) => Padding(
                            padding: EdgeInsets.all(75),
                            child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Container(
                            width: 200, child: Icon(Icons.error_sharp)),
                      ),
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
                initialValue: widget.product["desc"],
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
  }
}
