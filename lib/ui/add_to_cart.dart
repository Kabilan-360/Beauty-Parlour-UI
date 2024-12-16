import 'package:flutter/material.dart';
import 'package:untitled/ui/splash_screen/check_out.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartItems = [];

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map?;

    if (arguments != null && arguments.isNotEmpty) {
      cartItems.add({
        'serviceName': arguments['serviceName'],
        'price': arguments['price'],
        'selectedDate': arguments['selectedDate'],
        'selectedTimeSlot': arguments['selectedTimeSlot'],
      });
    }

    // Calculate total price
    double totalAmount = cartItems.fold(0, (sum, item) => sum + item['price']);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        backgroundColor: Colors.blueAccent,
      ),
      body: cartItems.isEmpty
          ? Center(
        child: Text(
          'Your cart is empty.',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      )
          : SingleChildScrollView( // Make the column scrollable
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // List of selected services
              ListView.builder(
                itemCount: cartItems.length,
                shrinkWrap: true, // To avoid taking unnecessary space
                physics: NeverScrollableScrollPhysics(), // Disable internal scrolling
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Card(
                    elevation: 6,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      title: Text(
                        item['serviceName'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date: ${item['selectedDate']}',
                            style:
                            TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Text(
                            'Time: ${item['selectedTimeSlot']}',
                            style:
                            TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove_circle,
                                color: Colors.red),
                            onPressed: () {
                              setState(() {
                                cartItems.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              // Total Amount and Checkout Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: \$${totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to checkout page with cart data
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutPage(
                              cartItems: cartItems, // Pass your cartItems here
                              totalAmount: totalAmount, // Pass the total amount here
                            ),
                          ),
                        );

                      },
                      child: Text('Proceed to Checkout'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
