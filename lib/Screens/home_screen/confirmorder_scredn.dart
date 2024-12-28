import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Components/products_controller.dart';
import '../../Model/confirm_order_model.dart';
import '../../ViewModel/confirm_order_view_model.dart';
import '../../widgets/rounded_button.dart';

class OrderbookingScreen extends StatefulWidget {
  const OrderbookingScreen({super.key});

  @override
  _OrderbookingScreenState createState() => _OrderbookingScreenState();
}

class _OrderbookingScreenState extends State<OrderbookingScreen> {
  final confirmorderViewModel = Get.put(ConfirmOrderViewModel());
  final shopNameController = TextEditingController();
  final ownerNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final brandController = TextEditingController();
  final totalController = TextEditingController();
  final requiredDeliveryController = TextEditingController();
  int? addShopId;
  final _formKey = GlobalKey<FormState>();

  String? selectedCreditLimit; // Variable to hold the selected credit limit
  List<DataRow> filteredRows = [];
  Products products = Get.put(Products());

  @override
  void dispose() {
    shopNameController.dispose();
    ownerNameController.dispose();
    phoneNumberController.dispose();
    brandController.dispose();
    totalController.dispose();
    requiredDeliveryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Confirm Order',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildForm(),
                const SizedBox(height: 20),
                _buildDataTable(),
                const SizedBox(height: 20),
                _buildTextField(
                  label: "Total",
                  icon: Icons.add_business,
                  controller: totalController,
                  validator: (value) => null,
                ),
                const SizedBox(height: 10),
                _buildDropdown(
                  label: "Credit Limit",
                  icon: Icons.credit_score,
                  items: ["10,000", "20,000", "50,000", "100,000"],
                  selectedValue: selectedCreditLimit,
                  onChanged: (value) {
                    setState(() {
                      selectedCreditLimit = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select a credit limit";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                _buildDateField(),
                const SizedBox(height: 30),
                _buildNoOrderButton(),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Form Section
  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextField(
            label: "Shop Name",
            icon: Icons.warehouse,
            controller: shopNameController,
            validator: (value) => value == null || value.isEmpty ? 'Please enter the shop name' : null,
          ),
          _buildTextField(
            label: "Owner Name",
            icon: Icons.person_outlined,
            controller: ownerNameController,
            validator: (value) => value == null || value.isEmpty ? 'Please enter the owner name' : null,
          ),
          _buildTextField(
            label: "Phone Number",
            icon: Icons.phone,
            controller: phoneNumberController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the phone number';
              }
              return null;
            },
            keyboardType: TextInputType.phone,
          ),
          _buildTextField(
            label: "Brand",
            icon: Icons.branding_watermark,
            controller: brandController,
            validator: (value) => value == null || value.isEmpty ? 'Please enter the brand' : null,
          ),
        ],
      ),
    );
  }

  // DataTable Section with Search Bar on Top
  Widget _buildDataTable() {
    return Container(
      width: double.infinity,
      height: 350,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Search Bar on Top
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextField(
              onChanged: _filterProducts,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.blue),
                hintText: 'Search products...',
                hintStyle: const TextStyle(color: Colors.grey),
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
            ),
          ),
          // DataTable
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Product')),
                  DataColumn(label: Text('Quantity')),
                  DataColumn(label: Text('In Stock')),
                  DataColumn(label: Text('Rate')),
                  DataColumn(label: Text('Amount')),
                ],
                rows: filteredRows.isNotEmpty ? filteredRows : products.rows,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // No Order Button
  Widget _buildNoOrderButton() {
    return Center(
      child: RoundedButton(
        text: 'Confirm',
        press: _submitForm,
      ),
    );
  }

  // Generic Text Field
  Widget _buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blue),
          hintText: label,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 19),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
        ),
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }

  // Dropdown Field
  Widget _buildDropdown({
    required String label,
    required IconData icon,
    required List<String> items,
    required String? selectedValue,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blue),
          hintText: label,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 19),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
        ),
        items: items.map((item) => DropdownMenuItem<String>(value: item, child: Text(item))).toList(),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }

  // Date Picker Field
  Widget _buildDateField() {
    return InkWell(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          setState(() {
            requiredDeliveryController.text = pickedDate.toString().split(' ')[0];
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
          controller: requiredDeliveryController,
          enabled: false,
          style: const TextStyle(fontSize: 20),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.calendar_today, color: Colors.blue),
            hintText: "Required Delivery",
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 19),
            disabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2.0),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please select a delivery date";
            }
            return null;
          },
        ),
      ),
    );
  }

  // Filter Products
  void _filterProducts(String query) {
    setState(() {
      filteredRows = products.rows.where((row) {
        return row.cells.any((cell) => cell.value.toString().toLowerCase().contains(query.toLowerCase()));
      }).toList();
    });
  }

  // Submit Form
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      confirmorderViewModel.addConfirmOrder(ConfirmOrderModel(
        id: null,
        shopName: shopNameController.text,
        ownerName: ownerNameController.text,
        phoneNumber: phoneNumberController.text,
        brand: brandController.text,
        total: totalController.text,
        creditLimit: selectedCreditLimit,
        requiredDelivery: requiredDeliveryController.text,
      ));
      shopNameController.clear();
      ownerNameController.clear();
      phoneNumberController.clear();
      brandController.clear();
      totalController.clear();
      requiredDeliveryController.clear();
      setState(() {
        selectedCreditLimit = null;
      });
      Get.snackbar('Success', 'Order confirmed successfully!',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
    }
  }
}

extension on DataCell {
  get value => null;
}