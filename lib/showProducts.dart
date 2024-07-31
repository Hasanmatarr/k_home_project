import 'package:flutter/material.dart';
import 'products.dart';
import 'db.dart';

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

class CartScreen extends StatefulWidget {
  final List<Product> cartItems;
  const CartScreen({super.key, required this.cartItems});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool saveCartItemsToDatabase(List<Product> cartItems, String name, String phone) {
    print('Saving cart items to the database...');
    print('Name: $name');
    print('Phone: $phone');
    print('Cart Items: ${cartItems.map((item) => item.toString()).join(', ')}');
    return true;
  }

  void _saveCart() {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all fields')),
      );
      return;
    }

    if (saveCartItemsToDatabase(widget.cartItems, name, phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Products have been purchased. A message notification has been sent to your phone number.',
            style: TextStyle(fontSize: 24.0, backgroundColor: Colors.blueGrey[200]),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save cart items')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double total = widget.cartItems.fold(0, (sum, item) => sum + item.price);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: const Text('Cart Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveCart,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.cartItems[index].toString(),style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.normal)),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      setState(() {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${widget.cartItems[index].name} removed from cart')),
                        );
                        widget.cartItems.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Total: \$${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Enter your name',labelStyle: TextStyle(fontSize: 28),),style: TextStyle(fontSize: 40.0,fontWeight: FontWeight.normal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Enter your phone number',labelStyle: TextStyle(fontSize: 25),),style: TextStyle(fontSize: 40.0,fontWeight: FontWeight.normal),
              keyboardType: TextInputType.phone,
            ),
          ),
        ],
      ),
    );
  }
}

