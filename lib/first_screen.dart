import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(100, (index) {
          return Center(
            child: Text(
              'Item $index',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          );
        }),
      ),
    );
  }
}
