import 'package:flutter/material.dart';
import 'package:untitled/ui/log_in_page.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = 'John Doe';
  String email = 'johndoe@example.com';
  String phone = '+1234567890';
  String profilePicture =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVCHywHxDFVk0j8PEgX8FELCQ8Vbiu2a49Xg&s';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(profilePicture), // Dynamic image
            ),
            SizedBox(height: 16),
            Text('Name: $name'),
            Text('Email: $email'),
            Text('Phone: $phone'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _openEditProfileModal(context);
                  },
                  child: Text('Edit Profile'),
                ),
                ElevatedButton(
                  onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>LogInPage()));
                  },
                  child: Text('Logout'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Method to open Edit Profile Modal
  void _openEditProfileModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return EditProfileModal(
          name: name,
          email: email,
          phone: phone,
          onSave: (String updatedName, String updatedEmail, String updatedPhone) {
            setState(() {
              name = updatedName;
              email = updatedEmail;
              phone = updatedPhone;
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  // Method to handle logout action
  void _logout(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login'); // Redirect to login page
  }
}

class EditProfileModal extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final Function(String, String, String) onSave;

  EditProfileModal({
    required this.name,
    required this.email,
    required this.phone,
    required this.onSave,
  });

  @override
  _EditProfileModalState createState() => _EditProfileModalState();
}

class _EditProfileModalState extends State<EditProfileModal> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    phoneController = TextEditingController(text: widget.phone);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Edit Profile', style: TextStyle(fontSize: 18)),
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(labelText: 'Phone'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              widget.onSave(
                nameController.text,
                emailController.text,
                phoneController.text,
              );
            },
            child: Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}
