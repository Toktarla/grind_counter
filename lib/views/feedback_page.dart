  import 'package:flutter/material.dart';
  import 'package:url_launcher/url_launcher.dart';

import '../config/variables.dart';


  class FeedbackPage extends StatefulWidget {
    const FeedbackPage({Key? key}) : super(key: key);

    @override
    State<FeedbackPage> createState() => _FeedbackPageState();
  }

  class _FeedbackPageState extends State<FeedbackPage> {
    final _emailController = TextEditingController();
    final _feedbackController = TextEditingController();

    bool _isSending = false; // State to show loading indicator

    @override
    void dispose() {
      _emailController.dispose();
      _feedbackController.dispose();
      super.dispose();
    }

    Future<void> _sendFeedback() async {
      String senderEmail = _emailController.text.trim();
      String feedback = _feedbackController.text.trim();

      if (senderEmail.isEmpty || feedback.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all fields')),
        );
        return;
      }

      setState(() {
        _isSending = true;
      });

      try {
        String body = feedback;

        // Encode the subject and body for the URL
        String encodedSubject = Uri.encodeComponent(subject);
        String encodedBody = Uri.encodeComponent(body);

        // Create the mailto: URL
        final Uri emailLaunchUri = Uri(
          scheme: 'mailto',
          path: recipientEmail,
          queryParameters: {
            'subject': encodedSubject,
            'body': encodedBody,
          },
        );

        if (await canLaunchUrl(emailLaunchUri)) {
          await launchUrl(emailLaunchUri);
        } else {
          throw 'Could not launch email client!';
        }

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email client opened with feedback.')),
        );

        _emailController.clear();
        _feedbackController.clear();
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to open email client: $e')),
        );
      }

      setState(() {
        _isSending = false;
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Send Feedback'),
          actions: [
            IconButton(
              onPressed: _isSending ? null : _sendFeedback,
              icon: _isSending
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.send),
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
                maxLines: 5,
                maxLength: 1500,
              ),
              const SizedBox(height: 16),
              const Text(
                'Your feedback will be sent to our team.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }
  }