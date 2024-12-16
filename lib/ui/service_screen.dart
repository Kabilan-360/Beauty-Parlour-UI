import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/ui/add_to_cart.dart';
import 'package:untitled/ui/book_now.dart';

class ServiceDetailsScreen extends StatefulWidget {
  const ServiceDetailsScreen({super.key});

  @override
  _ServiceDetailsScreenState createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  DateTime? selectedDate;
  String? selectedTimeSlot;
  final List<String> timeSlots = [
    "10:00 AM",
    "11:00 AM",
    "12:00 PM",
    "2:00 PM",
    "3:00 PM"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service Name, Description, Price
            Text(
              'Service',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
                'This is a detailed description of the service. It provides all necessary information about the service.'),
            SizedBox(height: 16),
            Text(
              'Price: \$50',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            SizedBox(height: 24),
            // Beautician/Parlor Profile
            Text(
              'Beautician/Parlor Profile',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      NetworkImage('https://via.placeholder.com/150'),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Beautician Name',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text('Rating: 4.5/5'),
                    Text('Location: City Center'),
                  ],
                )
              ],
            ),

            SizedBox(height: 24),
            // Booking Section
            Text(
              'Booking Section',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            // Date Picker
            SizedBox(height: 16),
            Text('Select Date:', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            InkWell(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 30)),
                );
                if (pickedDate != null) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  selectedDate == null
                      ? 'Choose a date'
                      : DateFormat('yyyy-MM-dd').format(selectedDate!),
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            // Time Slot Picker
            SizedBox(height: 16),
            Text('Select Time Slot:', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: timeSlots.map((slot) {
                return ChoiceChip(
                  label: Text(slot),
                  selected: selectedTimeSlot == slot,
                  onSelected: (bool selected) {
                    setState(() {
                      selectedTimeSlot = selected ? slot : null;
                    });
                  },
                );
              }).toList(),
            ),

            // Add to Cart / Book Now Buttons
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Check if both the date and time slot are selected
                    if (selectedDate != null && selectedTimeSlot != null) {
                      // If both are selected, navigate to the cart page with the selected data
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(),
                          settings: RouteSettings(
                            arguments: {
                              'serviceName': 'Skin Care',
                              'price': 50.0,
                              'selectedDate': DateFormat('yyyy-MM-dd').format(selectedDate!),
                              'selectedTimeSlot': selectedTimeSlot!,
                            },
                          ),
                        ),
                      );
                    } else {
                      // If not, show a warning (optional: use a snackbar or alert dialog)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please select a date and time slot before adding to cart.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: Text('Add to Cart'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
                // Optionally, disable the "Book Now" button or show a message
                // ElevatedButton(
                //   onPressed: () {
                //     if (selectedDate != null && selectedTimeSlot != null) {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => CheckoutPage()));
                //     } else {
                //       // Show warning or keep it disabled
                //     }
                //   },
                //   child: Text('Book Now'),
                //   style: ElevatedButton.styleFrom(
                //     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                //   ),
                // ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
