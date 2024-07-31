import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../products.dart';

List<Product> products = [];

void getProducts(Function(bool success) update) async {
  try {
    final url = Uri.http('projectproduct.atwebpages.com', 'SelectProduct.php');
    final response = await http.get(url).timeout(const Duration(seconds: 5));
    products.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) {
        Product p = Product(
            row['name'],
            double.parse(row['price'].toString()),
            row['image'],
            row['description']);
        products.add(p);
      }
      update(true);
    } else {
      print('Failed to load data with status code ${response.statusCode}');
      update(false);
    }
  } catch (e) {
    print('Error loading data with error ${e.toString()}');
    update(false);
  }
}