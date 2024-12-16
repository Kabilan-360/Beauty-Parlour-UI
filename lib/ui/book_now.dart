import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieving the arguments passed to this page
    final arguments = ModalRoute.of(context)?.settings.arguments as Map?;
    final List cartItems = arguments?['cartItems'] ?? [];
    final double totalAmount = arguments?['totalAmount'] ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: cartItems.isEmpty
          ? Center(child: Text('No items in your cart.'))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Selected Services:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // List of services in the cart
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return ListTile(
                    title: Text(item['serviceName']),
                    subtitle: Text(
                        'Date: ${item['selectedDate']} | Time: ${item['selectedTimeSlot']}'),
                    trailing: Text('\$${item['price']}'),
                  );
                },
              ),
            ),
            // Total amount and confirmation button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: \$${totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Display a confirmation dialog when the button is clicked
                      final selectedDate = cartItems.isNotEmpty
                          ? cartItems[0]['selectedDate']
                          : 'Not available';
                      final serviceName = cartItems.isNotEmpty
                          ? cartItems[0]['serviceName']
                          : 'Service';

                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Booking Confirmed'),
                          content: Text(
                            '$serviceName is booked on $selectedDate.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);  // Close dialog
                                Navigator.pop(context);  // Go back to home or service page
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text('Book Now'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
