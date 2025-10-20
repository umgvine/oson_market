import 'package:flutter/material.dart';
import '../services/cart_service.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();
  String _method = 'Card';
  final CartService _cart = CartService();
  bool _isPlacing = false;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _address.dispose();
    super.dispose();
  }

  void _placeOrder() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isPlacing = true);
    await Future.delayed(const Duration(seconds: 1));
    _cart.clear();
    setState(() => _isPlacing = false);
    if (!mounted) return;
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Заказ оформлен'),
        content: const Text('Спасибо! Ваш заказ был принят.'),
        actions: [
          TextButton(
            onPressed: () {
              if (mounted) Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
    if (!mounted) return;
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Оформление заказа')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _name,
                      decoration: const InputDecoration(labelText: 'Имя'),
                      validator: (v) =>
                          (v == null || v.isEmpty) ? 'Введите имя' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _phone,
                      decoration: const InputDecoration(labelText: 'Телефон'),
                      validator: (v) =>
                          (v == null || v.isEmpty) ? 'Введите телефон' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _address,
                      decoration: const InputDecoration(
                        labelText: 'Адрес доставки',
                      ),
                      maxLines: 3,
                      validator: (v) =>
                          (v == null || v.isEmpty) ? 'Введите адрес' : null,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _method,
                      items: const [
                        DropdownMenuItem(value: 'Card', child: Text('Карта')),
                        DropdownMenuItem(
                          value: 'Cash',
                          child: Text('Наличные'),
                        ),
                      ],
                      onChanged: (v) => setState(() => _method = v ?? 'Card'),
                      onSaved: (v) => _method = v ?? _method,
                      decoration: const InputDecoration(
                        labelText: 'Способ оплаты',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Итого: ${_cart.totalPrice.toStringAsFixed(0)} so\'m',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isPlacing ? null : _placeOrder,
                child: _isPlacing
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text('Подтвердить заказ'),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
