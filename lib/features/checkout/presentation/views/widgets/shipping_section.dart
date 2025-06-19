import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pickpay/core/services/shared_preferences_singletone.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/features/checkout/domain/models/checkout_model.dart';

class ShippingInfoForm extends StatefulWidget {
  final void Function(ShippingInfo info) onSaved;

  const ShippingInfoForm({super.key, required this.onSaved});

  @override
  State<ShippingInfoForm> createState() => _ShippingInfoFormState();
}

class _ShippingInfoFormState extends State<ShippingInfoForm> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  bool _showSuccess = false;

  @override
  void initState() {
    super.initState();
    _loadLastSavedShippingInfo();
  }

  void _loadLastSavedShippingInfo() {
    final user = Prefs.getUser();
    // Prefer most recently saved info from local storage
    final lastInfoString = Prefs.getString('last_shipping_info');
    if (lastInfoString.isNotEmpty) {
      try {
        final Map<String, dynamic> json = Map<String, dynamic>.from(
          lastInfoString.startsWith('{')
              ? (jsonDecode(lastInfoString) as Map<String, dynamic>)
              : <String, dynamic>{}
        );
        final info = ShippingInfo.fromJson(json);
        _nameController.text = info.name;
        _addressController.text = info.address;
        _cityController.text = info.city;
        _stateController.text = info.state;
        _zipController.text = info.zipCode;
        _phoneController.text = info.phone;
        _emailController.text = info.email;
        print('✅ Loaded last saved shipping info from local storage');
        return;
      } catch (e) {
        print('⚠️ Failed to parse last saved shipping info: $e');
      }
    }
    if (user == null) return;
    final orders = Prefs.getUserOrders(user.uId);
    if (orders != null && orders.isNotEmpty) {
      final lastOrder = orders.last;
      final shippingInfo = lastOrder['shippingInfo'];
      if (shippingInfo != null) {
        _nameController.text = shippingInfo['name'] ?? '';
        _addressController.text = shippingInfo['address'] ?? '';
        _cityController.text = shippingInfo['city'] ?? '';
        _stateController.text = shippingInfo['state'] ?? '';
        _zipController.text = shippingInfo['zipCode'] ?? '';
        _phoneController.text = shippingInfo['phone'] ?? '';
        _emailController.text = shippingInfo['email'] ?? '';
        print('✅ Loaded saved shipping info for user: ${user.uId}');
      } else {
        print('ℹ️ No saved shipping info in last order.');
      }
    } else {
      print('⚠️ No saved orders found for user: ${user.uId}');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final FocusScopeNode focusScope = FocusScope.of(context);

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
                  Text('Shipping information saved!',
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
                  children: [
                    TextFormField(
                      controller: _nameController,
                      style: TextStyle(color: colorScheme.onSurface),
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.7)),
                        prefixIcon: Icon(Icons.person, color: colorScheme.onSurface.withOpacity(0.7)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorScheme.primary),
                        ),
                        helperText: 'Enter your full legal name',
                      ),
                      autofillHints: const [AutofillHints.name],
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => focusScope.nextFocus(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _addressController,
                      style: TextStyle(color: colorScheme.onSurface),
                      decoration: InputDecoration(
                        labelText: 'Address',
                        labelStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.7)),
                        prefixIcon: Icon(Icons.home, color: colorScheme.onSurface.withOpacity(0.7)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorScheme.primary),
                        ),
                        helperText: 'Street address, P.O. box, company name, c/o',
                      ),
                      autofillHints: const [AutofillHints.fullStreetAddress],
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => focusScope.nextFocus(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: _cityController,
                            style: TextStyle(color: colorScheme.onSurface),
                            decoration: InputDecoration(
                              labelText: 'City',
                              labelStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.7)),
                              prefixIcon: Icon(Icons.location_city, color: colorScheme.onSurface.withOpacity(0.7)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.5)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: colorScheme.primary),
                              ),
                              helperText: 'City or locality',
                            ),
                            autofillHints: const [AutofillHints.addressCity],
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => focusScope.nextFocus(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your city';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: _stateController,
                            style: TextStyle(color: colorScheme.onSurface),
                            decoration: InputDecoration(
                              labelText: 'State',
                              labelStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.7)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.5)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: colorScheme.primary),
                              ),
                              helperText: 'State, province, or region',
                            ),
                            autofillHints: const [AutofillHints.addressState],
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => focusScope.nextFocus(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _zipController,
                      style: TextStyle(color: colorScheme.onSurface),
                      decoration: InputDecoration(
                        labelText: 'ZIP Code',
                        labelStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.7)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorScheme.primary),
                        ),
                        helperText: 'Postal or ZIP code',
                      ),
                      autofillHints: const [AutofillHints.postalCode],
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => focusScope.nextFocus(),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _phoneController,
                      style: TextStyle(color: colorScheme.onSurface),
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.7)),
                        prefixIcon: Icon(Icons.phone, color: colorScheme.onSurface.withOpacity(0.7)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorScheme.primary),
                        ),
                        helperText: '11 digits, starts with 01',
                      ),
                      autofillHints: const [AutofillHints.telephoneNumber],
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => focusScope.nextFocus(),
                      keyboardType: TextInputType.phone,
                      maxLength: 11,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        final trimmed = value.trim();
                        if (!RegExp(r'^01[0-9]{9} ?$').hasMatch(trimmed)) {
                          return 'Phone must be 11 digits and start with 01';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _emailController,
                      style: TextStyle(color: colorScheme.onSurface),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.7)),
                        prefixIcon: Icon(Icons.email, color: colorScheme.onSurface.withOpacity(0.7)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorScheme.primary),
                        ),
                        helperText: 'Enter a valid email address',
                      ),
                      autofillHints: const [AutofillHints.email],
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => focusScope.unfocus(),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        final trimmed = value.trim();
                        if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,} ?$').hasMatch(trimmed)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        final info = ShippingInfo(
                          name: _nameController.text,
                          address: _addressController.text,
                          city: _cityController.text,
                          state: _stateController.text,
                          zipCode: _zipController.text,
                          phone: _phoneController.text,
                          email: _emailController.text,
                        );
                        Prefs.setString('last_shipping_info', jsonEncode(info.toJson()));
                        widget.onSaved(info);
                        setState(() => _showSuccess = true);
                        await Future.delayed(const Duration(seconds: 1));
                        setState(() => _showSuccess = false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Shipping information saved successfully!'),
                            backgroundColor: Theme.of(context).colorScheme.primary,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      child: Text(
                        'Save Shipping Info',
                        style: TextStyles.semiBold13.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
