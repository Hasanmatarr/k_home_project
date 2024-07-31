import 'package:flutter/material.dart';

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
          style: TextStyle(color: Colors.black87, fontSize: 32, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
      ),
    );
  }
}
