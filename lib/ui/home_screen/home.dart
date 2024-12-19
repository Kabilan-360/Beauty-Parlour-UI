import 'package:flutter/material.dart';
import 'package:untitled/ui/Haircare_screen.dart';
import 'package:untitled/ui/appoinment_screen.dart';
import 'package:untitled/ui/make_up_screen.dart';
import 'package:untitled/ui/notification_screen.dart';
import 'package:untitled/ui/profile_screen.dart';
import 'package:untitled/ui/service_screen.dart';
import 'package:untitled/ui/book_now_button_screen.dart';
import 'package:untitled/ui/skincare.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> services = [];
  List<Map<String, dynamic>> filteredServices = [];

  @override
  void initState() {
    super.initState();
    // Initialize services
    services = [
      {'name': 'Skincare', 'price': 50.0},
      {'name': 'Haircare', 'price': 40.0},
      {'name': 'Makeup', 'price': 70.0},
    ];
    filteredServices = List.from(services);
    // Listen to search changes
    searchController.addListener(() {
      final text = searchController.text.trim();
      final enteredPrice = double.tryParse(text);

      setState(() {
        if (enteredPrice != null) {
          // Filter services by price
          filteredServices = services
              .where((service) => service['price'] <= enteredPrice)
              .toList();
        } else {
          // Reset to all services if input is empty
          filteredServices = text.isEmpty ? List.from(services) : [];
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus(); // Dismisses the keyboard
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: TextField(
                //     decoration: InputDecoration(
                //       prefixIcon: Icon(Icons.search),
                //       hintText: 'Search for services',
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(12),
                //         borderSide: BorderSide(color: Colors.grey),
                //       ),
                //     ),
                //   ),
                // ),



                // Categories Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Categories',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen()));
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVCHywHxDFVk0j8PEgX8FELCQ8Vbiu2a49Xg&s'), // Replace with actual image URL
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotificationsScreen()));
                        },
                        icon: Icon(
                          Icons.notifications_on,
                          color: Colors.blue,
                        ))
                  ],
                ),

                // SizedBox(
                //   height: 100,
                //   child: ListView(
                //     scrollDirection: Axis.horizontal,
                //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //     children: [
                //       _buildCategoryChip('Skincare',
                //         onTap: () {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //               builder: (context) => SkincareScreen(title: "Skincare"),
                //             ),
                //           );
                //         },
                //       ),
                //       _buildCategoryChip('Hair Care',
                //         onTap: () {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //               builder: (context) => HairCareScreen(title: 'Hair Care Treatment'),
                //             ),
                //           );
                //         },
                //       ),
                //       _buildCategoryChip('Makeup',
                //       onTap: (){
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => MakeupScreen(title: 'Makeup Session'),
                //           ),
                //         );
                //
                //       }),
                //     ],
                //   ),
                // ),


                SizedBox(height: 20,),
                SizedBox(
                  height: 100,
                  child: ListView(
                    // scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildCategoryChip('Skincare',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SkincareScreen(title: "Skincare"),
                                ),
                              );
                            },
                          ),
                          const Spacer(), // Adds space between items
                          _buildCategoryChip('Hair Care',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HairCareScreen(title: 'Hair Care Treatment'),
                                ),
                              );
                            },
                          ),
                          const Spacer(),
                          _buildCategoryChip('Makeup',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MakeupScreen(title: 'Makeup Session'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),



                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SizedBox(
                    height: 150,
                    child: PageView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black,
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTMmTMOT_v1tgY2ENdOs5O0-vbnNo9qCu6dz1fNPurDBjVAHZ3FZMAvpiPEQEYgH3wgDc&usqp=CAU'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Featured Services Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Featured Services',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      onPressed: _showAddServiceDialog,
                      icon: Icon(Icons.add, color: Colors.green),
                    ),
                  ],
                ),


                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child:TextField(
                    controller: searchController,
                    keyboardType: TextInputType.number, // Allows numeric input
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search services by price (e.g., 50)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorText: double.tryParse(searchController.text) == null &&
                          searchController.text.isNotEmpty
                          ? 'Enter a valid number'
                          : null, // Show error if input is invalid
                    ),
                  ),

                ),


                // Display filtered service cards
                ...filteredServices.map((service) {
                  return _buildServiceCard(
                    service['name'],
                    price: service['price'],
                    onTap: () {
                      print('Custom action for ${service['name']} Treatment');
                    },
                  );
                }).toList(),



                // Navigate to Service Details Button
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16.0),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ServiceDetailsScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text('Service'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16.0),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AppointmentScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text('Appoinment Screen'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: onTap,
        // Trigger the onTap function if provided
        borderRadius: BorderRadius.circular(20),
        // Adds a ripple effect within the chip's boundary
        child: Chip(
          label: Text(label, style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
    );
  }


  // Function to show alert dialog for adding a service
  void _showAddServiceDialog() {
    final TextEditingController serviceNameController = TextEditingController();
    final TextEditingController servicePriceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Service'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: serviceNameController,
                decoration: InputDecoration(
                  hintText: 'Enter service name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: servicePriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter service price',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (serviceNameController.text.trim().isNotEmpty &&
                    servicePriceController.text.trim().isNotEmpty) {
                  final price = double.tryParse(servicePriceController.text.trim());
                  if (price != null) {
                    setState(() {
                      services.add({
                        'name': serviceNameController.text.trim(),
                        'price': price,
                      });
                      filteredServices = List.from(services);
                    });
                    Navigator.of(context).pop();
                  } else {
                    // Show an error if price is invalid
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Invalid price entered')),
                    );
                  }
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }




  Widget _buildServiceCard(
      String serviceName, {
        required double price,
        void Function()? onTap,
      }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service Image
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2oFblBv3FEk5_KkJE3EEFlk3QZToSBP08pw&s'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16),
            // Service Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Price: \$${price.toStringAsFixed(2)}'),
                  SizedBox(height: 8),
                  Text('Duration: 30 mins'),
                ],
              ),
            ),
            // Book Now Button
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Book Now'),
            ),
          ],
        ),
      ),
    );
  }
}
