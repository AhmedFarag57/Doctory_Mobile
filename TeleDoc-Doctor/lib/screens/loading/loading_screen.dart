import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {

  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade600,
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ) 
      ),
    );
  }
}
