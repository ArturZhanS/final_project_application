import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/cart_service.dart';
import '../patterns/payment_strategy.dart';
import 'welcome_screen.dart'; // currentTheme үшін

class PaymentPage extends StatefulWidget {
  final double amount;

  const PaymentPage({super.key, required this.amount});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _numController = TextEditingController();
  final _cvvController = TextEditingController();
  final CheckOutFacade _facade = CheckOutFacade();
  bool _isLoading = false;

  final List<PaymentStrategy> _strategies = [
    VisaPaymentStrategy(),
    MasterCardPaymentStrategy(),
    KaspiGoldPaymentStrategy(),
  ];
  late PaymentStrategy _selectedStrategy;

  @override
  void initState() {
    super.initState();
    _selectedStrategy = _strategies[0];
  }

  void _pay() async {
    setState(() => _isLoading = true);
    try {
      await _facade.processPayment(
        _selectedStrategy,
        _numController.text,
        _cvvController.text,
        widget.amount,
      );

      if (!mounted) return;

      Provider.of<CartService>(context, listen: false).clear();

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("SÁTTI!"), // SUCCESS
          content: Text("Tólem ${_selectedStrategy.name} arqyly ótti."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                  ..pop()
                  ..pop()
                  ..pop();
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentTheme.backgroundColor,
      appBar: AppBar(title: const Text("Checkout")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              "Tólem somasy: \$${widget.amount}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            DropdownButton<PaymentStrategy>(
              isExpanded: true,
              value: _selectedStrategy,
              items: _strategies
                  .map((s) => DropdownMenuItem(value: s, child: Text(s.name)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedStrategy = v!),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: _numController,
              decoration: const InputDecoration(
                labelText: "Card Number",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: _cvvController,
              decoration: const InputDecoration(
                labelText: "CVV / PIN",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 30),

            _isLoading
                ? const CircularProgressIndicator()
                : SizedBox(
                    width: double.infinity,
                    child: currentTheme.createButton(
                      text: "TÓLEU",
                      onPressed: _pay,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
