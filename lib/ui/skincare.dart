import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/ui/home_screen/home.dart';

class SkincareScreen extends StatefulWidget {
  final String title;

  const SkincareScreen({super.key, required this.title});

  @override
  _SkincareScreenState createState() => _SkincareScreenState();
}

class _SkincareScreenState extends State<SkincareScreen> {
  DateTime? selectedDate;
  String? selectedTimeSlot;
  int? selectedOfferIndex; // Track selected offer index

  final List<String> timeSlots = [
    "10:00 AM",
    "11:00 AM",
    "12:00 PM",
    "2:00 PM",
    "3:00 PM",
  ];

  final List<Map<String, String>> offers = [
    {
      "title": "20% Off on First Booking",
      "description": "Get 20% off on your first skincare treatment.",
      "image":
      "https://via.placeholder.com/150?text=Offer+1", // Replace with actual image
    },
    {
      "title": "Buy 1 Get 1 Free",
      "description": "Book a session and get one absolutely free.",
      "image":
      "https://via.placeholder.com/150?text=Offer+2", // Replace with actual image
    },
    {
      "title": "Free Consultation",
      "description": "Avail free consultation for your next visit.",
      "image":
      "https://via.placeholder.com/150?text=Offer+3", // Replace with actual image
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service Name, Description, Price
            Text(
              widget.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Experience premium care tailored to enhance your beauty and well-being.',
            ),
            SizedBox(height: 16),
            Text(
              'Price: \$50',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 24),

            // Offers Section
            Text(
              'Special Offers',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: offers.length,
                separatorBuilder: (context, index) => SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final offer = offers[index];
                  final isSelected = selectedOfferIndex == index; // Check if selected
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedOfferIndex = index; // Update selected index
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: 250,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue[50] : Colors.white,
                        border: Border.all(
                          color: isSelected ? Colors.blue : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Image.network(
                            offer['image']!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  offer['title']!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  offer['description']!,
                                  style: TextStyle(fontSize: 12),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 24),

            // Date Picker
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
            SizedBox(height: 16),

            // Time Slot Picker
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

            Spacer(),

            // Submit Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (selectedDate == null || selectedTimeSlot == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select a date and time slot'),
                      ),
                    );
                  } else {
                    // Navigate or display confirmation
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Booking Confirmation'),
                        content: Text(
                          'You have booked a ${widget.title} Treatment on '
                              '${DateFormat('yyyy-MM-dd').format(selectedDate!)} '
                              'at $selectedTimeSlot.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                            ),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text('Confirm Booking'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
