import 'package:flutter/material.dart';
import 'package:untitled/ui/component/text_fileld_component.dart';
import 'package:untitled/ui/forgot_password.dart';
import 'package:untitled/ui/home_screen/home.dart';
import 'package:untitled/ui/sign_in.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
              children:[
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://img.freepik.com/free-photo/beauty-salon-with-cosmetology-equipment-anime-style_23-2151500959.jpg"),
                          fit: BoxFit.cover)),


                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "Log In",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        CustomTextFormField(
                          hintText: "Enter email or username",
                          icon: Icons.abc,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field cannot be empty'; // Or a custom message for null or empty
                            }
                            return null; // If the value is not null or empty, it's valid
                          },
                        ),
                        CustomTextFormField(
                          hintText: "Password",
                          icon: Icons.password,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password'; // Validation if password is empty
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters long'; // Password length check
                            }
                            return null; // If valid
                          },
                        ),
                        InkWell(
                          onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Forgot Password ?",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInPage()));
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have a account ? ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                // SizedBox(width: 10,),
                                Text(
                                  "Sign Up",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 5,),
                        ElevatedButton(onPressed: (){
                          if(_formKey.currentState!.validate()){
                            print("Form is valid");
                             Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
                          }else{
                            print("Form is invalid");
                          }
                        }, child: Text("Log In"))
                      ],
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
