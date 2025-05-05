import 'package:flutter/material.dart';

class ScentOption extends StatefulWidget {
  final List<String> scentOption;
  final void Function(String selectedScent)? onScentSelected;
  final bool showLabel;

  const ScentOption({
    super.key,
    required this.scentOption,
    this.onScentSelected,
    this.showLabel = false,
  });

  @override
  State<ScentOption> createState() => _ScentOptionState();
}

class _ScentOptionState extends State<ScentOption> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    if (widget.scentOption.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLabel)
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'Scent',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(widget.scentOption.length, (index) {
            final scentName = widget.scentOption[index];
            final isSelected = index == selectedIndex;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                widget.onScentSelected?.call(scentName);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: isSelected ? Colors.blue : Colors.grey),
                  borderRadius: BorderRadius.circular(6),
                  color: isSelected ? Colors.blue.withOpacity(0.1) : null,
                ),
                child: Text(
                  scentName,
                  style: const TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
