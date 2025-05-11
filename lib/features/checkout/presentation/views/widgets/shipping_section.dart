import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/features/checkout/domain/models/checkout_model.dart';

class ShippingInfoForm extends StatefulWidget {
  final void Function(ShippingInfo info) onSaved;

  const ShippingInfoForm({super.key, required this.onSaved});

  @override
  State<ShippingInfoForm> createState() => _ShippingInfoFormState();
}

class _ShippingInfoFormState extends State<ShippingInfoForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

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

    return Card(
      color: colorScheme.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                style: TextStyle(color: colorScheme.onSurface),
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  labelStyle:
                      // ignore: deprecated_member_use
                      TextStyle(color: colorScheme.onSurface.withOpacity(0.7)),
                  prefixIcon: Icon(Icons.person,
                      // ignore: deprecated_member_use
                      color: colorScheme.onSurface.withOpacity(0.7)),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        // ignore: deprecated_member_use
                        BorderSide(color: colorScheme.outline.withOpacity(0.5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorScheme.primary),
                  ),
                ),
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
                  labelStyle:
                      // ignore: deprecated_member_use
                      TextStyle(color: colorScheme.onSurface.withOpacity(0.7)),
                  prefixIcon: Icon(Icons.home,
                      // ignore: deprecated_member_use
                      color: colorScheme.onSurface.withOpacity(0.7)),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        // ignore: deprecated_member_use
                        BorderSide(color: colorScheme.outline.withOpacity(0.5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorScheme.primary),
                  ),
                ),
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
                        labelStyle: TextStyle(
                            // ignore: deprecated_member_use
                            color: colorScheme.onSurface.withOpacity(0.7)),
                        prefixIcon: Icon(Icons.location_city,
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
                        labelStyle: TextStyle(
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
                  labelStyle:
                      // ignore: deprecated_member_use
                      TextStyle(color: colorScheme.onSurface.withOpacity(0.7)),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        // ignore: deprecated_member_use
                        BorderSide(color: colorScheme.outline.withOpacity(0.5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorScheme.primary),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                style: TextStyle(color: colorScheme.onSurface),
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle:
                      // ignore: deprecated_member_use
                      TextStyle(color: colorScheme.onSurface.withOpacity(0.7)),
                  prefixIcon: Icon(Icons.phone,
                      // ignore: deprecated_member_use
                      color: colorScheme.onSurface.withOpacity(0.7)),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        // ignore: deprecated_member_use
                        BorderSide(color: colorScheme.outline.withOpacity(0.5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorScheme.primary),
                  ),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
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
                  labelStyle:
                      // ignore: deprecated_member_use
                      TextStyle(color: colorScheme.onSurface.withOpacity(0.7)),
                  prefixIcon: Icon(Icons.email,
                      // ignore: deprecated_member_use
                      color: colorScheme.onSurface.withOpacity(0.7)),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        // ignore: deprecated_member_use
                        BorderSide(color: colorScheme.outline.withOpacity(0.5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorScheme.primary),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onSaved(ShippingInfo(
                      name: _nameController.text,
                      address: _addressController.text,
                      city: _cityController.text,
                      state: _stateController.text,
                      zipCode: _zipController.text,
                      phone: _phoneController.text,
                      email: _emailController.text,
                    ));
                  }
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
