import 'package:flutter/material.dart';
import 'aboutus.dart';
import 'branches.dart';
import 'showProducts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  final String backgroundImageUrl =
      'https://cdn.pixabay.com/photo/2021/03/01/13/22/housewares-6059709_1280.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'K-HomeStore',
          style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(backgroundImageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: Colors.black.withOpacity(0.4),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome to HouseWare Store',
                      style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 140),
                    _buildCategoryContainer(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[200]!.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 2, blurRadius: 20, offset: Offset(0, 3))],
      ),
      child: Column(
        children: [
          _buildCategoryItem(context, Icons.home, 'Branches', BranchesScreen()),
          _buildCategoryItem(context, Icons.shopping_cart, 'Products', ProductsList()),
          _buildCategoryItem(context, Icons.phone, 'About us', AboutUsScreen()),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, IconData icon, String categoryName, Widget screen) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.black87, size: 44),
        title: Text(
          categoryName,
          style: TextStyle(fontSize: 24, color: Colors.black87),
        ),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => screen)),
      ),
    );
  }
}
