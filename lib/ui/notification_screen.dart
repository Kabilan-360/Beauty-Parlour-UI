import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationItem> notifications = [
    NotificationItem(title: 'Booking Confirmation', isRead: false),
    NotificationItem(title: 'Special Offer Just for You!', isRead: false),
    NotificationItem(title: 'Your Order has been Shipped', isRead: true),
  ];

  void _markAllAsRead() {
    setState(() {
      for (var notification in notifications) {
        notification.isRead = true;
      }
    });
  }

  void _removeNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  void _navigateToRelevantScreen(NotificationItem notification) {
    // Navigate based on the type of notification
    if (notification.title == 'Booking Confirmation') {
      Navigator.pushNamed(context, '/bookingConfirmation'); // Replace with relevant screen route
    } else if (notification.title == 'Special Offer Just for You!') {
      Navigator.pushNamed(context, '/offerDetails'); // Replace with relevant screen route
    } else {
      // Handle other types of notifications
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _markAllAsRead,
              style: ElevatedButton.styleFrom(
                // primary: Colors.deepPurple,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
              child: Text(
                'Mark All as Read',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  var notification = notifications[index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: notification.isRead ? Colors.grey[200] : Colors.white,
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      title: Text(
                        notification.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: notification.isRead ? Colors.grey : Colors.black,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeNotification(index),
                      ),
                      onTap: () => _navigateToRelevantScreen(notification),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationItem {
  String title;
  bool isRead;

  NotificationItem({required this.title, required this.isRead});
}
