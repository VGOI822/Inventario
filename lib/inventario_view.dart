import 'package:flutter/material.dart';

class InventarioView extends StatefulWidget {
  const InventarioView({super.key});

  @override
  State<InventarioView> createState() => _InventarioViewState();
}

class _InventarioViewState extends State<InventarioView> {
  int? selectedMonth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Inventario 2"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(20),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: AlignmentDirectional.bottomStart,
              isExpanded: true,
              borderRadius: BorderRadius.circular(10),
              value: selectedMonth,
              onChanged: _handleDropdownChange,
              items: _buildDropdownItems(),
            ),
          ),
        ),
      ),
    );
  }

  void _handleDropdownChange(int? month) {
    setState(() {
      selectedMonth = month;
    });
  }
  List<DropdownMenuItem<int>> _buildDropdownItems() {
    return List.generate(
      12,
      (index) => DropdownMenuItem<int>(
        value: index + 1,
        child: Text("${index + 1}"),
      ),
    );
  }
}