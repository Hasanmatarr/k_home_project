import 'package:flutter/material.dart';
import 'products.dart';
import 'db.dart'; // Ensure this file contains the necessary methods for saving data

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  bool _loaded = false;
  List<Product> cartItems = [];

  void update(bool success) {
    setState(() {
      _loaded = true;
      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load data')),
        );
      }
    });
  }

  void addToCart(Product product) {
    setState(() {
      cartItems.contains(product) ? cartItems.remove(product) : cartItems.add(product);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${product.name} ${cartItems.contains(product) ? 'added to' : 'removed from'} cart')),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    getProducts(update);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[200],
        actions: [
          IconButton(
            onPressed: !_loaded ? null : () {
              setState(() {
                _loaded = false;
                getProducts(update);
              });
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen(cartItems: cartItems)),
              );
            },
          ),
        ],
        title: const Text('Available Products', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0)),
        centerTitle: true,
      ),
      body: _loaded ? ShowProducts(addToCart: addToCart) : const Center(child: CircularProgressIndicator()),
    );
  }
}

class ShowProducts extends StatelessWidget {
  final Function(Product) addToCart;
  const ShowProducts({super.key, required this.addToCart});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              children: [
                Image.network(
                  products[index].image,
                  width: 200,
                  height: 350,
                  fit: BoxFit.cover,
                ),
                Container(
                  color: index.isEven ? Colors.blue[25] : Colors.blue[100],
                  padding: const EdgeInsets.all(5.0),
                  width: width * 0.55,
                  child: Row(
                    children: [
                      SizedBox(width: width * 0.05),
                      Flexible(
                        child: Text(products[index].toString(), style: const TextStyle(fontSize: 30)),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_shopping_cart),
                        onPressed: () => addToCart(products[index]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40.0),
          ],
        );
      },
    );
  }
}
