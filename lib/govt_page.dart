import 'package:flutter/material.dart';

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
              // Grid layout for input boxes (Income)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 50.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 5.0,
                ),
                itemCount: incomeFields.length,
                itemBuilder: (context, index) {
                  return TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: incomeFields[index],
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
              const SizedBox(height: 16.0),
              const Text(
                'Deduction',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              // Grid layout for input boxes (Deduction)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 50.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 5.0,
                ),
                itemCount: deductionFields.length,
                itemBuilder: (context, index) {
                  return TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: deductionFields[index],
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
              const SizedBox(height: 16.0),
              const Text(
                'Expenditure',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              // Grid layout for input boxes (Expenditure)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
                    String goal = selectedGoal == 'Others'
                        ? customGoalController.text
                        : selectedGoal ?? '';
                    String targetYear = targetYearController.text;
                    print('Selected Goal: $goal');
                    print('Target Year: $targetYear');
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
