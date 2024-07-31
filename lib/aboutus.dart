import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  final String backgroundImageUrl =
      'https://cdn.pixabay.com/photo/2018/04/04/23/21/glass-3291449_960_720.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('About Us', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(backgroundImageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader('K-HomeStore', 45),
              _buildHeader('Since 2010', 25),
              SizedBox(height: 20),
              _buildHeader('Our Mission:', 40),
              _buildText('To provide the best quality houseware products at the lowest prices.', 35),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              _buildHeader('Contact Information:', 30),
              SizedBox(height: 20,),
              _buildContactItem(Icons.location_on, '123 Main Street'),
              SizedBox(height: 20,),
              _buildContactItem(Icons.phone, '+123 456 7890'),
              SizedBox(height: 20,),
              _buildContactItem(Icons.email,'KHome@info.com',),
              SizedBox(height: 30),
              _buildContactItem(
                null,
                '@KHomePage',
                leading: Image.network(
                  'https://www.instagram.com/static/images/ico/favicon-192.png/68d99ba29cc8.png',
                  width: 60,
                  height: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String text, double fontSize) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _buildText(String text, double fontSize) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(text, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildContactItem(IconData? icon, String text, {Widget? leading}) {
    return ListTile(
      leading: leading ?? Icon(icon, color: Colors.green, size: 50),
      title: Text(text, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
    );
  }
}
