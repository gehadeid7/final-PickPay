import 'dart:convert';
import 'package:flutter/services.dart';

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
  String? _cardBrand;
  bool _showSuccess = false;

  @override
  void initState() {
    super.initState();
    // Load last used payment method and card details
    final lastMethod = Prefs.getString('last_payment_method');
    if (lastMethod.isNotEmpty) {
      setState(() {
        _selectedMethod = lastMethod;
      });
    }
    final lastCard = Prefs.getString('last_card_details');
    if (lastCard.isNotEmpty) {
      try {
        final card = Map<String, dynamic>.from(jsonDecode(lastCard));
        _cardNumberController.text = card['number'] ?? '';
        _expiryController.text = card['expiry'] ?? '';
        _cvvController.text = card['cvv'] ?? '';
      } catch (e) {
        // ignore parse errors
      }
    }
    _cardNumberController.addListener(_detectCardBrand);
  }

  void _detectCardBrand() {
    final number = _cardNumberController.text.replaceAll(' ', '');
    if (number.startsWith('4')) {
      setState(() => _cardBrand = 'Visa');
    } else if (number.startsWith('5')) {
      setState(() => _cardBrand = 'MasterCard');
    } else if (number.startsWith('3')) {
      setState(() => _cardBrand = 'American Express');
    } else {
      setState(() => _cardBrand = null);
    }
  }

  Widget _buildCardBrandIcon() {
    if (_cardBrand == 'Visa') {
      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Image.asset('assets/icons/visa.png', height: 24),
      );
    } else if (_cardBrand == 'MasterCard') {
      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Image.asset('assets/icons/mastercard.png', height: 24),
      );
    } else if (_cardBrand == 'American Express') {
      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Image.asset('assets/icons/amex.png', height: 24),
      );
    }
    return const SizedBox(width: 32);
  }

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

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: _showSuccess
          ? Center(
              key: const ValueKey('success'),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: colorScheme.primary, size: 64),
                  const SizedBox(height: 12),
                  Text('Payment information saved!',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            )
          : Card(
              key: const ValueKey('form'),
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
                        if (value == null) return;
                        setState(() {
                          _selectedMethod = value;
                        });
                        Prefs.setString('last_payment_method', value);
                        widget.onMethodSelected(value);
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
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _cardNumberController,
                                    style: TextStyle(color: colorScheme.onSurface),
                                    decoration: InputDecoration(
                                      labelText: 'Card Number',
                                      labelStyle: TextStyle(
                                          color: colorScheme.onSurface.withOpacity(0.7)),
                                      prefixIcon: Icon(Icons.credit_card,
                                          color: colorScheme.onSurface.withOpacity(0.7)),
                                      suffixIcon: _buildCardBrandIcon(),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: colorScheme.outline.withOpacity(0.5)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: colorScheme.primary),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    maxLength: 19,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      _CardNumberInputFormatter(),
                                    ],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter card number';
                                      }
                                      final digits = value.replaceAll(' ', '');
                                      if (!RegExp(r'^\d{16} $').hasMatch(digits)) {
                                        return 'Card number must be 16 digits';
                                      }
                                      if (!_luhnCheck(digits)) {
                                        return 'Invalid card number';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
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
                                          color: colorScheme.onSurface.withOpacity(0.7)),
                                      prefixIcon: Icon(Icons.calendar_today,
                                          color: colorScheme.onSurface.withOpacity(0.7)),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: colorScheme.outline.withOpacity(0.5)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: colorScheme.primary),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    maxLength: 5,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      _ExpiryDateInputFormatter(),
                                    ],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter expiry date';
                                      }
                                      if (!RegExp(r'^(0[1-9]|1[0-2])\/([0-9]{2})$').hasMatch(value)) {
                                        return 'Invalid format (MM/YY)';
                                      }
                                      if (!_isFutureDate(value)) {
                                        return 'Expiry must be in the future';
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
                                          color: colorScheme.onSurface.withOpacity(0.7)),
                                      prefixIcon: Icon(Icons.lock,
                                          color: colorScheme.onSurface.withOpacity(0.7)),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: colorScheme.outline.withOpacity(0.5)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: colorScheme.primary),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    maxLength: 4,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    obscureText: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter CVV';
                                      }
                                      if (!RegExp(r'^\d{3,4}$').hasMatch(value)) {
                                        return 'CVV must be 3-4 digits';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: _showSuccess
                                  ? Icon(Icons.check_circle, color: colorScheme.primary, size: 32)
                                  : ElevatedButton(
                                      key: const ValueKey('saveBtn'),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          Prefs.setString('last_card_details', jsonEncode({
                                            'number': _cardNumberController.text,
                                            'expiry': _expiryController.text,
                                            'cvv': _cvvController.text,
                                          }));
                                          widget.onCardDetailsSaved(
                                            _cardNumberController.text,
                                            _expiryController.text,
                                            _cvvController.text,
                                          );
                                          setState(() => _showSuccess = true);
                                          await Future.delayed(const Duration(seconds: 1));
                                          setState(() => _showSuccess = false);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Payment information saved successfully!'),
                                              backgroundColor: Theme.of(context).colorScheme.primary,
                                            ),
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
    );
  }

  bool _luhnCheck(String number) {
    int sum = 0;
    bool alternate = false;
    for (int i = number.length - 1; i >= 0; i--) {
      int n = int.parse(number[i]);
      if (alternate) {
        n *= 2;
        if (n > 9) n -= 9;
      }
      sum += n;
      alternate = !alternate;
    }
    return sum % 10 == 0;
  }

  bool _isFutureDate(String value) {
    final parts = value.split('/');
    if (parts.length != 2) return false;
    final month = int.tryParse(parts[0]);
    final year = int.tryParse(parts[1]);
    if (month == null || year == null) return false;
    final now = DateTime.now();
    final fourDigitYear = 2000 + year;
    final expiry = DateTime(fourDigitYear, month + 1, 0);
    return expiry.isAfter(now);
  }
}

class _CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();
    for (int i = 0; i < digitsOnly.length; i++) {
      buffer.write(digitsOnly[i]);
      if ((i + 1) % 4 == 0 && i + 1 != digitsOnly.length) {
        buffer.write(' ');
      }
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

class _ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    if (text.length > 4) text = text.substring(0, 4);
    String formatted = text;
    if (text.length >= 3) {
      formatted = text.substring(0, 2) + '/' + text.substring(2);
    }
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class Prefs {
  static final Map<String, String> _prefs = {};

  static String getString(String key) {
    return _prefs[key] ?? '';
  }

  static void setString(String key, String value) {
    _prefs[key] = value;
  }
}
