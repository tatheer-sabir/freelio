import 'dart:async';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  static const Color kPrimary    = Color(0xFF29B2FE);
  static const Color kDark       = Color(0xFF1D5C97);
  static const Color kSurface    = Color(0xFFE8F6FF);
  static const Color kBackground = Color(0xFFFFFFFF);

  // 🔔 Notifications list
  List<Map<String, dynamic>> notifications = [
    {
      "title": "Payment Received",
      "text": "Ali Ahmed paid PKR 5000",
      "time": "Just now",
      "icon": Icons.payment,
      "color": Colors.green,
    },
    {
      "title": "Payment Due",
      "text": "Sara Khan payment is overdue",
      "time": "2h ago",
      "icon": Icons.warning,
      "color": Colors.orange,
    },
  ];

  late Timer timer;

  @override
  void initState() {
    super.initState();

    // ⏱ AUTO NOTIFICATIONS (SIMULATION)
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      addAutoNotification();
    });
  }

  void addAutoNotification() {
    final newNotif = {
      "title": "New Activity",
      "text": "System updated new project status",
      "time": "Just now",
      "icon": Icons.notifications,
      "color": kPrimary,
    };

    setState(() {
      notifications.insert(0, newNotif);
    });
  }

  void deleteNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSurface,

      // ✅ APPBAR (BACK BUTTON ONLY)
      appBar: AppBar(
        backgroundColor: kPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Notifications",
          style: TextStyle(color: Colors.white),
        ),
      ),

      // ✅ BODY
      body: notifications.isEmpty
          ? const Center(child: Text("No notifications"))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final n = notifications[index];

          return Dismissible(
            key: UniqueKey(),

            // 👉 Swipe to delete (right or left)
            direction: DismissDirection.endToStart,

            onDismissed: (direction) {
              deleteNotification(index);
            },

            background: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.only(right: 20),
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.delete, color: Colors.white),
            ),

            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: kBackground,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                children: [

                  CircleAvatar(
                    backgroundColor:
                    n["color"].withOpacity(0.15),
                    child: Icon(
                      n["icon"],
                      color: n["color"],
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Text(
                          n["title"],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          n["text"],
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Text(
                    n["time"],
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}