import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/rounded_button.dart';

class ReconfirmOrderScreen extends StatefulWidget {
  const ReconfirmOrderScreen({super.key});

  @override
  _ReconfirmOrderScreenState createState() => _ReconfirmOrderScreenState();
}

class _ReconfirmOrderScreenState extends State<ReconfirmOrderScreen> {
  final _formKey = GlobalKey<FormState>(); // Add form key for validation

  // A helper method to build TextField widgets with custom borders
  Widget _buildTextField({
    required String label,
    required TextInputType keyboardType,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        keyboardType: keyboardType,
        validator: validator,
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 19), // Hint text style
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0), // Normal border
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0), // Focused border
          ),
        ),
      ),
    );
  }

  // A helper method to build three horizontal TextFormFields with different widths
  Widget _buildHorizontalTextFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // First TextField
          Container(
            width:100, // Narrow width
            child: _buildTextField(
              label: "Description",
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
          ),
          // Second TextField
          Container(
            width: 90, // Medium width
            child: _buildTextField(
              label: "Qty",
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
          ),
          // Third TextField
          Container(
            width: 90, // Wider width
            child: _buildTextField(
              label: "Amount",
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Re-Confirm Order',
            style: TextStyle(color: Colors.white, fontSize: 29),
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
            child: Form( // Wrap fields in a form for validation
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 40),
                  _buildTextField(
                    label: 'Order ID',
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the order ID';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    label: 'Customer Name',
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the customer name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    label: 'Phone Number',
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Order Summary Heading
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Order Summary",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Horizontal Text Fields
                  _buildHorizontalTextFields(),
                  const SizedBox(height: 20),
                  // Add a submit button or other widgets here as needed
                  RoundedButton(
                    text: 'Confirm Order',
                    press: () {
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, proceed to confirm the order
                        print("Order confirmed");
                      }
                    },
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
