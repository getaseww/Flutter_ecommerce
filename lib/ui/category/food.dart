import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gojjo/constants/color.dart';
import 'package:gojjo/provider/product.dart';
import 'package:gojjo/ui/product/detail.dart';
import 'package:provider/provider.dart';

import '../searchPage.dart';

class FoodCategory extends StatefulWidget {
  final category;
  const FoodCategory({ Key? key,required this.category }) : super(key: key);

  @override
  _FoodCategoryState createState() => _FoodCategoryState();
}

class _FoodCategoryState extends State<FoodCategory> {
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
        return FutureBuilder<List>(
            future: product.fetchRelatedProducts(widget.category),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context,index){
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
                    }
                    );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            });
      }),
    );

  }
}

