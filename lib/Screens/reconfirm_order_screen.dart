import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ReconfirmOrderScreen extends StatefulWidget {
  const ReconfirmOrderScreen({super.key});
  @override
  _ReconfirmOrderScreenState createState() => _ReconfirmOrderScreenState();
}
class _ReconfirmOrderScreenState extends State<ReconfirmOrderScreen> {
  // A helper method to build TextField widgets with custom decoration
  Widget _buildTextField({
    required String label,
    required TextInputType keyboardType,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: TextFormField(
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 19),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
        ),
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
            child: Column(
              children: <Widget>[
                const SizedBox(height: 40),
                _buildTextField(
                  label: 'Order ID',
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  label: 'Customer Name',
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  label: 'Phone Number',
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Order Summary",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: SizedBox(
                        width: 180, // Set the desired width here
                        height: 40, // Set the desired height here
                        child: _buildTextField(
                          label: "Description",
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: SizedBox(
                        width: 95, // Set the desired width here
                        height: 40, // Set the desired height here
                        child: _buildTextField(
                          label: "Qty",
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: SizedBox(
                        width: 95, // Set the desired width here
                        height: 40, // Set the desired height here
                        child: _buildTextField(
                          label: "Amount",
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: SizedBox(
                        width: 180, // Set the desired width here
                        height: 40, // Set the desired height here
                        child: _buildTextField(
                          label: " ",
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: SizedBox(
                        width: 95, // Set the desired width here
                        height: 40, // Set the desired height here
                        child: _buildTextField(
                          label: " ",
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: SizedBox(
                        width: 95, // Set the desired width here
                        height: 40, // Set the desired height here
                        child: _buildTextField(
                          label: " ",
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text(
                        " Total",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: SizedBox(
                        width: 200,
                        height: 35,
                        child: _buildTextField(
                          label: "",
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        " Credit limit",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: SizedBox(
                        width: 200,
                        height: 35,
                        child: _buildTextField(
                          label: "",
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        " Required",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: SizedBox(
                        width: 200,
                        height: 35,
                        child: _buildTextField(
                          label: "",
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.snackbar("Action", "Button Pressed!",
                          snackPosition: SnackPosition.BOTTOM);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Border radius
                      ),
                    ),
                    child: const Text(
                      'Re Confirm',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Right-Aligned "Next" Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.snackbar("Action", "Right Button Pressed!",
                            snackPosition: SnackPosition.BOTTOM);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 45, vertical: 15),
                        backgroundColor: Colors.blue[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // Border radius
                        ),
                      ),
                      child: const Text(
                        'PDF',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Right-Aligned "Close" Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.snackbar("Action", "Close Button Pressed!",
                            snackPosition: SnackPosition.BOTTOM);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        backgroundColor: Colors.red[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // Border radius
                        ),
                      ),
                      child: const Text(
                        'Close',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),

                    ),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
