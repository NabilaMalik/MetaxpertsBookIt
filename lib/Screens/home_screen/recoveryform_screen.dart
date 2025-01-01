import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Model/recovery_form_model.dart';
import '../../ViewModel/recovery_form_view_model.dart';

class RecoveryformScreen extends StatefulWidget {
  const RecoveryformScreen({super.key});
  @override
  _RecoveryformScreenState createState() => _RecoveryformScreenState();
}

class _RecoveryformScreenState extends State<RecoveryformScreen> {
  final recoveryformViewModel = Get.put(RecoveryFormViewModel());
  final currentBalanceController = TextEditingController();
  final cashRecoveryController = TextEditingController();
  final newBalanceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Dropdown items and selected value
  final List<String> _shops = [
    "Shop 1",
    "Shop 2",
    "Shop 3",
    "Shop 4",
    "Shop 5",
    "Shop 6",
    "Shop 7",
    "Shop 8",
    "Shop 9",
    "Shop 10"
  ];
  String? _selectedShopName;

  // Dummy payment history data
  final List<Map<String, String>> _paymentHistory = [
    {"Date": "2024-12-01", "Amount": "\$100", "Status": "Completed"},
    {"Date": "2024-12-05", "Amount": "\$50", "Status": "Pending"},
    {"Date": "2024-12-10", "Amount": "\$200", "Status": "Completed"},
  ];
  @override
  void dispose() {
    currentBalanceController.dispose();
    cashRecoveryController.dispose();
    newBalanceController.dispose();
    super.dispose();
  }

  // Method to build text fields
  Widget _buildTextField({
    required String label,
    required TextInputType keyboardType,
    TextEditingController? controller,
    double width = 200,
    double height = 50,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        onTap: onTap,
        style: const TextStyle(fontSize: 18),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
          border: const UnderlineInputBorder(),
        ),
      ),
    );
  }

  // Method to handle form submission
  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      if (_selectedShopName == null) {
        Get.snackbar("Error", "Please select a shop before submitting.",
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
        return;
      }
      // Proceed to submit the form
      recoveryformViewModel.addRecoveryForm(
        RecoveryFormModel(
          shopName: _selectedShopName!,
          currentBalance: currentBalanceController.text,
          cashRecovery: cashRecoveryController.text,
          newBalance: newBalanceController.text,
        ),
      );
      // Debug prints for validation
      // print("Selected Shop Name: $_selectedShopName");
      // print("Cash Recovery: ${cashRecoveryController.text}");
      // print("New Balance: ${newBalanceController.text}");

      Get.snackbar("Success", "Recovery form submitted successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue.shade900);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Recovery Form',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Container(
          color: Colors.white,
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  // Dropdown for selecting shop
                  SizedBox(
                    width: size.width * 0.8,
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: "Shop Name",
                        labelStyle: TextStyle(fontSize: 18),
                        border: UnderlineInputBorder(),
                      ),
                      value: _selectedShopName,
                      items: _shops.map((shop) {
                        return DropdownMenuItem(
                          value: shop,
                          child: Text(shop),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedShopName = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Current Balance',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      const SizedBox(width: 30),
                      _buildTextField(
                        label: "",
                        keyboardType: TextInputType.text,
                        width: size.width * 0.36,
                        height: 60,
                        controller: currentBalanceController,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "----- Previous Payment History -----",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  DataTable(
                    columns: const [
                      DataColumn(label: Text("Date")),
                      DataColumn(label: Text("Amount")),
                      DataColumn(label: Text("Status")),
                    ],
                    rows: _paymentHistory.map((payment) {
                      return DataRow(cells: [
                        DataCell(Text(payment["Date"] ?? "")),
                        DataCell(Text(payment["Amount"] ?? "")),
                        DataCell(Text(payment["Status"] ?? "")),
                      ]);
                    }).toList(),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Text(
                        "Cash Recovery",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      const SizedBox(width: 20),
                      _buildTextField(
                        label: "",
                        keyboardType: TextInputType.text,
                        width: size.width * 0.5,
                        height: 40,
                        controller: cashRecoveryController,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "New Balance",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      const SizedBox(width: 30),
                      _buildTextField(
                        label: "",
                        keyboardType: TextInputType.text,
                        width: size.width * 0.5,
                        height: 60,
                        controller: newBalanceController,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: _handleSubmit,
                        child: const Text("Submit"),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          minimumSize: const Size(150, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 28),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
