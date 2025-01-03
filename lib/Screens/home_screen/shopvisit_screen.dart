import 'dart:convert'; // For Base64 encoding
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nanoid/async.dart';
import 'package:order_booking_app/Database/Util.dart';
import 'package:order_booking_app/Model/shop_visit_details_model.dart';
import 'package:order_booking_app/ViewModel/shop_visit_details_view_model.dart';
import '../../Components/products_controller.dart';
import '../../ViewModel/shop_visit_view_model.dart';
import '../../model/shop_visit_model.dart';
import '../../widgets/rounded_button.dart';

class ShopvisitScreen extends StatefulWidget {
  const ShopvisitScreen({super.key});

  @override
  _ShopvisitScreenState createState() => _ShopvisitScreenState();
}
class _ShopvisitScreenState extends State<ShopvisitScreen> {
  final shopvisitViewModel = Get.put(ShopVisitViewModel());
  final brandController = TextEditingController();
  final shopNameController = TextEditingController();
  final shopAddressController = TextEditingController();
  final shopOwnerController = TextEditingController();
  final bookerNameController = TextEditingController();
  bool walkthroughController = false;
  bool planogramController = false;
  bool signageController = false;
  bool productReviewedController = false;
  File? addPhotoController;
  final feedbackController = TextEditingController();
  final checklistLabelsController = TextEditingController();
  int? shopVisitMasterId;
  final shopvisitdetailsViewModel = Get.put(ShopVisitDetailsViewModel());
  final productController = TextEditingController();
  final quantityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? selectedBrand;
  String? selectedShop;
  List<DataRow> filteredRows = [];
  Products products = Get.put(Products());
  List<bool> checklistState = [false, false, false, false];
  List<String> checklistLabels = [
    '1-Performed Store Walkthrough',
    '2-Update Store Planogram',
    '3-Shelf tags and price signage check',
    '4-Expiry date on product reviewed',
  ];

  List<String> brands = ['Brand A', 'Brand B', 'Brand C'];
  List<String> shops = ['Shop X', 'Shop Y', 'Shop Z'];

