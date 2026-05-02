import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final Color darkTeal = const Color(0xFF195A51);

  List<Map<String, dynamic>> payments = [
    {"name": "Ali Ahmed", "amount": "5000", "status": "Paid"},
    {"name": "Sara Khan", "amount": "3200", "status": "Pending"},
    {"name": "Usman Tariq", "amount": "7800", "status": "Paid"},
    {"name": "Ayesha Malik", "amount": "1500", "status": "Pending"},
    {"name": "Hassan Ali", "amount": "9000", "status": "Paid"},
    {"name": "Zainab Noor", "amount": "4100", "status": "Paid"},
    {"name": "Bilal Ahmed", "amount": "2500", "status": "Pending"},
  ];

  String searchQuery = "";
  String filter = "All"; // All / Paid / Pending

  final searchController = TextEditingController();

  List<Map<String, dynamic>> get filteredPayments {
    return payments.where((p) {
      final nameMatch = p["name"]
          .toLowerCase()
          .contains(searchQuery.toLowerCase());

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
      backgroundColor: const Color(0xFFB8B6B6),

      appBar: AppBar(
        backgroundColor: darkTeal,
        title: const Text("Payments",
            style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Column(
        children: [

          // 💳 SUMMARY
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: darkTeal,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              "Total Paid: PKR ${getTotalPaid()}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // 🔍 SEARCH BAR
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
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

          // 🎛 FILTER BUTTONS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                filterButton("All"),
                filterButton("Paid"),
                filterButton("Pending"),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // 📋 LIST
          Expanded(
            child: filteredPayments.isEmpty
                ? const Center(
              child: Text("No payments found"),
            )
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
                          Text(
                            p["name"],
                            style: const TextStyle(
                                fontWeight: FontWeight.w600),
                          ),
                          Text("PKR ${p["amount"]}"),
                        ],
                      ),

                      Row(
                        children: [

                          Checkbox(
                            value: p["status"] == "Paid",
                            activeColor: Colors.teal,
                            onChanged: (value) {
                              // find real index in original list
                              int realIndex = payments.indexOf(p);
                              toggleStatus(realIndex, value!);
                            },
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: p["status"] == "Paid"
                                  ? Colors.grey
                                  : Colors.teal,
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
        filter == type ? darkTeal : Colors.grey.shade300,
        foregroundColor:
        filter == type ? Colors.white : Colors.black,
      ),
      onPressed: () {
        setState(() {
          filter = type;
        });
      },
      child: Text(type),
    );
  }
}