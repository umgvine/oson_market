// admin_users_screen.dart
import 'package:flutter/material.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  final List<Map<String, dynamic>> _users = [
    {
      'id': '1',
      'name': 'Azizbek Xasanov',
      'email': 'azizbek@example.com',
      'phone': '+998901234567',
      'orders': 12,
      'joined': '2023-01-15',
      'status': 'Aktiv',
    },
    {
      'id': '2',
      'name': 'Dilnoza Ergasheva',
      'email': 'dilnoza@example.com',
      'phone': '+998907654321',
      'orders': 8,
      'joined': '2023-03-22',
      'status': 'Aktiv',
    },
    {
      'id': '3',
      'name': 'Sarvar Abdullayev',
      'email': 'sarvar@example.com',
      'phone': '+998912345678',
      'orders': 3,
      'joined': '2023-05-10',
      'status': 'Bloklangan',
    },
    {
      'id': '4',
      'name': 'Shaxzod Yusupova',
      'email': 'shaxzod@example.com',
      'phone': '+998935791234',
      'orders': 18,
      'joined': '2022-11-30',
      'status': 'Aktiv',
    },
    {
      'id': '5',
      'name': 'Botir Tursunov',
      'email': 'botir@example.com',
      'phone': '+998945678912',
      'orders': 5,
      'joined': '2023-07-15',
      'status': 'Aktiv',
    },
  ];

  void _toggleUserStatus(String id) {
    setState(() {
      final user = _users.firstWhere((u) => u['id'] == id);
      user['status'] = user['status'] == 'Aktiv' ? 'Bloklangan' : 'Aktiv';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Foydalanuvchilarni qidirish...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {},
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(user['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user['email']),
                        const SizedBox(height: 4),
                        Text(user['phone']),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text('${user['orders']} ta buyurtma'),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: user['status'] == 'Aktiv'
                                    ? Colors.green.shade100
                                    : Colors.red.shade100,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                user['status'],
                                style: TextStyle(
                                  color: user['status'] == 'Aktiv'
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        user['status'] == 'Aktiv'
                            ? Icons.block
                            : Icons.check_circle,
                        color: user['status'] == 'Aktiv' ? Colors.red : Colors.green,
                      ),
                      onPressed: () => _toggleUserStatus(user['id']),
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