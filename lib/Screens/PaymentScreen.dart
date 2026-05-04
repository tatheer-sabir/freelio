import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  // ✅ SAFE INDEX
  int currentIndex = 3;

  // 🎨 COLORS
  static const Color kPrimary       = Color(0xFF29B2FE);
  static const Color kBackground    = Color(0xFFFFFFFF);
  static const Color kSurface       = Color(0xFFE8F6FF);
  static const Color kTextSecondary = Color(0xFF1D5C97);
  static const Color kDivider       = Color(0xFFBFE4FF);
  static const Color kDark          = Color(0xFF1D5C97);

  List<Map<String, dynamic>> payments = [
    {"name": "Ali Ahmed", "amount": "5000", "status": "Paid"},
    {"name": "Sara Khan", "amount": "3200", "status": "Pending"},
    {"name": "Usman Tariq", "amount": "7800", "status": "Paid"},
    {"name": "Ayesha Malik", "amount": "1500", "status": "Pending"},
  ];

  String searchQuery = "";
  String filter = "All";

  final searchController = TextEditingController();

  // ✅ SAFE NAVIGATION (NO STACK BUILDUP)
  void onTap(int index) {
    if (index == currentIndex) return;

    setState(() => currentIndex = index);

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, "/dashboard");
        break;
      case 1:
        Navigator.pushReplacementNamed(context, "/projectpage");
        break;
      case 2:
        Navigator.pushReplacementNamed(context, "/clientpage");
        break;
      case 3:
        Navigator.pushReplacementNamed(context, "/payement");
        break;
      case 4:
        Navigator.pushReplacementNamed(context, "/deadline");
        break;
    }
  }

  List<Map<String, dynamic>> get filteredPayments {
    return payments.where((p) {
      final nameMatch =
      p["name"].toLowerCase().contains(searchQuery.toLowerCase());

      final statusMatch =
      filter == "All" ? true : p["status"] == filter;

      return nameMatch && statusMatch;
    }).toList();
  }

  void toggleStatus(int index, bool value) {
    setState(() {
      payments[index]["status"] = value ? "Paid" : "Pending";
    });
  }

  int getTotalPaid() {
    int total = 0;
    for (var p in payments) {
      if (p["status"] == "Paid") {
        total += int.parse(p["amount"]);
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSurface,

      // ✅ APPBAR
      appBar: AppBar(
        backgroundColor: kPrimary,
        title: const Text("Payments"),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // ✅ DRAWER
      drawer: Drawer(
        backgroundColor: kBackground,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [

            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [kPrimary, kDark],
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
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Welcome Back!",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.dashboard, color: kPrimary),
              title: const Text("Dashboard"),
              onTap: () => Navigator.pushNamed(context, "/dashboard"),
            ),

            ListTile(
              leading: const Icon(Icons.folder, color: kPrimary),
              title: const Text("Projects"),
              onTap: () => Navigator.pushNamed(context, "/projectpage"),
            ),

            ListTile(
              leading: const Icon(Icons.person, color: kPrimary),
              title: const Text("Clients"),
              onTap: () => Navigator.pushNamed(context, "/clientpage"),
            ),

            ListTile(
              leading: const Icon(Icons.payment, color: kPrimary),
              title: const Text("Payments"),
              onTap: () => Navigator.pushNamed(context, "/payement"),
            ),

            Divider(color: kDivider),

            ListTile(
              leading: const Icon(Icons.notifications, color: kPrimary),
              title: const Text("Notifications"),
              onTap: () => Navigator.pushNamed(context, "/notifications"),
            ),

            ListTile(
              leading: const Icon(Icons.share, color: kPrimary),
              title: const Text("Share with Friend"),
              onTap: () => Navigator.pushNamed(context, "/sharing"),
            ),

            ListTile(
              leading: const Icon(Icons.call, color: kPrimary),
              title: const Text("Contact Us"),
              onTap: () => Navigator.pushNamed(context, "/contactus"),
            ),

            ListTile(
              leading: const Icon(Icons.settings, color: kPrimary),
              title: const Text("Profile & Account"),
              onTap: () => Navigator.pushNamed(context, "/profile"),
            ),
          ],
        ),
      ),
      // ✅ BOTTOM NAV (SAFE INDEX)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex.clamp(0, 4), // 🔥 FIXED
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

      // ✅ BODY
      body: Column(
        children: [

          // SUMMARY
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kDark,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              "Total Paid: PKR ${getTotalPaid()}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // SEARCH
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() => searchQuery = value);
              },
              decoration: InputDecoration(
                hintText: "Search client...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // FILTER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              filterButton("All"),
              filterButton("Paid"),
              filterButton("Pending"),
            ],
          ),

          const SizedBox(height: 10),

          // LIST
          Expanded(
            child: filteredPayments.isEmpty
                ? const Center(child: Text("No payments found"))
                : ListView.builder(
              itemCount: filteredPayments.length,
              itemBuilder: (context, i) {
                final p = filteredPayments[i];

                return Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(p["name"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600)),
                          Text("PKR ${p["amount"]}"),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: p["status"] == "Paid",
                            onChanged: (value) {
                              int realIndex =
                              payments.indexOf(p);
                              toggleStatus(realIndex, value!);
                            },
                          ),
                          Container(
                            padding:
                            const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5),
                            decoration: BoxDecoration(
                              color: p["status"] == "Paid"
                                  ? Colors.blueGrey
                                  : Colors.lightBlue,
                              borderRadius:
                              BorderRadius.circular(10),
                            ),
                            child: Text(
                              p["status"],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12),
                            ),
                          ),
                        ],
                      ),
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

  Widget filterButton(String type) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
        filter == type ? kDark : Colors.grey.shade300,
        foregroundColor:
        filter == type ? Colors.white : Colors.black,
      ),
      onPressed: () {
        setState(() => filter = type);
      },
      child: Text(type),
    );
  }
}