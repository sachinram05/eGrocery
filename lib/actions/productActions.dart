import 'dart:convert' as convert;
import 'package:egrocery/models/productModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductActions {
  static const String _baseUrl = 'https://shareittofriends.com/demo/flutter';

  Future<List<Product>> getProducts() async {
    const String endPoint = "/productList.php";
    final getUser = await SharedPreferences.getInstance();
    final userToken = getUser.getString('token');
    print("token $userToken");
    List<Product> products = [];

    try {
      Uri postsUri = Uri.parse('$_baseUrl$endPoint');
      http.Response response =
          await http.post(postsUri, body: {"user_login_token": 'c2a2f674c6f6a1d2374da1ebfab69adc'});
      if (response.statusCode == 200) {
        List<dynamic> productList = convert.jsonDecode(response.body);
        for (var productItem in productList) {
          Product product = Product.fromMap(productItem);
          products.add(product);
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return products;
  }

  Future<Map<String, Object>> addProduct(data) async {
    const String endPoint = "/addProduct.php";
    final getUser = await SharedPreferences.getInstance();
    final userToken = getUser.getString('token');
    try {
      Uri postUri = Uri.parse('$_baseUrl$endPoint');
      http.Response response = await http
          .post(postUri, body: {"user_login_token": 'c2a2f674c6f6a1d2374da1ebfab69adc', ...data});
      if (response.statusCode == 200) {
        return {"status": true, "data": 'product is created'};
      } else {
        throw Exception('Failed to add product!');
      }
    } catch (err) {
      return {"status": false, "data": err.toString()};
    }
  }

  updateProduct(data) async {
    const String endPoint = "/editProduct.php";
    final getUser = await SharedPreferences.getInstance();
    final userToken = getUser.getString('token');
    try {
      Uri postUri = Uri.parse('$_baseUrl$endPoint');
      http.Response response = await http
          .post(postUri, body: {"user_login_token": 'c2a2f674c6f6a1d2374da1ebfab69adc', ...data});

      if (response.statusCode == 200) {
        return {"status": true, "data": 'product updated'};
      } else {
        throw Exception('Failed to update product!');
      }
    } catch (err) {
      return {"status": false, "data": err.toString()};
    }
  }

  deleteProduct(id) async {
    const String endPoint = "/deleteProduct.php";
    final getUser = await SharedPreferences.getInstance();
    final userToken = getUser.getString('token');
    try {
      Uri postUri = Uri.parse('$_baseUrl$endPoint');
      http.Response response = await http
          .post(postUri, body: {"user_login_token": 'c2a2f674c6f6a1d2374da1ebfab69adc', 'id': id});

      if (response.statusCode == 200) {
        return {"status": true, "data": 'product deleted'};
      } else {
        throw Exception('Failed to delete product!');
      }
    } catch (err) {
      return {"status": false, "data": err.toString()};
    }
  }
}
