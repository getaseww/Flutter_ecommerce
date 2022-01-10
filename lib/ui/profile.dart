import 'package:cached_network_image/cached_network_image.dart';
import 'package:gojjo/constants/color.dart';
import 'package:gojjo/main.dart';
import 'package:gojjo/provider/product.dart';
import 'package:gojjo/ui/product/edit.dart';
import 'package:gojjo/widget/drawer.dart';

import '/provider/user.dart';
import '/ui/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, user, child) {
        if (user.isAuthenticated) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: appBarColor,
            ),
            drawer: DrawerWidget(),
            body: Consumer<ProductProvider>(builder: (context, product, child) {
              return SingleChildScrollView(
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                    SizedBox(
                    height: 20,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text("My Products",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700))),
                  SizedBox(
                    height: 20,
                  ),
                  FutureBuilder<List>(
                      future: product.myProducts(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                if (snapshot.data!.length == 0) {
                                  return Column(children: [
                                    Text("You don't post a product yet."),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          minimumSize:
                                              MaterialStateProperty.all<Size>(
                                                  Size(100, 50))),
                                      onPressed: () {},
                                      child: Text("Post Product"),
                                    ),
                                  ]);
                                } else {
                                  return Card(
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 150.0,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "https://cdn.shopify.com/s/files/1/0019/4569/8379/products/Trooper_Profile_6616596f-a2e8-4883-b98d-8578a0aeb791_360x.jpg?v=1571839683",
                                            fit: BoxFit.fill,
                                            width: 200,
                                            placeholder: (context, url) => Padding(
                                                padding: EdgeInsets.all(75),
                                                child:
                                                    CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                                        width: 200,
                                                        child: Icon(
                                                            Icons.error_sharp)),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 5),
                                            child: Column(
                                              children: [
                                                Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      "${snapshot.data![snapshot.data!.length - index - 1]["title"]}",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    )),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 5),
                                                  child: Align(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child: Text(
                                                        "${snapshot.data![snapshot.data!.length - index - 1]["price"]} Birr",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontStyle: FontStyle
                                                                .italic),
                                                      )),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => EditProduct(
                                                                      product: snapshot
                                                                          .data![snapshot
                                                                              .data!
                                                                              .length -
                                                                          index -
                                                                          1])));
                                                        },
                                                        child: Text("Edit")),
                                                    TextButton(
                                                        onPressed: () {
                                                          product.deleteProduct(
                                                              snapshot
                                                                  .data![snapshot
                                                                      .data!
                                                                      .length -
                                                                  index -
                                                                  1]["_id"]);
                                                        },
                                                        child: Text("Delete"))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }
                              });
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                ]),
              );
            }),
          );
        } else {
          return LoginPage();
        }
      },
    );
  }
}
