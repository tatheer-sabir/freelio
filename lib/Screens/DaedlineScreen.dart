import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Daedlinescreen extends StatefulWidget {
  const Daedlinescreen({super.key});

  @override
  State<Daedlinescreen> createState() => _DaedlinescreenState();
}

class _DaedlinescreenState extends State<Daedlinescreen> {
  int currentIndex = 4; // ← fixed: this is the Deadline tab (index 4)

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
  Map<DateTime, List<Project>> deadlines = {};
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await Future.delayed(const Duration(milliseconds: 300));

    projects = [
      Project(name: "Portfolio Website", deadline: DateTime(2026, 5, 5)),
      Project(name: "Client Logo", deadline: DateTime(2026, 5, 7)),
      Project(name: "App UI Design", deadline: DateTime(2026, 5, 7)),
      Project(name: "Freelio Dashboard", deadline: DateTime(2026, 5, 10)),
    ];

    deadlines = groupByDate(projects);
    setState(() {});
  }

  Map<DateTime, List<Project>> groupByDate(List<Project> projects) {
    Map<DateTime, List<Project>> data = {};
    for (var p in projects) {
      final date = DateTime(p.deadline.year, p.deadline.month, p.deadline.day);
      if (data[date] == null) data[date] = [];
      data[date]!.add(p);
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final selectedProjects = deadlines[
    DateTime(
      selectedDay?.year ?? 0,
      selectedDay?.month ?? 0,
      selectedDay?.day ?? 0,
    )] ??
        [];

    return Scaffold(
      backgroundColor: kSurface,

      appBar: AppBar(
        backgroundColor: kPrimary,
        elevation: 0,
        title: const Text("Deadlines",
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
              title:
              Text("Notifications", style: TextStyle(color: kTextPrimary)),
              onTap: () => Navigator.pushNamed(context, "/notifications"),
            ),
            ListTile(
              leading: Icon(Icons.call, color: kPrimary),
              title: Text("Contact Us", style: TextStyle(color: kTextPrimary)),
              onTap: () => Navigator.pushNamed(context, "/contactus"),
            ),
            ListTile(
              leading: Icon(Icons.share, color: kPrimary),
              title: Text("Share with Friend",
                  style: TextStyle(color: kTextPrimary)),
              onTap: () => Navigator.pushNamed(context, "/sharing"),
            ),
            ListTile(
              leading: Icon(Icons.settings, color: kPrimary),
              title: Text("Profile & Account",
                  style: TextStyle(color: kTextPrimary)),
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
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: "Deadline"),
        ],
      ),

      body: Column(
        children: [

          // ───────── CALENDAR ─────────
          Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kBackground,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: kDivider),
            ),
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: focusedDay,

              selectedDayPredicate: (day) => isSameDay(selectedDay, day),

              eventLoader: (day) {
                return deadlines[DateTime(day.year, day.month, day.day)] ?? [];
              },

              onDaySelected: (selected, focused) {
                setState(() {
                  selectedDay = selected;
                  focusedDay = focused;
                });
              },

              // Calendar style — blue theme
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: kPrimary.withOpacity(0.25),
                  shape: BoxShape.circle,
                ),
                todayTextStyle: const TextStyle(
                  color: kTextPrimary,
                  fontWeight: FontWeight.bold,
                ),
                selectedDecoration: const BoxDecoration(
                  color: kPrimary,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: const TextStyle(color: Colors.white),
                weekendTextStyle: TextStyle(color: kTextSecondary),
                defaultTextStyle: TextStyle(color: kTextPrimary),
                outsideTextStyle:
                TextStyle(color: kTextSecondary.withOpacity(0.3)),
              ),

              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  color: kTextPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                leftChevronIcon:
                Icon(Icons.chevron_left, color: kPrimary),
                rightChevronIcon:
                Icon(Icons.chevron_right, color: kPrimary),
              ),

              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                    color: kTextSecondary, fontWeight: FontWeight.w600),
                weekendStyle: TextStyle(
                    color: kPrimary, fontWeight: FontWeight.w600),
              ),

              // Blue dot markers instead of red
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) {
                  if (events.isNotEmpty) {
                    return Positioned(
                      bottom: 4,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: kPrimary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
          ),

          const SizedBox(height: 4),

          // ───────── PROJECT LIST ─────────
          Expanded(
            child: selectedProjects.isEmpty
                ? Center(
              child: Text(
                "No deadlines for this day",
                style: TextStyle(
                    color: kTextSecondary.withOpacity(0.6),
                    fontSize: 14),
              ),
            )
                : ListView.builder(
              itemCount: selectedProjects.length,
              itemBuilder: (context, index) {
                final project = selectedProjects[index];

                return Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: kBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: kDivider),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: kSurface,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.calendar_today,
                            color: kPrimary, size: 18),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project.name,
                              style: TextStyle(
                                color: kTextPrimary,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Due: ${project.deadline.toLocal().toString().split(' ')[0]}",
                              style: TextStyle(
                                color: kTextSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.warning_amber_rounded,
                          color: Colors.orange, size: 20),
                    ],
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}

// ───────── MODEL CLASS ─────────
class Project {
  final String name;
  final DateTime deadline;

  Project({required this.name, required this.deadline});
}