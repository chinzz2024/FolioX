import 'package:flutter/material.dart';
import 'package:my_project/govt_page.dart';

class CalculationPage extends StatefulWidget {
  final double basicSalary;
  final double dearnessAllowance;
  final double houseRentAllowance;
  final double transportAllowance;
  final double otherIncome;

  final double providentFund;
  final double incomeTax;
  final double professionalTax;
  final double lic;
  final double vehicleLoan;
  final double housingRent;
  final double utilities;
  final double transportation;
  final double education;
  final double otherExpenses;

  const CalculationPage({
    super.key,
    required this.basicSalary,
    required this.dearnessAllowance,
    required this.houseRentAllowance,
    required this.transportAllowance,
    required this.otherIncome,
    required this.providentFund,
    required this.incomeTax,
    required this.professionalTax,
    required this.lic,
    required this.vehicleLoan,
    required this.housingRent,
    required this.utilities,
    required this.transportation,
    required this.education,
    required this.otherExpenses,
  });

  @override
  State<CalculationPage> createState() => _CalculationPageState();
}

class _CalculationPageState extends State<CalculationPage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController interestController = TextEditingController();
  double? calculatedAmount;

  @override
  void dispose() {
    amountController.dispose();
    interestController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double savings = (widget.basicSalary +
            widget.dearnessAllowance +
            widget.houseRentAllowance +
            widget.transportAllowance +
            widget.otherIncome) -
        (widget.providentFund +
            widget.incomeTax +
            widget.professionalTax +
            widget.lic +
            widget.vehicleLoan +
            widget.housingRent +
            widget.utilities +
            widget.transportation +
            widget.education +
            widget.otherExpenses);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Savings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const IncomePage()),
            );
          },
        ),
        backgroundColor: const Color.fromARGB(255, 12, 6, 37),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Display Savings at the Top-Center
              Text(
                'Your Calculated Savings:',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                '₹${savings.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 40),
              // Greeting
              
              const SizedBox(height: 20),
              // Input Field for Amount
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'How much do you plan to invest',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Input Field for Interest
              TextField(
                controller: interestController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter Interest Rate (%)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Button to Calculate the Result
              ElevatedButton(
                onPressed: () {
                  final double? amount = double.tryParse(amountController.text);
                  final double? interest = double.tryParse(interestController.text);

                  if (amount != null && interest != null) {
                    setState(() {
                      calculatedAmount = amount + (amount * (interest / 100));
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter valid numbers')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 12, 6, 37),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 16.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Calculate',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              // Display Calculated Amount
              if (calculatedAmount != null)
                Text(
                  'Amount After Interest: ₹${calculatedAmount!.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
