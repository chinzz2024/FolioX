import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_project/option.dart';
import 'calculation_page.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({super.key});

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  final TextEditingController baseSalaryController = TextEditingController();
  final TextEditingController dearnessAllowanceController =
      TextEditingController();
  final TextEditingController houseRentAllowanceController =
      TextEditingController();
  final TextEditingController transportAllowanceController =
      TextEditingController();
  final TextEditingController otherIncomeController = TextEditingController();

  final TextEditingController providentFundController = TextEditingController();
  final TextEditingController incomeTaxController = TextEditingController();
  final TextEditingController professionalTaxController =
      TextEditingController();
  final TextEditingController licController = TextEditingController();
  final TextEditingController vehicleLoanController = TextEditingController();

  final TextEditingController housingRentController = TextEditingController();
  final TextEditingController utilitiesController = TextEditingController();
  final TextEditingController transportationController =
      TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController otherExpensesController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers
    baseSalaryController.dispose();
    dearnessAllowanceController.dispose();
    houseRentAllowanceController.dispose();
    transportAllowanceController.dispose();
    otherIncomeController.dispose();

    providentFundController.dispose();
    incomeTaxController.dispose();
    professionalTaxController.dispose();
    licController.dispose();
    vehicleLoanController.dispose();

    housingRentController.dispose();
    utilitiesController.dispose();
    transportationController.dispose();
    educationController.dispose();
    otherExpensesController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Government Employee',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EmploymentOptionPage()),
           );
          },
        ),
        backgroundColor: const Color.fromARGB(255, 12, 6, 37),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Income Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildTextField('Base Salary', baseSalaryController),
              _buildTextField('Dearness Allowance', dearnessAllowanceController),
              _buildTextField(
                  'House Rent Allowance (HRA)', houseRentAllowanceController),
              _buildTextField(
                  'Transport Allowance', transportAllowanceController),
              _buildTextField('Others (Income)', otherIncomeController),
              const SizedBox(height: 16.0),
              const Text(
                'Deduction Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildTextField('Provident Fund', providentFundController),
              _buildTextField('Income Tax', incomeTaxController),
              _buildTextField('Professional Tax', professionalTaxController),
              _buildTextField('LIC/Other Insurances', licController),
              _buildTextField('Vehicle/Other Loans', vehicleLoanController),
              const SizedBox(height: 16.0),
              const Text(
                'Expenditure Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildTextField('Housing Rent', housingRentController),
              _buildTextField('Utilities', utilitiesController),
              _buildTextField('Transportation', transportationController),
              _buildTextField('Education', educationController),
              _buildTextField('Others (Expenses)', otherExpensesController),
              const SizedBox(height: 24.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CalculationPage(
                          basicSalary: double.parse(
                              baseSalaryController.text.isEmpty
                                  ? '0'
                                  : baseSalaryController.text),
                          dearnessAllowance: double.parse(
                              dearnessAllowanceController.text.isEmpty
                                  ? '0'
                                  : dearnessAllowanceController.text),
                          houseRentAllowance: double.parse(
                              houseRentAllowanceController.text.isEmpty
                                  ? '0'
                                  : houseRentAllowanceController.text),
                          transportAllowance: double.parse(
                              transportAllowanceController.text.isEmpty
                                  ? '0'
                                  : transportAllowanceController.text),
                          otherIncome: double.parse(otherIncomeController.text.isEmpty
                              ? '0'
                              : otherIncomeController.text),
                          providentFund: double.parse(
                              providentFundController.text.isEmpty
                                  ? '0'
                                  : providentFundController.text),
                          incomeTax: double.parse(
                              incomeTaxController.text.isEmpty
                                  ? '0'
                                  : incomeTaxController.text),
                          professionalTax: double.parse(
                              professionalTaxController.text.isEmpty
                                  ? '0'
                                  : professionalTaxController.text),
                          lic: double.parse(
                              licController.text.isEmpty ? '0' : licController.text),
                          vehicleLoan: double.parse(vehicleLoanController.text.isEmpty
                              ? '0'
                              : vehicleLoanController.text),
                          housingRent: double.parse(
                              housingRentController.text.isEmpty
                                  ? '0'
                                  : housingRentController.text),
                          utilities: double.parse(
                              utilitiesController.text.isEmpty
                                  ? '0'
                                  : utilitiesController.text),
                          transportation: double.parse(
                              transportationController.text.isEmpty
                                  ? '0'
                                  : transportationController.text),
                          education: double.parse(
                              educationController.text.isEmpty
                                  ? '0'
                                  : educationController.text),
                          otherExpenses: double.parse(otherExpensesController
                              .text.isEmpty
                              ? '0'
                              : otherExpensesController.text),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 12, 6, 37),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Calculate Savings',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
