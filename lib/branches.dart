import 'package:flutter/material.dart';

class BranchesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Branches', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey[500],
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListView(
          children: [
            _buildBranchItem(
              context,
              'First Branch',
              'https://homeandecoration.com/wp-content/uploads/2019/03/The-Most-Exquisite-Italian-Craftsmanship-Brianza-Traditional-Furniture.jpg',
              'Rome, Italy',
              '+39 06 1234 5678',
              2007,
              'Known for its Italian design and quality craftsmanship.',
            ),
            _buildBranchItem(
              context,
              'Second Branch',
              'https://www.urbansider.com/wp-content/themes/yootheme/cache/29/marin-montagut-store-292b5e2a.jpeg',
              'Paris, France',
              '+33 1 23 45 67 89',
              2008,
              'A charming branch located in the heart of Paris.',
            ),
            _buildBranchItem(
              context,
              'Third Branch',
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_IjZTOLDAfGs5aFq3Sa-89NfmQg6V9nxpVg&s',
              'Beirut, Lebanon',
              '+96103555333',
              2009,
              'Renowned for its unique blend of traditional and modern housewares.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBranchItem(BuildContext context,
      String branchName,
      String imageUrl,
      String location,
      String phoneNumber,
      int yearOpened,
      String description,
      )
  {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 270, // Adjusted height
              width: 200,  // Adjusted width
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(branchName, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(location, style: TextStyle(fontSize: 26, color: Colors.blueGrey[600], fontWeight: FontWeight.bold)),
                  Text('Phone: $phoneNumber', style: TextStyle(fontSize: 20, color: Colors.blueGrey[600],fontWeight: FontWeight.bold)),
                  Text('Year Opened: $yearOpened', style: TextStyle(fontSize: 22, color: Colors.grey[700],fontWeight: FontWeight.bold)),
                  SizedBox(height: 2),
                  Text(description, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

