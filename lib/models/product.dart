import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product{
  Product({required this.id,required this.title,required this.desc,required this.category,required this.unit,required this.img,required this.price});
  String id;
  String title;
  String desc;
  String img;
  String unit;
  double price;
  String category;

  factory Product.fromJson(Map<String,dynamic> json)=> Product(id: json["_id"], title: json["title"], desc: json["desc"], category: json["category"], unit: json["unit"], img: json["img"], price: json["price"]);
  
  Map<String,dynamic> toJson()=>{
    "title":title,
    "desc":desc,
    "img":img,
    "unit":unit,
    "price":price,
    "category":category,
  };
 
}