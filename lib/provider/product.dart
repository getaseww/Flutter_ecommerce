import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:gojjo/constants/api.dart';
import 'package:gojjo/models/product.dart';
import 'package:gojjo/provider/user.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ChangeNotifier {
  Future<List> fetchProduct() async {
    var response;
    List products = [];
    try {
      response = await http.get(Uri.parse(API_URL + "products"),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        products = json.decode(response.body) as List;
        notifyListeners();
        return products;
      } else {}
    } catch (err) {}
    return products;
  }

  Future<List> myProducts() async {
    var response;
    List products = [];
    try {
      final String? token = await UserProvider().getToken();
      final parts = token!.split('.');
      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      var decoded = utf8.decode(base64Url.decode(normalized));
      var data = json.decode(decoded) as Map;
      String userId = data['id'];
      response =
          await http.get(Uri.parse(API_URL + "products/" + userId), headers: {
        "Content-Type": "application/json","x-access-token":"$token"
      });
      if (response.statusCode == 200) {
        products = jsonDecode(response.body) as List;
        notifyListeners();
        return products;
      } else {
        return products;
      }
    } catch (err) {}
    return products;
  }

  Future<List> fetchRelatedProducts(String category) async {
    var response;
    List products = [];
    try {
      response = await http.get(
          Uri.parse(API_URL + "products/" + category.toString()),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        products = json.decode(response.body) as List;

        return products;
      } else {}
    } catch (err) {}
    return products;
  }

  Future<List> searchProduct(String query) async {
    var response;
    List products = [];
    try {
      response = await http.get(Uri.parse(API_URL + "product/search/" + query),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        products = json.decode(response.body) as List;
        return products;
      } else {}
    } catch (err) {}
    return products;
  }

  Future<Map<dynamic, dynamic>> show(String id) async {
    late Map<dynamic, dynamic> product;
    var response;
    try {
      response = await http.get(Uri.parse(API_URL + "product/" + id));
      product = jsonDecode(response.body) as Map;
      if (response.statusCode == 200) {
        return product;
      } else {
        return product;
      }
    } catch (err) {
      return product;
    }
  }

  Future<bool> postProduct(String title, String desc, File img, String category,
      double price, String phone, String location) async {
    var response;
    try {
      final String? token = await UserProvider().getToken();
      final parts = token!.split('.');
      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      var decoded = utf8.decode(base64Url.decode(normalized));
      var data = json.decode(decoded) as Map;
      String userId = data['id'];
      String fileName = img.path.split('/').last;
      var request =
          http.MultipartRequest('POST', Uri.parse(API_URL + "product/create"));
      request.fields["userId"] = userId;
      request.fields['title'] = title;
      request.fields['desc'] = desc;
      request.fields['category'] = category;
      request.fields['phone'] = phone;
      request.fields['location'] = location;
      request.fields['price'] = price.toString();
      request.headers["x-access-token"] = "$token";

      request.files.add(await http.MultipartFile.fromPath('img', img.path));
      var response = await request.send();

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }

  Future<bool> updateProduct(
      String title,
      String desc,
      File img,
      String category,
      double price,
      String phone,
      String location,
      String productId) async {
    var response;
    try {
      final String? token = await UserProvider().getToken();
      var request = http.MultipartRequest(
          'POST', Uri.parse(API_URL + "product/update" + productId));
      request.fields['title'] = title;
      request.fields['desc'] = desc;
      request.fields['category'] = category;
      request.fields['phone'] = phone;
      request.fields['location'] = location;
      request.fields['price'] = price.toString();
      request.headers["x-access-token"] = "$token";
      request.files.add(await http.MultipartFile.fromPath('img', img.path));
      var response = await request.send();

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }

  Future<bool> deleteProduct(String productId) async {
    var response;
    try {
      final String? token= await UserProvider().getToken();
      response =
          await http.delete(Uri.parse(API_URL + "product/delete/" + productId),headers: {"x-access-token":"$token"});
      if (response == 200) {
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }
}
