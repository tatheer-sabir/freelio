import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;

  // ── Freelio Brand Colors ──────────────────
  static const Color kPrimary       = Color(0xFF29B2FE); // Freelancer blue
  static const Color kBackground    = Color(0xFFFFFFFF); // clean white
  static const Color kSurface       = Color(0xFFE8F6FF); // light blue tint
  static const Color kTextPrimary   = Color(0xFF0A1628); // dark navy
  static const Color kTextSecondary = Color(0xFF1D5C97); // mid blue
  static const Color kDivider       = Color(0xFFBFE4FF); // soft blue divider
  static const Color kDark          = Color(0xFF1D5C97); // dark blue
  // ─────────────────────────────────────────

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
          backgroundColor: kBackground,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text("Add Task", style: TextStyle(color: kTextPrimary, fontWeight: FontWeight.w700)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: taskController,
                style: TextStyle(color: kTextPrimary),
                decoration: InputDecoration(
                  hintText: "Enter task name",
                  hintStyle: TextStyle(color: kTextSecondary.withOpacity(0.4)),
                  filled: true,
                  fillColor: kSurface,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: kPrimary, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: kDivider, width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedStatus,
                dropdownColor: kBackground,
                items: ["Pending", "In Progress", "Done"]
                    .map((status) => DropdownMenuItem(
                  value: status,
                  child: Text(status, style: TextStyle(color: kTextPrimary)),
                ))
                    .toList(),
                onChanged: (value) {
                  selectedStatus = value!;
                },
                decoration: InputDecoration(
                  labelText: "Status",
                  labelStyle: TextStyle(color: kTextSecondary),
                  filled: true,
                  fillColor: kSurface,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: kPrimary, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: kDivider, width: 1),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: kTextSecondary)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
    } else if (index == 4) {
      Navigator.pushNamed(context, "/deadline");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSurface,

      appBar: AppBar(
        backgroundColor: kPrimary,
        elevation: 0,
        title: const Text("Dashboard", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      drawer: Drawer(
        backgroundColor: kBackground,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [kPrimary, kDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
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
              leading: Icon(Icons.dashboard, color: kPrimary),
              title: Text("Dashboard", style: TextStyle(color: kTextPrimary)),
              onTap: () => Navigator.pushNamed(context, "/dashboard"),
            ),
            ListTile(
              leading: Icon(Icons.folder, color: kPrimary),
              title: Text("Projects", style: TextStyle(color: kTextPrimary)),
              onTap: () => Navigator.pushNamed(context, "/projectpage"),
            ),
            ListTile(
              leading: Icon(Icons.person, color: kPrimary),
              title: Text("Clients", style: TextStyle(color: kTextPrimary)),
              onTap: () => Navigator.pushNamed(context, "/clientpage"),
            ),
            ListTile(
              leading: Icon(Icons.payment, color: kPrimary),
              title: Text("Payments", style: TextStyle(color: kTextPrimary)),
              onTap: () => Navigator.pushNamed(context, "/payement"),
            ),

            Divider(color: kDivider),

            ListTile(
              leading: Icon(Icons.notifications, color: kPrimary),
              title: Text("Notifications", style: TextStyle(color: kTextPrimary)),
              onTap: () => Navigator.pushNamed(context, "/notifications"),
            ),
            ListTile(
              leading: Icon(Icons.call, color: kPrimary),
              title: Text("Contact Us", style: TextStyle(color: kTextPrimary)),
              onTap: () => Navigator.pushNamed(context, "/contactus"),
            ),
            ListTile(
              leading: Icon(Icons.share, color: kPrimary),
              title: Text("Share with Friend", style: TextStyle(color: kTextPrimary)),
              onTap: () => Navigator.pushNamed(context, "/sharing"),
            ),
            ListTile(
              leading: Icon(Icons.settings, color: kPrimary),
              title: Text("Profile & Account", style: TextStyle(color: kTextPrimary)),
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

              // ── Welcome Banner ──────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [kPrimary, kDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome back 👋",
                        style: TextStyle(color: Colors.white70)),
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
              // ────────────────────────────────────────────

              Text(
                "Your Overview",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: kTextPrimary,
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
                      color: kTextPrimary,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: showAddTaskDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text("Add Task"),
                  ),
                ],
              ),

              const SizedBox(height: 10),
              _TaskBox(tasks: tasks, primaryBlue: kPrimary),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
        selectedItemColor: kPrimary,
        unselectedItemColor: kTextSecondary.withOpacity(0.5),
        backgroundColor: kBackground,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: "Projects"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Clients"),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: "Payment"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: "Deadline"),
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
  final Color primaryBlue;

  const _TaskBox({required this.tasks, required this.primaryBlue});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFBFE4FF)),
      ),
      child: Column(
        children: [
          for (var task in tasks)
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFBFE4FF)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    task["title"]!,
                    style: const TextStyle(color: Color(0xFF0A1628)),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: task["status"] == "Done"
                          ? Colors.green.shade100
                          : task["status"] == "In Progress"
                          ? const Color(0xFFE8F6FF)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      task["status"]!,
                      style: TextStyle(
                        fontSize: 12,
                        color: task["status"] == "Done"
                            ? Colors.green.shade700
                            : task["status"] == "In Progress"
                            ? primaryBlue
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
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFBFE4FF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.analytics, color: Color(0xFF29B2FE)),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0A1628),
            ),
          ),
        ],
      ),
    );
  }
}