import 'package:flutter/material.dart';

class LogsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Logs'),
      ),
      body: ListView.builder(
        itemCount: 10, // Placeholder count
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Workout #$index'),
            subtitle: Text('Details about the workout'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Delete the log
              },
            ),
          );
        },
      ),
    );
  }
}
