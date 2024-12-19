import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final String? Function(String?)? validator; // Validator as a parameter
  final TextEditingController? controller; // Optional controller


  CustomTextFormField({
    Key? key,
    required this.hintText,
    required this.icon,
    this.validator,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 3), // Adds a border
        borderRadius: BorderRadius.circular(8), // Rounds the corners
      ),
      child: TextFormField(
          controller: controller,
          decoration:  InputDecoration(
              icon: Icon(icon, color: Colors.black,),
              hintText: hintText,
              border: InputBorder.none,

              hintStyle: TextStyle(
                  color: Colors.black,fontWeight: FontWeight.bold
              )
            // contentPadding: EdgeInsets.only(left: 16)
          ),
          validator: validator
      ),
    );
  }
}
