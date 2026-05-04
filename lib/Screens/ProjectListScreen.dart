import 'package:flutter/material.dart';

class Projectlistscreen extends StatefulWidget {
  const Projectlistscreen({super.key});

  @override
  State<Projectlistscreen> createState() => _ProjectlistscreenState();
}

class _ProjectlistscreenState extends State<Projectlistscreen> {
  int currentIndex = 1;

  static const Color kPrimary       = Color(0xFF29B2FE);
  static const Color kBackground    = Color(0xFFFFFFFF);
  static const Color kSurface       = Color(0xFFE8F6FF);
  static const Color kTextPrimary   = Color(0xFF0A1628);
  static const Color kTextSecondary = Color(0xFF1D5C97);
  static const Color kDivider       = Color(0xFFBFE4FF);
  static const Color kDark          = Color(0xFF1D5C97);

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

  List<Project> projects = [];

  @override
  void initState() {
    super.initState();
    loadProjects();
  }

  void loadProjects() {
    projects = [
      Project(name: "Portfolio Website", deadline: DateTime(2026, 5, 5)),
      Project(name: "Client Logo Design", deadline: DateTime(2026, 5, 7)),
      Project(name: "Freelio Dashboard UI", deadline: DateTime(2026, 5, 10)),
    ];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSurface,

      appBar: AppBar(
        backgroundColor: kPrimary,
        elevation: 0,
        title: const Text("Projects",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
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
                  Text("Freelio",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                  Text("Welcome Back!",
                      style: TextStyle(color: Colors.white70)),
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

      body: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 16),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final project = projects[index];

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: kBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: project.isCompleted
                    ? Colors.green.shade200
                    : kDivider,
              ),
            ),
            child: Row(
              children: [

                // ── Checkbox ──────────────────────────────
                Checkbox(
                  value: project.isCompleted,
                  activeColor: kPrimary,
                  checkColor: Colors.white,
                  side: BorderSide(color: kPrimary, width: 1.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  onChanged: (value) {
                    setState(() {
                      project.isCompleted = value!;
                    });
                  },
                ),
                // ─────────────────────────────────────────

                const SizedBox(width: 8),

                // ── Project Info ──────────────────────────
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: project.isCompleted
                              ? kTextSecondary.withOpacity(0.5)
                              : kTextPrimary,
                          decoration: project.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                          decorationColor: kTextSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Due: ${project.deadline.toLocal().toString().split(' ')[0]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: kTextSecondary.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                // ─────────────────────────────────────────

                // ── Status Icon ───────────────────────────
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: project.isCompleted
                        ? Colors.green.shade50
                        : kSurface,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        project.isCompleted
                            ? Icons.check_circle
                            : Icons.pending,
                        color: project.isCompleted
                            ? Colors.green.shade600
                            : Colors.orange,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        project.isCompleted ? "Done" : "Pending",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: project.isCompleted
                              ? Colors.green.shade600
                              : Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
                // ─────────────────────────────────────────

              ],
            ),
          );
        },
      ),
    );
  }
}

// ───────── MODEL ─────────
class Project {
  final String name;
  final DateTime deadline;
  bool isCompleted;

  Project({
    required this.name,
    required this.deadline,
    this.isCompleted = false,
  });
}