// admin_product_edit_screen.dart
import 'package:flutter/material.dart';

class AdminProductEditScreen extends StatefulWidget {
  final Map<String, dynamic>? product;
  final Function(Map<String, dynamic>) onSave;

  const AdminProductEditScreen({required this.onSave, this.product, super.key});

  @override
  State<AdminProductEditScreen> createState() => _AdminProductEditScreenState();
}

class _AdminProductEditScreenState extends State<AdminProductEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _stockController;
  late TextEditingController _descController;
  String? _selectedCategory;
  bool _isActive = true;

  final List<String> _categories = [
    'Elektronika',
    'Kiyimlar',
    'Poyabzallar',
    'Aksesuarlar',
    'Kosmetika',
    'Uy uchun',
    'Oziq-ovqat',
    'Kitoblar',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.product?['name'] ?? '',
    );
    _priceController = TextEditingController(
      text: widget.product?['price']?.replaceAll(' so\'m', '') ?? '',
    );
    _stockController = TextEditingController(
      text: widget.product?['stock']?.toString() ?? '0',
    );
    _descController = TextEditingController(
      text: widget.product?['desc'] ?? '',
    );
    _selectedCategory = widget.product?['category'] ?? _categories.first;
    _isActive = widget.product?['status'] == 'Faol';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      final newProduct = {
        'id':
            widget.product?['id'] ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        'name': _nameController.text,
        'category': _selectedCategory,
        'price': '${_priceController.text} so\'m',
        'stock': int.parse(_stockController.text),
        'status': _isActive ? 'Faol' : 'Nofaol',
        'desc': _descController.text,
        'created': widget.product?['created'] ?? DateTime.now().toString(),
      };

      widget.onSave(newProduct);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product == null ? 'Yangi mahsulot' : 'Mahsulotni tahrirlash',
        ),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _saveProduct),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Mahsulot nomi',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Iltimos, mahsulot nomini kiriting';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Kategoriya',
                  border: OutlineInputBorder(),
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) =>
                    setState(() => _selectedCategory = value ?? _categories.first),
                onSaved: (value) =>
                    _selectedCategory = value ?? _selectedCategory ?? _categories.first,
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Narxi (so\'m)',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Iltimos, narxni kiriting';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Noto\'g\'ri raqam formati';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),

                  Expanded(
                    child: TextFormField(
                      controller: _stockController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Zahira (dona)',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Iltimos, zahirani kiriting';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Butun son kiriting';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _descController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Mahsulot tavsifi',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              SwitchListTile(
                title: const Text('Mahsulot faolmi?'),
                value: _isActive,
                onChanged: (value) => setState(() => _isActive = value),
              ),
              const SizedBox(height: 16),

              const Text(
                'Mahsulot rasmlari',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (int i = 0; i < 3; i++)
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: i == 0
                          ? const Icon(Icons.add, size: 40)
                          : Image.asset(
                              'assets/placeholders/placeholder.png',
                              fit: BoxFit.cover,
                              errorBuilder: (c, e, s) =>
                                  const Icon(Icons.broken_image),
                            ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
