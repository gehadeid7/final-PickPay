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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      color: colorScheme.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
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
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: colorScheme.outline),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorScheme.outline),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              style: TextStyle(color: colorScheme.onSurface),
              dropdownColor: colorScheme.surface,
            ),
            if (_selectedMethod == 'Credit Card') ...[
              const SizedBox(height: 16),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _cardNumberController,
                      style: TextStyle(color: colorScheme.onSurface),
                      decoration: InputDecoration(
                        labelText: 'Card Number',
                        labelStyle: TextStyle(
                            // ignore: deprecated_member_use
                            color: colorScheme.onSurface.withOpacity(0.7)),
                        prefixIcon: Icon(Icons.credit_card,
                            // ignore: deprecated_member_use
                            color: colorScheme.onSurface.withOpacity(0.7)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              // ignore: deprecated_member_use
                              color: colorScheme.outline.withOpacity(0.5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorScheme.primary),
                        ),
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
                            style: TextStyle(color: colorScheme.onSurface),
                            decoration: InputDecoration(
                              labelText: 'Expiry (MM/YY)',
                              labelStyle: TextStyle(
                                  color:
                                      // ignore: deprecated_member_use
                                      colorScheme.onSurface.withOpacity(0.7)),
                              prefixIcon: Icon(Icons.calendar_today,
                                  color:
                                      // ignore: deprecated_member_use
                                      colorScheme.onSurface.withOpacity(0.7)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        // ignore: deprecated_member_use
                                        colorScheme.outline.withOpacity(0.5)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: colorScheme.primary),
                              ),
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
                            style: TextStyle(color: colorScheme.onSurface),
                            decoration: InputDecoration(
                              labelText: 'CVV',
                              labelStyle: TextStyle(
                                  color:
                                      // ignore: deprecated_member_use
                                      colorScheme.onSurface.withOpacity(0.7)),
                              prefixIcon: Icon(Icons.lock,
                                  color:
                                      // ignore: deprecated_member_use
                                      colorScheme.onSurface.withOpacity(0.7)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        // ignore: deprecated_member_use
                                        colorScheme.outline.withOpacity(0.5)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: colorScheme.primary),
                              ),
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      child: const Text('Save Card Details'),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
