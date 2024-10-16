import 'package:flutter/material.dart';
import 'package:project_se_app/controllers/apply.dart';
import 'package:project_se_app/models/apply.dart';
import 'package:project_se_app/models/prof_post.dart'; // Import the ApplyService

class Apply extends StatefulWidget {
  const Apply({super.key});

  @override
  State<Apply> createState() => _ApplyState();
}

class _ApplyState extends State<Apply> {
  final _formKey = GlobalKey<FormState>();
  final _applyService = ApplyService(); // Create an instance of ApplyService
  String _studentName = '';
  String _studentEmail = '';

  void _addPost() async {
    if (_formKey.currentState!.validate()) {
      final newPost = ApplyModel(
        studentName: _studentName,
        studentEmail: _studentEmail,
        id: '', // Provide an ID if needed
      );

      try {
        await _applyService
            .addPost(newPost); // Call addPost on the ApplyService instance
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Post added successfully!')),
        );
        Navigator.of(context)
            .pop(true); // Navigate back after successfully adding the post
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding post: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
        title: const Text(
          'Apply',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlue.shade800,
        iconTheme: IconThemeData(
          color: Colors.white, // Set the back button and icon colors to white
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Student Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onChanged: (value) {
                  _studentName = value;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Student Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onChanged: (value) {
                  _studentEmail = value;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addPost,
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue.shade800,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
