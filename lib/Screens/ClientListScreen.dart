import 'package:flutter/material.dart';
import 'package:freelio/Screens/ClientDetailsScreen.dart';

class ClientListScreen extends StatefulWidget {
  const ClientListScreen({super.key});

  @override
  State<ClientListScreen> createState() => _ClientListScreenState();
}

class _ClientListScreenState extends State<ClientListScreen> {
  // 🎨 COLORS
  final Color primary = const Color(0xFF00C5AB);
  final Color dark = const Color(0xFF195A51);
  final Color bg = const Color(0xFFBABABA);
  final Color textDark = const Color(0xFF10423A);

  // 📌 DATA
  List<Map<String, String>> clients = [
    {
      "name": "Ali Ahmed",
      "company": "Freelance App",
      "email": "ali@gmail.com",
      "phone": "03001234567",
      "address": "Gujrat",
      "notes": "Regular client",
      "status": "Active",
    },
    {
      "name": "Faraz Ahmed",
      "company": "Design Studio",
      "email": "faraz@gmail.com",
      "phone": "03011234567",
      "address": "Lahore",
      "notes": "VIP client",
      "status": "VIP",
    },
  ];

  // 🔍 SEARCH
  TextEditingController searchController = TextEditingController();

  // ➕ FORM
  final name = TextEditingController();
  final company = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
  final notes = TextEditingController();

  int? editIndex;

  // 🧠 FILTER
  List<Map<String, String>> get filteredClients {
    final q = searchController.text.toLowerCase();

    return clients.where((c) {
      return c["name"]!.toLowerCase().contains(q) ||
          c["company"]!.toLowerCase().contains(q) ||
          c["email"]!.toLowerCase().contains(q);
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    name.dispose();
    company.dispose();
    email.dispose();
    phone.dispose();
    address.dispose();
    notes.dispose();
    super.dispose();
  }

  // ➕ ADD / EDIT
  void openSheet({int? index}) {
    if (index != null) {
      final c = clients[index];
      name.text = c["name"]!;
      company.text = c["company"]!;
      email.text = c["email"]!;
      phone.text = c["phone"]!;
      address.text = c["address"]!;
      notes.text = c["notes"]!;
      editIndex = index;
    } else {
      name.clear();
      company.clear();
      email.clear();
      phone.clear();
      address.clear();
      notes.clear();
      editIndex = null;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  editIndex == null ? "Add Client" : "Edit Client",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: dark,
                  ),
                ),

                const SizedBox(height: 10),

                _field("Name", name),
                _field("Company", company),
                _field("Email", email),
                _field("Phone", phone),
                _field("Address", address),
                _field("Notes", notes),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: dark,
                      padding: const EdgeInsets.all(14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        final data = {
                          "name": name.text,
                          "company": company.text,
                          "email": email.text,
                          "phone": phone.text,
                          "address": address.text,
                          "notes": notes.text,
                          "status": "Active",
                        };

                        if (editIndex == null) {
                          clients.add(data);
                        } else {
                          clients[editIndex!] = data;
                        }
                      });

                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Save Client",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _field(String label, TextEditingController c) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: c,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  void deleteClient(int i) {
    setState(() {
      clients.removeAt(i);
    });
  }

  Color statusColor(String status) {
    switch (status) {
      case "VIP":
        return Colors.orange;
      case "Lead":
        return Colors.blue;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,

      floatingActionButton: FloatingActionButton(
        backgroundColor: dark,
        onPressed: () => openSheet(),
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: dark,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(18),
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.dashboard, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    "Client Dashboard",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),

            // SEARCH
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: searchController,
                onChanged: (v) => setState(() {}),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: dark),
                  hintText: "Search clients...",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // GRID
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: filteredClients.length,

                // 🔥 FIXED (NO OVERFLOW)
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.72,
                ),

                itemBuilder: (context, i) {
                  final c = filteredClients[i];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ClientDetailScreen(client: c),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          )
                        ],
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // TOP
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                primary.withOpacity(0.2),
                                child: Text(
                                  c["name"]![0],
                                  style: TextStyle(color: dark),
                                ),
                              ),

                              PopupMenuButton(
                                onSelected: (value) {
                                  if (value == "edit") {
                                    openSheet(index: i);
                                  } else {
                                    deleteClient(i);
                                  }
                                },
                                itemBuilder: (_) => const [
                                  PopupMenuItem(
                                      value: "edit",
                                      child: Text("Edit")),
                                  PopupMenuItem(
                                      value: "delete",
                                      child: Text("Delete")),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          Text(
                            c["name"]!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: textDark,
                            ),
                          ),

                          Text(
                            c["company"]!,
                            style: const TextStyle(color: Colors.grey),
                          ),

                          const SizedBox(height: 10),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor(
                                  c["status"] ?? "Active")
                                  .withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              c["status"] ?? "Active",
                              style: TextStyle(
                                fontSize: 11,
                                color: statusColor(
                                    c["status"] ?? "Active"),
                              ),
                            ),
                          ),

                          const Spacer(),

                          Text(
                            c["phone"]!,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
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