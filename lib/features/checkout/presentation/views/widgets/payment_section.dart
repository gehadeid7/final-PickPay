// import 'package:flutter/material.dart';
// import 'package:pickpay/features/checkout/presentation/views/widgets/order_summary_widget.dart';

// class PaymentSection extends StatelessWidget {
//   const PaymentSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(height: 24),
//         OrderSummaryWidget(),
//       ],
//     );
//   }
// }
// features/checkout/presentation/widgets/payment_method_selector.dart
import 'package:flutter/material.dart';

class PaymentMethodSelector extends StatefulWidget {
  final void Function(String method) onMethodSelected;
  final void Function(String number, String expiry, String cvv)
      onCardDetailsSaved;

  const PaymentMethodSelector({
    super.key,
    required this.onMethodSelected,
    required this.onCardDetailsSaved,
  });

  @override
  State<PaymentMethodSelector> createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends State<PaymentMethodSelector> {
  String _selectedMethod = 'Credit Card';
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          value: _selectedMethod,
          items: const [
            DropdownMenuItem(
              value: 'Credit Card',
              child: Text('Credit Card'),
            ),
            DropdownMenuItem(
              value: 'Cash on Delivery',
              child: Text('Cash on Delivery'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              _selectedMethod = value!;
            });
            widget.onMethodSelected(value!);
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
        if (_selectedMethod == 'Credit Card') ...[
          const SizedBox(height: 16),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _cardNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Card Number',
                    prefixIcon: Icon(Icons.credit_card),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter card number';
                    }
                    if (value.length < 16) {
                      return 'Card number must be 16 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _expiryController,
                        decoration: const InputDecoration(
                          labelText: 'Expiry (MM/YY)',
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter expiry date';
                          }
                          if (!RegExp(r'^(0[1-9]|1[0-2])\/?([0-9]{2})$')
                              .hasMatch(value)) {
                            return 'Invalid format (MM/YY)';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _cvvController,
                        decoration: const InputDecoration(
                          labelText: 'CVV',
                          prefixIcon: Icon(Icons.lock),
                        ),
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter CVV';
                          }
                          if (value.length < 3) {
                            return 'CVV must be 3-4 digits';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.onCardDetailsSaved(
                        _cardNumberController.text,
                        _expiryController.text,
                        _cvvController.text,
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.blue),
                    foregroundColor:
                        WidgetStateProperty.all<Color>(Colors.white),
                  ),
                  child: const Text('Save Card Details'),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
