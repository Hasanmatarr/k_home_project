import 'package:http/http.dart' as http;


class Product {
  String _name;
  double _price;
  String _image;
  String _description;

  Product(this._name, this._price, this._image, this._description);

  String get name => _name;
  set name(String value) => _name = value;

  double get price => _price;
  set price(double value) => _price = value;

  String get image => _image;
  set image(String value) => _image = value;

  String get description => _description;
  set description(String value) => _description = value;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      json['name'],
      json['price'],
      json['image'],
      json['description'],
    );
  }

  @override
  String toString() {
    return'$name\n\$${price}\n$description';
  }
}
