import 'package:flutter/material.dart';
import 'package:freelio/Screens/ClientDetailsScreen.dart';

class ClientListScreen extends StatefulWidget {
  const ClientListScreen({super.key});

  @override
  State<ClientListScreen> createState() => _ClientListScreenState();
}

class _ClientListScreenState extends State<ClientListScreen> {

  int currentIndex = 2;

  static const Color kPrimary       = Color(0xFF29B2FE);
  static const Color kBackground    = Color(0xFFFFFFFF);
  static const Color kSurface       = Color(0xFFE8F6FF);
  static const Color kTextPrimary   = Color(0xFF0A1628);
  static const Color kTextSecondary = Color(0xFF1D5C97);
  static const Color kDivider       = Color(0xFFBFE4FF);
  static const Color kDark          = Color(0xFF1D5C97);

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

  TextEditingController searchController = TextEditingController();

  final name = TextEditingController();
  final company = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
  final notes = TextEditingController();

  int? editIndex;

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
                    color: kDark,
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
                      backgroundColor: kDark,
                      padding: const EdgeInsets.all(14),
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
        return Colors.blueGrey;
      case "Lead":
        return Colors.blue;
      default:
        return Colors.lightBlueAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSurface,

      appBar: AppBar(
        backgroundColor: kPrimary,
        title: const Text("Clients"),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: kDark,
        onPressed: () => openSheet(),
        child: const Icon(Icons.add, color: Colors.white),
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

      // ✅ DIRECT BODY (NO HEADER)
      body: Column(
        children: [

          // SEARCH
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onChanged: (v) => setState(() {}),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: kDark),
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
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor:
                              kPrimary.withOpacity(0.2),
                              child: Text(
                                c["name"]![0],
                                style: TextStyle(color: kDark),
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
                            color: kTextPrimary,
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
    );
  }
}