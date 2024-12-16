import 'package:flutter/material.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> upcomingAppointments = [
    {
      'serviceName': 'Haircut',
      'date': '2024-12-15',
      'time': '10:00 AM',
      'status': 'Upcoming'
    },
    {
      'serviceName': 'Facial',
      'date': '2024-12-17',
      'time': '2:00 PM',
      'status': 'Upcoming'
    },
  ];

  final List<Map<String, dynamic>> completedAppointments = [
    {
      'serviceName': 'Massage',
      'date': '2024-12-10',
      'time': '3:00 PM',
      'status': 'Completed'
    },
    {
      'serviceName': 'Manicure',
      'date': '2024-12-05',
      'time': '1:00 PM',
      'status': 'Completed'
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Upcoming'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildUpcomingTab(),
          _buildCompletedTab(),
        ],
      ),
    );
  }

  Widget _buildUpcomingTab() {
    return ListView.builder(
      itemCount: upcomingAppointments.length,
      itemBuilder: (context, index) {
        final appointment = upcomingAppointments[index];
        return _buildAppointmentCard(
          appointment,
          showActions: true,
          onReschedule: () => _showRescheduleDialog(index),
          onCancel: () => _showCancelConfirmation(index),
        );
      },
    );
  }

  Widget _buildCompletedTab() {
    return ListView.builder(
      itemCount: completedAppointments.length,
      itemBuilder: (context, index) {
        final appointment = completedAppointments[index];
        return _buildAppointmentCard(
          appointment,
          showFeedback: true,
          onFeedback: () => _showFeedbackDialog(index),
        );
      },
    );
  }

  Widget _buildAppointmentCard(
      Map<String, dynamic> appointment, {
        bool showActions = false,
        bool showFeedback = false,
        VoidCallback? onReschedule,
        VoidCallback? onCancel,
        VoidCallback? onFeedback,
      }) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(appointment['serviceName']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${appointment['date']}'),
            Text('Time: ${appointment['time']}'),
            Text('Status: ${appointment['status']}'),
          ],
        ),
        trailing: showActions
            ? Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: onReschedule,
            ),
            IconButton(
              icon: Icon(Icons.cancel, color: Colors.red),
              onPressed: onCancel,
            ),
          ],
        )
            : showFeedback
            ? IconButton(
          icon: Icon(Icons.feedback, color: Colors.green),
          onPressed: onFeedback,
        )
            : null,
      ),
    );
  }

  void _showRescheduleDialog(int index) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );
    if (newDate != null) {
      setState(() {
        upcomingAppointments[index]['date'] = newDate.toString().split(' ')[0];
      });
    }
  }

  void _showCancelConfirmation(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cancel Appointment'),
        content: Text('Are you sure you want to cancel this appointment?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                upcomingAppointments.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  void _showFeedbackDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Provide Feedback'),
        content: TextField(
          decoration: InputDecoration(hintText: 'Enter your feedback here'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
