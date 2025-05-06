import 'package:flutter/material.dart';

class QuantityDropdown extends StatefulWidget {
  final ValueChanged<int>? onQuantityChanged;
  final int initialQuantity;

  const QuantityDropdown({
    super.key,
    this.onQuantityChanged,
    this.initialQuantity = 1,
  });

  @override
  State<QuantityDropdown> createState() => _QuantityDropdownState();
}

class _QuantityDropdownState extends State<QuantityDropdown> {
  late int selectedQuantity;
  final List<int> quantities = List.generate(10, (index) => index + 1);

  @override
  void initState() {
    super.initState();
    selectedQuantity = widget.initialQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: selectedQuantity,
          icon: const Icon(Icons.arrow_drop_down),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          onChanged: (int? newValue) {
            if (newValue != null) {
              setState(() {
                selectedQuantity = newValue;
              });
              widget.onQuantityChanged?.call(newValue);
            }
          },
          items: quantities
              .map((int value) => DropdownMenuItem<int>(
                    value: value,
                    child: Text('Quantity: $value'),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
