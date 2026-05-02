import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;

  // 🎨 THEME COLORS
  final Color primaryTeal = const Color(0xA8006056);
  final Color darkTeal = const Color(0xFF00C5AB);
  final Color lightTeal = const Color(0xFF10423A);
  final Color backgroundGrey = const Color(0xFFBABABA);
  final Color softGrey = const Color(0xFF6B7577);
  final Color darkText = const Color(0xFF10423A);

  final List<Map<String, String>> tasks = [
    {"title": "Design dashboard UI", "status": "In Progress"},
    {"title": "Fix login bug", "status": "Pending"},
    {"title": "Client meeting", "status": "Done"},
  ];

  final TextEditingController taskController = TextEditingController();
  String selectedStatus = "Pending";

  void showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Add Task", style: TextStyle(color: darkTeal)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: taskController,
                decoration: InputDecoration(
                  hintText: "Enter task name",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryTeal),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedStatus,
                items: ["Pending", "In Progress", "Done"]
                    .map((status) => DropdownMenuItem(
                  value: status,
                  child: Text(status),
                ))
                    .toList(),
                onChanged: (value) {
                  selectedStatus = value!;
                },
                decoration: InputDecoration(
                  labelText: "Status",
                  labelStyle: TextStyle(color: darkTeal),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: softGrey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryTeal,
              ),
              onPressed: () {
                if (taskController.text.isNotEmpty) {
                  setState(() {
                    tasks.add({
                      "title": taskController.text,
                      "status": selectedStatus,
                    });
                  });
                  taskController.clear();
                  selectedStatus = "Pending";
                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });

    if (index == 0) {
      Navigator.pushNamed(context, "/dashboard");
    } else if (index == 1) {
      Navigator.pushNamed(context, "/projectpage");
    } else if (index == 2) {
      Navigator.pushNamed(context, "/clientpage");
    } else if (index == 3) {
      Navigator.pushNamed(context, "/payement");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGrey,

      appBar: AppBar(
        backgroundColor: Colors.teal[800],
        elevation: 0,
        title: Text("Dashboard", style: TextStyle(color: Colors.grey[300])),
        iconTheme: IconThemeData(color: darkTeal),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [darkTeal, primaryTeal],
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.person, color: Colors.white, size: 40),
                  SizedBox(height: 10),
                  Text(
                    "Freelio",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Welcome Back!",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: Icon(Icons.dashboard, color: primaryTeal),
              title: const Text("Dashboard"),
              onTap: () => Navigator.pushNamed(context, "/dashboard"),
            ),
            ListTile(
              leading: Icon(Icons.folder, color: primaryTeal),
              title: const Text("Projects"),
              onTap: () => Navigator.pushNamed(context, "/projectpage"),
            ),
            ListTile(
              leading: Icon(Icons.person, color: primaryTeal),
              title: const Text("Clients"),
              onTap: () => Navigator.pushNamed(context, "/clientpage"),
            ),
            ListTile(
              leading: Icon(Icons.payment, color: primaryTeal),
              title: const Text("Payments"),
              onTap: () => Navigator.pushNamed(context, "/payement"),
            ),

            const Divider(),

            ListTile(
              leading: Icon(Icons.notifications, color: primaryTeal),
              title: const Text("Notifications"),
              onTap: () => Navigator.pushNamed(context, "/notifications"),
            ),
            ListTile(
              leading: Icon(Icons.call, color: primaryTeal),
              title: const Text("Contact Us"),
              onTap: () => Navigator.pushNamed(context, "/contactus"),
            ),
            ListTile(
              leading: Icon(Icons.share, color: primaryTeal),
              title: const Text("share with friend"),
              onTap: () => Navigator.pushNamed(context, "/sharing"),
            ),
            ListTile(
              leading: Icon(Icons.settings, color: primaryTeal),
              title: const Text("Profile & Account"),
              onTap: () => Navigator.pushNamed(context, "/profile"),
            ),

          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryTeal, lightTeal],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome back 👋",
                        style: TextStyle(color: Colors.white)),
                    SizedBox(height: 6),
                    Text(
                      "Manage your work efficiently",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                "Your Overview",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: darkText,
                ),
              ),

              const SizedBox(height: 20),
              _StatGrid(),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Active Tasks",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: darkText,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: showAddTaskDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: primaryTeal,
                    ),
                    child: const Text("Add Task"),
                  ),
                ],
              ),

              const SizedBox(height: 10),
              _TaskBox(tasks: tasks, primaryTeal: primaryTeal),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
        selectedItemColor: primaryTeal,
        unselectedItemColor: softGrey,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: "Projects"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Clients"),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: "Payment"),
        ],
      ),
    );
  }
}

/* ================= STAT GRID ================= */
class _StatGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: const [
        _StatCard(title: "Active Tasks", value: "8"),
        _StatCard(title: "Projects", value: "10"),
        _StatCard(title: "Hours Logged", value: "9.0"),
        _StatCard(title: "Earnings", value: "\$300"),
      ],
    );
  }
}

/* ================= TASK BOX ================= */
class _TaskBox extends StatelessWidget {
  final List<Map<String, String>> tasks;
  final Color primaryTeal;

  const _TaskBox({required this.tasks, required this.primaryTeal});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFECEFF1)),
      ),
      child: Column(
        children: [
          for (var task in tasks)
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFECEFF1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(task["title"]!),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: task["status"] == "Done"
                          ? Colors.green.shade100
                          : task["status"] == "In Progress"
                          ? Colors.teal.shade100
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      task["status"]!,
                      style: TextStyle(
                        fontSize: 12,
                        color: task["status"] == "Done"
                            ? Colors.teal
                            : task["status"] == "In Progress"
                            ? primaryTeal
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/* ================= STAT CARD ================= */
class _StatCard extends StatelessWidget {
  final String title;
  final String value;

  const _StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final Color primaryTeal = const Color(0xFF00897B);
    final Color darkText = const Color(0xFF263238);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.analytics, color: primaryTeal),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: darkText,
            ),
          ),
        ],
      ),
    );
  }
}