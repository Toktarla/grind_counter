import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _emailController = TextEditingController();
  final _feedbackController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Feedback'),
        actions: [
          IconButton(
            onPressed: () {
              // Handle send feedback logic here
              String email = _emailController.text;
              String feedback = _feedbackController.text;

              if (email.isEmpty || feedback.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill in all fields')),
                );
                return;
              }

              // In a real app, you would send the email and feedback
              // to your backend or use a service like email_launcher.
              print('Sending feedback to: $email');
              print('Feedback: $feedback');


              //Clear the textfields after sending feedback.
              _emailController.clear();
              _feedbackController.clear();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Feedback sent!')),
              );


            },
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Enter your email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _feedbackController,
              decoration: InputDecoration(
                labelText: 'Write your feedback (1500 chars)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              maxLines: 5, // Allow multiple lines for feedback
              maxLength: 1500, // Set character limit
            ),
            const SizedBox(height: 16),
            const Text(
              'Your feedback will be sent to some email.', // Replace with your actual email handling
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}