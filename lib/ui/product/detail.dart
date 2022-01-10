import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gojjo/constants/color.dart';
import 'package:gojjo/provider/product.dart';
import 'package:gojjo/ui/product/create.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLaucher;


class ProductDetail extends StatefulWidget {
  final Map<dynamic, dynamic> product;

  const ProductDetail({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          
        ),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CachedNetworkImage(
                imageUrl:
                    "https://cdn.shopify.com/s/files/1/0019/4569/8379/products/Trooper_Profile_6616596f-a2e8-4883-b98d-8578a0aeb791_360x.jpg?v=1571839683",
                fit: BoxFit.fill,
                width: 200,
                placeholder: (context, url) => Padding(
                    padding: EdgeInsets.all(75),
                    child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Container(width: 200, child: Icon(Icons.error_sharp)),
              ),
              Divider(
                height: 5,
              ),
              Container(
                color: Colors.green[500],
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Icon(
                            Icons.location_on,
                            color: locationIconColor,
                          ),
                          Text(
                            "${widget.product["location"]}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ]),
                        Text(
                          "${widget.product["price"]} Br",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "${widget.product["title"]}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "${widget.product["desc"]}",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(20),
              child: ElevatedButton(
                style: ButtonStyle(minimumSize: MaterialStateProperty.all<Size>(Size(MediaQuery.of(context).size.width, 50))),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProductPage()));
                },
                child: Text("Sell your products"),
              ),),
              Padding(
                padding: EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("Similar products",style: TextStyle(fontSize: 19),)),
              ),
              Consumer<ProductProvider>(builder: (context, product, child) {
                return FutureBuilder<List>(
                    future: product.fetchRelatedProducts(widget.product["category"]),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
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
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                                  width: 200,
                                                  child:
                                                      Icon(Icons.error_sharp)),
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
                                                        fontWeight:
                                                            FontWeight.w600),
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
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ],
                                                  )),
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
                            });
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    });
              })
            ],
          ),
        ),
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          height: 50.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                flex: 2,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.amber)),
                  onPressed: () {
                    UrlLaucher.launch("tel://${widget.product["phone"]}");
                  },
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.phone_android,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          "CALL",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}


// DateTime dob = DateTime.parse('2019-11-14T08:37:24.782+00:00');
// Duration diff =  DateTime.now().difference(dob);
// String differenceInYears = (diff.inDays/365).floor().toString();
// print(differenceInYears + ' years');
             
//     if(diff.inDays/365>= 1){
//     print('${(diff.inDays/365).floor()} year(s) ago');
//   }else if(diff.inDays >= 1){
//     print('${diff.inDays} day(s) ago');
//   } else if(diff.inHours >= 1){
//     print('${diff.inHours} hour(s) ago');
//   } else if(diff.inMinutes >= 1){
//     print('${diff.inMinutes} minute(s) ago');
//   } else if (diff.inSeconds >= 1){
//     print('${diff.inSeconds} second(s) ago');
//   } else {
//     print( 'just now');
//   }