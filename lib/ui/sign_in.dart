import 'package:flutter/material.dart';
import 'package:untitled/ui/component/text_fileld_component.dart';
import 'package:untitled/ui/log_in_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String? _membershipType = 'Basic';
  final List<String> _membershipOptions = ['Basic', 'Premium', 'VIP'];

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://img.freepik.com/premium-photo/anime-style-beauty-salon-with-cosmetology-equipment_1026950-95168.jpg"),
                    fit: BoxFit.cover)),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 150,
                    ),
                    Center(
                      child: Text(
                        "Sign Up🎉",
                        style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),
                      ),
                    ),
                    CustomTextFormField(
                      hintText: "Full Name",
                      icon: Icons.person,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name'; // Validation if name is empty
                        }
                        return null; // If valid
                      },
                    ),
                    CustomTextFormField(
                      hintText: "Enter your email",
                      icon: Icons.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      hintText: "Contact Number",
                      icon: Icons.contact_page_outlined,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your contact number';
                        } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                          return 'Please enter a valid 10-digit phone number';
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      hintText: "Enter your Password",
                      icon: Icons.password,
                      controller: _passwordController, // Assign controller
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password'; // Validation if password is empty
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters long'; // Password length check
                        }
                        return null; // If valid
                      },
                    ),
                    CustomTextFormField(
                      hintText: "Confirm Password",
                      icon: Icons.password,
                      controller: _confirmPasswordController, // Assign controller
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password'; // Validation if confirmation is empty
                        } else if (value != _passwordController.text) {
                          return 'Passwords do not match'; // Check if passwords match
                        }
                        return null; // If valid
                      },
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LogInPage()));
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have a account ? " ,style: TextStyle(color: Colors.white),),
                            // SizedBox(width: 10,),
                            Text(
                              "Log In",style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Successfully Signed In'),
                                duration: Duration(
                                    seconds:
                                        2), // The duration the snackbar will be visible
                              ),
                            );

                            // After the Snackbar is shown, navigate to the LogInPage
                            Future.delayed(Duration(seconds: 2), () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogInPage()),
                              );
                            });
                          } else {
                            print("Form is invalid");
                          }
                        },
                        child: Text("Submit"))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    )));
  }
}
