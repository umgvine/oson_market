import 'package:flutter/material.dart';

class AdminOrdersScreen extends StatefulWidget {
  const AdminOrdersScreen({super.key});

  @override
  State<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> {
  String _selectedStatus = 'Barchasi';
  final List<String> _statuses = [
    'Barchasi',
    'Yangi',
    'Qabul qilindi',
    'Yetkazilmoqda',
    'Yetkazib berildi',
    'Bekor qilindi'
  ];

  final List<Map<String, dynamic>> _orders = [
    {
      'id': '#OS12345',
      'customer': 'Azizbek Xasanov',
      'date': '15 Okt, 2023',
      'amount': '1,249,000 so\'m',
      'status': 'Yangi',
      'items': 3,
    },
    {
      'id': '#OS12346',
      'customer': 'Dilnoza Ergasheva',
      'date': '14 Okt, 2023',
      'amount': '899,000 so\'m',
      'status': 'Yetkazilmoqda',
      'items': 1,
    },
    {
      'id': '#OS12347',
      'customer': 'Sarvar Abdullayev',
      'date': '13 Okt, 2023',
      'amount': '2,450,000 so\'m',
      'status': 'Yetkazib berildi',
      'items': 5,
    },
    {
      'id': '#OS12348',
      'customer': 'Shaxzod Yusupova',
      'date': '12 Okt, 2023',
      'amount': '549,000 so\'m',
      'status': 'Qabul qilindi',
      'items': 2,
    },
  ];

  void _updateStatus(String orderId, String newStatus) {
    setState(() {
      final order = _orders.firstWhere((o) => o['id'] == orderId);
      order['status'] = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredOrders = _selectedStatus == 'Barchasi'
        ? _orders
        : _orders.where((o) => o['status'] == _selectedStatus).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              DropdownButton<String>(
                value: _selectedStatus,
                items: _statuses.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedStatus = value!),
              ),
              const SizedBox(width: 16),
              
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Sana bo\'yicha qidirish',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        Expanded(
          child: ListView.builder(
            itemCount: filteredOrders.length,
            itemBuilder: (context, index) {
              final order = filteredOrders[index];
              final statusColor = _getStatusColor(order['status']);
              
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            order['id'],
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(25), // 0.1 opacity o'rniga withAlpha(25)
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: statusColor),
                            ),
                            child: Text(
                              order['status'],
                              style: TextStyle(
                                color: statusColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text('Mijoz: ${order['customer']}'),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Sana: ${order['date']}'),
                          Text('${order['items']} ta mahsulot'),
                          Text(order['amount']),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => _statusBottomSheet(order['id']),
                                );
                              },
                              child: const Text('HOLATNI O\'ZGARTIRISH'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('BATAFSIL'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Yangi': return Colors.orange;
      case 'Qabul qilindi': return Colors.blue;
      case 'Yetkazilmoqda': return Colors.purple;
      case 'Yetkazib berildi': return Colors.green;
      case 'Bekor qilindi': return Colors.red;
      default: return Colors.grey;
    }
  }

  Widget _statusBottomSheet(String orderId) {
    const statuses = [
      'Yangi',
      'Qabul qilindi',
      'Yetkazilmoqda',
      'Yetkazib berildi',
      'Bekor qilindi'
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Buyurtma holatini o\'zgartirish',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          for (final status in statuses)
            ListTile(
              title: Text(status),
              onTap: () {
                _updateStatus(orderId, status);
                Navigator.pop(context);
              },
            ),
        ],
      ),
    );
  }
}