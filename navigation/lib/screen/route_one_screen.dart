import 'package:flutter/material.dart';

class RouteOneScreen extends StatelessWidget {
  const RouteOneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route One'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Pop'))
        ],
      ),
    );
  }
}