  File? _savedImage;
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        addPhotoController = File(image.path); // Assign the image to addPhotoController
      });
    }
  }


  final List<Map<String, String>> productData = [
    {"Product": "Product 1", "Quantity": "10"},
    {"Product": "Product 2", "Quantity": "5"},
    {"Product": "Product 3", "Quantity": "5"},
    {"Product": "Product 4", "Quantity": "55"},
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
    brandController.dispose();
    shopNameController.dispose();
    shopAddressController.dispose();
    shopOwnerController.dispose();
    bookerNameController.dispose();
    feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Shop Visit',
            style: TextStyle(color: Colors.white, fontSize: 29),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Container(
          color: Colors.white,
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildDropdown(
                        label: "Brand",
                        icon: Icons.branding_watermark,
                        items: brands,
                        selectedValue: selectedBrand,
                        onChanged: (value) {
                          setState(() {
                            selectedBrand = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a brand';
                          }
                          return null;
                        },
                      ),
                      _buildDropdown(
                        label: "Shop Name",
                        icon: Icons.store,
                        items: shops,
                        selectedValue: selectedShop,
                        onChanged: (value) {
                          setState(() {
                            selectedShop = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a shop';
                          }
                          return null;
                        },
                      ),
                      _buildTextField(
                        controller: shopAddressController,
                        label: "Shop Address",
                        icon: Icons.location_on,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the shop address';
                          }
                          return null;
                        },
                      ),
                      _buildTextField(
                        controller: shopOwnerController,
                        label: "Shop Owner",
                        icon: Icons.person_outlined,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the owner name';
                          }
                          return null;
                        },
                      ),
                      _buildTextField(
                        controller: bookerNameController,
                        label: "Booker Name",
                        icon: Icons.person,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the booker name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 35),
                      Padding(
                        padding: const EdgeInsets.only(right: 240.0),
                        child: Text(
                          "1-Stock Check",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SizedBox(
                            height: 400,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(color: Colors.black, width: 1.0),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        onChanged: (query) {
                                          // Add filtering logic here
                                        },
                                        decoration: const InputDecoration(
                                          labelText: 'Search',
                                          hintText: 'Type to search...',
                                          prefixIcon: Icon(Icons.search),
                                        ),
                                      ),
                                    ),
                                    ValueListenableBuilder<List<DataRow>>(
                                      valueListenable: products.rowsNotifier,
                                      builder: (context, rows, child) {
                                        return DataTable(
                                          columns: const [
                                            DataColumn(label: Text('Product')),
                                            DataColumn(label: Text('Quantity')),
                                          ],
                                          rows: filteredRows.isNotEmpty ? filteredRows : rows,
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            checklistLabels.length,
                                (index) => Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    checklistLabels[index],
                                    style: const TextStyle(fontSize: 19),
                                  ),
                                ),
                                Checkbox(
                                  value: checklistState[index],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      checklistState[index] = value!;
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.warning, color: Colors.red, size: 30),
                                  onPressed: () {
                                    // Handle warning logic
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: _pickImage,
                        icon: const Icon(Icons.photo, size: 25),
                        label: const Text(
                          'Add Photo',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      if (_savedImage != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              const Text(
                                'Photo Selected!',
                                style: TextStyle(fontSize: 19, color: Colors.green),
                              ),
                              const SizedBox(height: 10),
                              Image.file(
                                _savedImage!,
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                      // Feedback Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Feedback",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: feedbackController,
                              maxLines: 5,
                              style: const TextStyle(fontSize: 18),
                              decoration: InputDecoration(
                                hintText: "Enter your feedback here...",
                                hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Feedback cannot be empty';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
      var id = await customAlphabet('1234567890', 5);
      shopVisitMasterId = int.parse(id);
      if (_formKey.currentState!.validate()) {
                                Uint8List? photoBase64;
                                if (addPhotoController != null) {
                                  final bytes = await addPhotoController!.readAsBytes();
                                  photoBase64 =bytes; // Convert image bytes to Base64
                                }

                                shopvisitViewModel.addShopVisit(ShopVisitModel(
                                    shopVisitMasterId: shopVisitMasterId,
                                    brand: selectedBrand,
                                    shopName: selectedShop,
                                    walkthrough: walkthroughController,
                                    planogram:planogramController,
                                    signage:signageController,
                                    productReviewed:productReviewedController,
                                    shopAddress: shopAddressController.text,
                                    shopOwner: shopOwnerController.text,
                                    bookerName: bookerNameController.text,
                                    addPhoto: photoBase64, // Pass the Base64-encoded photo
                                    feedback: feedbackController.text,
                                  ),
                                );
                                for (var row in filteredRows) {
                                  String product = (row.cells[0].child as Text).data ?? "";
                                  String quantity = (row.cells[1].child as Text).data ?? "";


                                  // Add ReConfirm Order for each product row
                                  await shopvisitdetailsViewModel.addShopVisitDetails(ShopVisitDetailsModel(
                                    product: product,
                                    quantity: quantity,
                                    shopVisitMasterId: shopVisitMasterId,
                                  ));
                                }
                                Get.snackbar('Success', 'Shop Visit added successfully!', snackPosition: SnackPosition.BOTTOM);
                              }
                            },
                            child: const Text("+Order Booking Form"),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue,
                              minimumSize: const Size(230, 60),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 28),
                        ],
                      ),
                      const SizedBox(height: 30),
                      RoundedButton(
                        text: 'No Order',

                        press: () {
                          if (_formKey.currentState!.validate()) {
                            print("No Order Selected");
                          }
                        },
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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

  Widget _buildDropdown({
    required String label,
    required IconData icon,
    required List<String> items,
    required String? selectedValue,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
        items: items
            .map((item) => DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        ))
            .toList(),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
