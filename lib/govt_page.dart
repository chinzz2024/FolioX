import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({super.key});

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  String? selectedGoal; // Stores the selected goal
  final TextEditingController customGoalController =
      TextEditingController(); // Controller for custom goal input
  final TextEditingController targetYearController =
      TextEditingController(); // Controller for target year input

  @override
  void dispose() {
    customGoalController.dispose();
    targetYearController.dispose();
    super.dispose();
  }

  Future<void> saveGoalAndYear() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw 'User not authenticated!';
      }

      final String userId = user.uid;

      // Check if the user already has a document
      DocumentSnapshot docSnapshot =
          await FirebaseFirestore.instance.collection('userGoals').doc(userId).get();

      if (!docSnapshot.exists) {
        // Create a new document with the user's UID
        await FirebaseFirestore.instance.collection('userGoals').doc(userId).set({
          'goal': selectedGoal == 'Others' ? customGoalController.text : selectedGoal,
          'targetYear': targetYearController.text,
          'timestamp': FieldValue.serverTimestamp(),
        });
      } else {
        // Update the existing document with new data
        await FirebaseFirestore.instance.collection('userGoals').doc(userId).update({
          'goal': selectedGoal == 'Others' ? customGoalController.text : selectedGoal,
          'targetYear': targetYearController.text,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data saved successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> incomeFields = [
      'Base Salary',
      'Dearness Allowance',
      'House Rent Allowance (HRA)',
      'Transport Allowance',
      'Others',
    ];

    final List<String> deductionFields = [
      'Provident Fund',
      'Income Tax',
      'Professional Tax',
      'LIC/Other Insurances',
      'Vehicle/Other Loans',
    ];

    final List<String> expenditureFields = [
      'Housing Rent',
      'Utilities',
      'Transportation',
      'Education',
      'Others',
    ];

    final List<String> goalOptions = [
      'Marriage',
      'Retirement plan',
      'Emergency fund',
      'Others',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Government Employee',
          style: TextStyle(color: Colors.white),
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
                'Income',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              // Single column for income fields
              ...incomeFields.map((income) => Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: income,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0), // Spacer between fields
                    ],
                  )),
              const SizedBox(height: 16.0),
              const Text(
                'Deduction',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              // Single column for deduction fields
              ...deductionFields.map((deduction) => Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: deduction,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0), // Spacer between fields
                    ],
                  )),
              const SizedBox(height: 16.0),
              const Text(
                'Expenditure',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              // Single column for expenditure fields
              ...expenditureFields.map((expenditure) => Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: expenditure,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0), // Spacer between fields
                    ],
                  )),
              const SizedBox(height: 16.0),
              const Text(
                'Select Goal',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              // Dropdown for goal selection
              DropdownButtonFormField<String>(
                value: selectedGoal,
                items: goalOptions
                    .map((goal) => DropdownMenuItem<String>(
                          value: goal,
                          child: Text(goal),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGoal = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Goal',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Show input field for custom goal if "Others" is selected
              if (selectedGoal == 'Others')
                TextField(
                  controller: customGoalController,
                  decoration: InputDecoration(
                    labelText: 'Enter your goal',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                  ),
                ),
              const SizedBox(height: 16.0),
              const Text(
                'Target Year',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: targetYearController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter target year',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    saveGoalAndYear();
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
                    'Submit',
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
}
