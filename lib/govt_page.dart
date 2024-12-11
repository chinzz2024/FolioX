import 'package:flutter/material.dart';

class IncomePage extends StatelessWidget {
  const IncomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // List of field names
    final List<String> incomeFields = [
      'Base Salary',
      'Dearness Allowance',
      'House Rent Allowance (HRA)',
      'Transport Allowance',
    ];

    final List<String> deductionFields = [
      'Provident Fund',
      'Income Tax',
      'Professional Tax',
      'LIC Loans',
      'Vehicle/Other Loans',
    ];

    final List<String> expenditureFields = [
      'Housing Rent',
      'Utilities',
      'Groceries',
      'transportation',
      'Education',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Government Employee',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 12, 6, 37),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Income',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            // Grid layout for input boxes (Income)
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 input boxes per row
                  crossAxisSpacing: 50.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 5.0, // Adjust the height of input boxes
                ),
                itemCount: incomeFields
                    .length, // Total input boxes based on field names
                itemBuilder: (context, index) {
                  return TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: incomeFields[index], // Use names from the list
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0), // Add some space between sections
            const Text(
              'Deduction',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            // Grid layout for input boxes (Deduction)
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 input boxes per row
                  crossAxisSpacing: 50.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 5.0, // Adjust the height of input boxes
                ),
                itemCount: deductionFields
                    .length, // Total input boxes based on field names
                itemBuilder: (context, index) {
                  return TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText:
                          deductionFields[index], // Use names from the list
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 16.0,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0), // Add some space between sections
            const Text(
              'Expenditure',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 50.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 5.0,
                ),
                itemCount: expenditureFields.length,
                itemBuilder: (context, index) {
                  return TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: expenditureFields[index],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
