import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nanoid/async.dart';
import '../../Components/products_controller.dart';
import '../../Model/confirm_order_model.dart';
import '../../ViewModel/confirm_order_view_model.dart';
import '../../ViewModel/re_confirm_order_view_model.dart';
import '../../model/re_confirm_order_model.dart';
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
  final creditLimitController = TextEditingController();
  final requiredDeliveryController = TextEditingController();
  int? orderMasterId;
  final reconfirmorderViewModel = Get.put(ReConfirmOrderViewModel());
  final productController = TextEditingController();
  final quantityController = TextEditingController();
  final inStockController = TextEditingController();
  final rateController = TextEditingController();
  final amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? selectedCreditLimit; // Variable to hold the selected credit limit
  List<DataRow> filteredRows = [];
  Products products = Get.put(Products());

  final List<Map<String, String>> productData = [
    {"Product": "Product 1", "Quantity": "10", "In Stock": "Yes", "Rate": "50", "Amount": "500"},
    {"Product": "Product 2", "Quantity": "5", "In Stock": "No", "Rate": "100", "Amount": "500"},
    {"Product": "Product 3", "Quantity": "5", "In Stock": "No", "Rate": "100", "Amount": "500"},
    {"Product": "Product 4", "Quantity": "55", "In Stock": "No", "Rate": "100", "Amount": "500"},
  ];
  @override
  void initState() {
    super.initState();
    _generateProductsRows();
    filteredRows = productsRows;
  }
  List<DataRow> productsRows = [];
  void _generateProductsRows() {
    productsRows = productData.map((product) {
      return DataRow(cells: [
        DataCell(Text(product["Product"] ?? "")),
        DataCell(Text(product["Quantity"] ?? "")),
        DataCell(Text(product["In Stock"] ?? "")),
        DataCell(Text(product["Rate"] ?? "")),
        DataCell(Text(product["Amount"] ?? "")),
      ]);
    }).toList();
  }
  void _filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredRows = productsRows;
      } else {
        filteredRows = productsRows.where((row) {
          return row.cells.any((cell) {
            final cellValue = (cell.child as Text).data ?? "";
            return cellValue.toLowerCase().contains(query.toLowerCase());
          });
        }).toList();
      }
    });
  }
  @override
  void dispose() {
    shopNameController.dispose();
    ownerNameController.dispose();
    phoneNumberController.dispose();
    brandController.dispose();
    totalController.dispose();
    creditLimitController.dispose();
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
                  items: ["10,000", "20,000", "50,000", "100,000", "200,000", "500,000", "1,000,000", "2,000,000"],
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
                rows: filteredRows,
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
  // Submit Form
  void _submitForm() async {
    var id = await customAlphabet('1234567890', 5);
    orderMasterId = int.parse(id);

    if (_formKey.currentState!.validate()) {
      // Add Confirm Order
      await confirmorderViewModel.addConfirmOrder(ConfirmOrderModel(
        orderMasterId: orderMasterId,
        shopName: shopNameController.text,
        ownerName: ownerNameController.text,
        phoneNumber: phoneNumberController.text,
        brand: brandController.text,
        total: totalController.text,
        creditLimit: selectedCreditLimit,
        requiredDelivery: requiredDeliveryController.text,
      ));
      // Loop through each product row in the filteredRows and add to ReConfirmOrder
      for (var row in filteredRows) {
        String product = (row.cells[0].child as Text).data ?? "";
        String quantity = (row.cells[1].child as Text).data ?? "";
        String inStock = (row.cells[2].child as Text).data ?? "";
        String rate = (row.cells[3].child as Text).data ?? "";
        String amount = (row.cells[4].child as Text).data ?? "";
        // Add ReConfirm Order for each product row
        await reconfirmorderViewModel.addReConfirmOrder(ReConfirmOrderModel(
          product: product,
          quantity: quantity,
          inStock: inStock,
          rate: rate,
          amount: amount,
          orderMasterId: orderMasterId,
        ));
      }
      // Fetch data again after saving
      await confirmorderViewModel.fetchAllConfirmOrder();
      await reconfirmorderViewModel.fetchAllReConfirmOrder();
      // Show Success Message
      Get.snackbar(
        'Success',
        'Order confirmed successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue.shade900,
        colorText: Colors.white,
      );
    }
  }
}
