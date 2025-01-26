import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stats'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Share stats
            },
          )
        ],
      ),
      body: Center(
        child: Text('Stats Page - Coming Soon'),
      ),
    );
  }
}