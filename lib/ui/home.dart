import 'package:cached_network_image/cached_network_image.dart';
import 'package:gojjo/constants/color.dart';
import 'package:gojjo/provider/product.dart';
import 'package:gojjo/ui/category/electronics.dart';
import 'package:gojjo/ui/category/food.dart';
import 'package:gojjo/ui/category/plants.dart';
import 'package:gojjo/ui/category/property.dart';
import 'package:gojjo/ui/category/vehicle.dart';
import 'package:gojjo/ui/searchPage.dart';
import 'package:provider/provider.dart';

import 'product/detail.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    final _formKey = GlobalKey<FormState>();
  late String query="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Form(
            key: _formKey,
            child: TextFormField(
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                       _formKey.currentState!.save();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SearchPage(query:query)));
                    },
                    icon: Icon(Icons.search),
                  ),     
                  hintText: '    Search product....',
                  border: InputBorder.none),
                onSaved: (value) => query = value!,
            ),
          ),
        ),
      )),
      body: Consumer<ProductProvider>(builder: (context, product, child) {
        return SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            SizedBox(height: 20),
            Row(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ElectronicsCategory(category: "Electronics")));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 120,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.laptop,
                            color: categoryIconColor,
                            size: 40,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text("Electronics")),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PropertyCategory(category: "Property",)));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 120,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.house,
                            color: categoryIconColor,
                            size: 40,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text("Property")),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodCategory(category: "food")));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 120,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.food_bank,
                            color: categoryIconColor,
                            size: 40,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text("Food")),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context)=> FoodCategory(category: "clothes")));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 120,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.food_bank,
                            color: categoryIconColor,
                            size: 40,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text("Clothes")),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>PlantCategory(category: "Plants",)));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 120,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.home,
                            color: categoryIconColor,
                            size: 40,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text("Plants")),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>VehicleCategory(category: "vehicle")));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 120,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.local_taxi,
                            color: categoryIconColor,
                            size: 40,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text("Vehicles")),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            FutureBuilder<List>(
                future: product.fetchProduct(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetail(
                                          product: snapshot.data![
                                              snapshot.data!.length -
                                                  index -
                                                  1],
                                        )));
                          },
                          child: Card(
                            child: Row(
                              children: [
                                Container(
                                  height: 180.0,
                                  // child: Image.asset(
                                  //   'images/go.png',
                                  //   fit: BoxFit.fill,
                                  //   width: 200,
                                  // ),
                                  // child: Image.network(
                                  //   "https://devtuts4you.com/wp-content/uploads/2021/08/house-pt-2.jpg",
                                  //   width: 200,
                                  //   fit: BoxFit.fill,
                                  //   errorBuilder: (context, exception, stackTrace) {
                                  //     return Container(
                                  //         width: 200,
                                  //         child: Center(child: Text('loading...')));
                                  //   },
                                  // ),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://cdn.shopify.com/s/files/1/0019/4569/8379/products/Trooper_Profile_6616596f-a2e8-4883-b98d-8578a0aeb791_360x.jpg?v=1571839683",
                                    fit: BoxFit.fill,
                                    width: 200,
                                    placeholder: (context, url) => Padding(
                                        padding: EdgeInsets.all(75),
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                            width: 200,
                                            child: Icon(Icons.error_sharp)),
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
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${snapshot.data![snapshot.data!.length - index - 1]["title"]}",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Row(
                                              children: [
                                                Icon(Icons.location_on,
                                                    color: Colors.blue),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "${snapshot.data![snapshot.data!.length - index - 1]["location"]}",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            )),
                                        Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                "${snapshot.data![snapshot.data!.length - index - 1]["price"]} Birr",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontStyle:
                                                        FontStyle.italic),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ]),
        );
      }),
    );
  }
}
