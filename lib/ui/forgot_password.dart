import 'package:flutter/material.dart';
import 'package:untitled/ui/component/text_fileld_component.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>(); // Key for the form

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.network(
                'https://media.istockphoto.com/id/1354075296/vector/isolated-cartoon-illustration-of-people-in-the-barbershop-women-in-a-beauty-salon.jpg?s=612x612&w=0&k=20&c=8jHZ2gOrrwuUTWyqEQrUM3Y5zysvtFmf2hfz4KbNUBw=',
                fit: BoxFit.cover,
              ),
            ),
            // Foreground Content
            Center(
              child: Form(
                key: _formKey, // Assign the form key
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.logout, color: Colors.black, size: 30),
                    ),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      hintText: "Enter email or username",
                      icon: Icons.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be empty'; // Validation handled by the button
                        }
                        return null; // Field is valid
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Form is valid, proceed with the action
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Reset link sent to email')),
                          );
                        } else {
                          // Form is invalid, show error
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please fill in the email or username'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Send Reset Link",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
