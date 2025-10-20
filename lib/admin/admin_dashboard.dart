// admin_dashboard.dart
import 'package:flutter/material.dart';
import 'admin_products_screen.dart';
import 'admin_orders_screen.dart';
import 'admin_users_screen.dart';
import 'admin_categories_screen.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardHome(),
    const AdminProductsScreen(),
    const AdminOrdersScreen(),
    const AdminUsersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boshqaruv Paneli'),
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: _screens[_currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          bottomNavigationBarTheme: Theme.of(context).bottomNavigationBarTheme,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Bosh sahifa',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Mahsulotlar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'Buyurtmalar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Foydalanuvchilar',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue.shade700),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.blue),
                ),
                SizedBox(height: 10),
                Text(
                  'Admin User',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'admin@osonmarket.uz',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          _drawerItem(Icons.dashboard, 'Bosh sahifa', 0),
          _drawerItem(Icons.shopping_bag, 'Mahsulotlar', 1),
          _drawerItem(Icons.list_alt, 'Buyurtmalar', 2),
          _drawerItem(Icons.people, 'Foydalanuvchilar', 3),
          const Divider(),
          _drawerItem(
            Icons.category,
            'Kategoriyalar',
            -1,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AdminCategoriesScreen(),
                ),
              );
            },
          ),
          _drawerItem(Icons.analytics, 'Hisobotlar', -1),
          _drawerItem(Icons.settings, 'Sozlamalar', -1),
          _drawerItem(Icons.help, 'Yordam', -1),
          const Divider(),
          _drawerItem(
            Icons.exit_to_app,
            'Chiqish',
            -1,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(
    IconData icon,
    String title,
    int index, {
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: _currentIndex == index,
      onTap:
          onTap ??
          () {
            setState(() => _currentIndex = index);
            Navigator.pop(context);
          },
    );
  }
}

class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Statistika',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _statCard(
                'Jami buyurtmalar',
                '1,248',
                Icons.shopping_cart,
                Colors.blue,
              ),
              _statCard(
                'Aktiv foydalanuvchilar',
                '5,672',
                Icons.people,
                Colors.green,
              ),
              _statCard(
                'Jami mahsulotlar',
                '2,341',
                Icons.shopping_bag,
                Colors.orange,
              ),
              _statCard(
                'Oylik daromad',
                '24.8M so\'m',
                Icons.attach_money,
                Colors.purple,
              ),
            ],
          ),
          const SizedBox(height: 24),

          const Text(
            'So\'ngi faoliyat',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _recentActivity(),
        ],
      ),
    );
  }

  Widget _statCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 10),
            Text(title, style: TextStyle(color: Colors.grey.shade600)),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recentActivity() {
    final activities = [
      {
        'user': 'Azizbek Xasanov',
        'action': 'Yangi mahsulot qo\'shdi',
        'time': '5 min oldin',
      },
      {
        'user': 'Dilnoza Ergasheva',
        'action': 'Buyurtmani tasdiqladi',
        'time': '20 min oldin',
      },
      {
        'user': 'Sarvar Abdullayev',
        'action': 'Foydalanuvchini blokladi',
        'time': '1 soat oldin',
      },
      {
        'user': 'Shaxzod Yusupova',
        'action': 'Kategoriyani yangiladi',
        'time': '2 soat oldin',
      },
      {
        'user': 'Botir Tursunov',
        'action': 'Chegirma e\'lon qildi',
        'time': '5 soat oldin',
      },
    ];

    return Card(
      elevation: 2,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: activities.length,
        itemBuilder: (context, index) {
          final item = activities[index];
          return ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(item['user']!),
            subtitle: Text(item['action']!),
            trailing: Text(
              item['time']!,
              style: const TextStyle(color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}
