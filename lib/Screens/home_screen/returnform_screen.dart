import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nanoid/nanoid.dart';
import '../../Model/return_form_model.dart';
import '../../Model/returnform_details_model.dart';
import '../../ViewModel/return_form_view_model.dart';
import '../../ViewModel/return_form_details_view_model.dart';

class ReturnformScreen extends StatefulWidget {
  const ReturnformScreen({super.key});

  @override
  _ReturnformScreenState createState() => _ReturnformScreenState();
}

class _ReturnformScreenState extends State<ReturnformScreen> {
  final returnformViewModel = Get.put(ReturnFormViewModel());
  final returnformdetailsViewModel = Get.put(ReturnFormDetailsViewModel());
  int? returnId;
  final selectShopController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<String> _shops = ["Shop 1", "Shop 2", "Shop 3", "Shop 4", "Shop 5", "Shop 6", "Shop 7", "Shop 8", "Shop 9", "Shop 10", "Shop 11", "Shop 12", "Shop 13", "Shop 14", "Shop 15",];

  String? _selectedShop;

  final List<TextEditingController> itemControllers = [];
  final List<TextEditingController> qtyControllers = [];
  final List<TextEditingController> reasonControllers = [];

  @override
  void dispose() {
    // Dispose of all controllers
    selectShopController.dispose();
    for (var controller in itemControllers) {
      controller.dispose();
    }
    for (var controller in qtyControllers) {
      controller.dispose();
    }
    for (var controller in reasonControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required double width,
    required double height,
    double fontSize = 16.0,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        controller: controller,
        style: TextStyle(fontSize: fontSize),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          border: const UnderlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold( backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Return Form',
            style: TextStyle(color: Colors.white, fontSize: 29),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                // Dropdown to select shop
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Select Shop",
                    border: UnderlineInputBorder(),
                  ),
                  value: _selectedShop,
                  items: _shops.map((shop) {
                    return DropdownMenuItem(
                      value: shop,
                      child: Text(shop),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedShop = value;
                    });
                  },
                ),
                const SizedBox(height: 30),
                // Dynamic rows
                Column(
                  children: List.generate(itemControllers.length, (index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTextField(
                          label: "Item",
                          controller: itemControllers[index],
                          width: size.width * 0.2,
                          height: 50,
                        ),
                        _buildTextField(
                          label: "Qty",
                          controller: qtyControllers[index],
                          width: size.width * 0.2,
                          height: 50,
                        ),
                        _buildTextField(
                          label: "Reason",
                          controller: reasonControllers[index],
                          width: size.width * 0.3,
                          height: 50,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              itemControllers[index].dispose();
                              qtyControllers[index].dispose();
                              reasonControllers[index].dispose();

                              itemControllers.removeAt(index);
                              qtyControllers.removeAt(index);
                              reasonControllers.removeAt(index);
                            });
                          },
                        ),
                      ],
                    );
                  }),
                ),
                const SizedBox(height: 20),
                // Add new row button
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      itemControllers.add(TextEditingController());
                      qtyControllers.add(TextEditingController());
                      reasonControllers.add(TextEditingController());
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 45,
                      vertical: 15,
                    ),
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("Add Row",
                    style: TextStyle(fontSize: 20, color: Colors.white),),
                ),
                const SizedBox(height: 40),
                // Submit button
                ElevatedButton(
                  onPressed: () async {
                    // Your existing code for submission
                    var id = await customAlphabet('1234567890', 5);
                    returnId = int.parse(id);

                    // Collect data from all rows
                    List<Map<String, String>> rowData = List.generate(
                      itemControllers.length,
                          (index) => {
                            'item':   itemControllers[index].text,
                            'qty':    qtyControllers[index].text,
                            'reason': reasonControllers[index].text,
                      },
                    );
                    // Save data
                    print('Return Id:$returnId');
                    returnformViewModel.addReturnForm(
                      ReturnFormModel(
                        returnMasterId: returnId,
                          selectShop: _selectedShop
                      ),
                    );

                    for (var data in rowData) {

                      returnformdetailsViewModel.addReturnFormDetails(
                        ReturnFormDetailsModel(
                          item: data['item']!,
                          qty: data['qty']!,
                          reason: data['reason']!,
                            returnMasterId: returnId,

                        ),
                      );
                    }

                    Get.snackbar(
                      "Success",
                      "Form Submitted!",
                      snackPosition: SnackPosition.TOP,
                    );

                    // Clear data
                    setState(() {
                      // _selectedShop = null;
                      // itemControllers.clear();
                      // qtyControllers.clear();
                      // reasonControllers.clear();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
