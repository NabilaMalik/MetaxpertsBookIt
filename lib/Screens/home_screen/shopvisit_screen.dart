import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
  final photoPathController = TextEditingController();
  final feedbackController = TextEditingController();

  int? shopvisitId;

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
  // Function to filter data based on query
  void filterData(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredRows = [];
      });
    } else {
      List<DataRow> tempList = [];
      String lowerCaseQuery = query.toLowerCase();
      for (DataRow row in products.rows) {
        for (DataCell cell in row.cells) {
          if (cell.child is Text && (cell.child as Text).data!.toLowerCase().contains(lowerCaseQuery)) {
            tempList.add(row);
            break;
          }
        }
      }
      setState(() {
        filteredRows = tempList;
      });
    }
  }
  List<String> brands = ['Brand A', 'Brand B', 'Brand C'];
  List<String> shops = ['Shop X', 'Shop Y', 'Shop Z'];

  XFile? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = image;
    });
  }

  @override
  void dispose() {
    brandController.dispose();
    shopNameController.dispose();
    shopAddressController.dispose();
    shopOwnerController.dispose();
    bookerNameController.dispose();
    photoPathController.dispose();
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
          color: Colors.white, // Background color
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
                      Column(
                        children: [

                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SizedBox(
                                    height: 400, // Set the desired height
                                    width: MediaQuery.of(context).size.width * 0.9, // Set the desired width
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                                        side: const BorderSide(
                                          color: Colors.black, // Change the color as needed
                                          width: 1.0, // Change the width as needed
                                        ),
                                      ),
                                      child: SingleChildScrollView( // Add a vertical ScrollView
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: TextField(
                                                //  controller: _searchController,
                                                onChanged: (query) {
                                                  //    filterData(query);
                                                },
                                                decoration: const InputDecoration(
                                                  labelText: 'Search',
                                                  hintText: 'Type to search...',
                                                  prefixIcon: Icon(Icons.search),
                                                ),
                                              ),
                                            ),
                                            // Wrap the DataTable with Obx
                                            RepaintBoundary(
                                              child: ValueListenableBuilder<List<DataRow>>(
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
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )


                        ],
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
                      if (_selectedImage != null)
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'Photo Selected!',
                            style: TextStyle(fontSize: 19, color: Colors.green),
                          ),
                        ),
                      const SizedBox(height: 20),
                      IconButton(
                        icon: const Icon(Icons.warning, color: Colors.red, size: 50),
                        onPressed: () {
                          // Handle warning logic
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Feedback/Special Note',
                        style: TextStyle(fontSize: 19, color: Colors.black),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 340,
                        height: 170,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: TextField(
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Handle form submission
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        ),
                        child: const Text(
                          '+Order Booking Form',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                shopvisitViewModel.addShopVisit(ShopVisitModel(
                                  id: shopvisitId,
                                  brand: selectedBrand,
                                  shopName: selectedShop,
                                  shopAddress: shopAddressController.text,
                                  shopOwner: shopOwnerController.text,
                                  bookerName: bookerNameController.text,
                                  photoPath: photoPathController.text,
                                  feedback: feedbackController.text,
                                ));
                                await shopvisitViewModel.fetchAllShopVisit();
                                brandController.clear();
                                shopNameController.clear();
                                shopAddressController.clear();
                                shopOwnerController.clear();
                                bookerNameController.clear();
                                photoPathController.clear();
                                feedbackController.clear();
                              }
                            },
                            child: const Text("Save"),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue, // Button color
                              minimumSize: Size(150, 50), // Set width and height
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12), // Optional rounded corners
                              ),
                              textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 28),
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: shopvisitViewModel.allShopVisit.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                shopvisitId = shopvisitViewModel.allShopVisit[index].id;
                                brandController.text = shopvisitViewModel.allShopVisit[index].brand!;
                                shopNameController.text = shopvisitViewModel.allShopVisit[index].shopName!;
                                shopAddressController.text = shopvisitViewModel.allShopVisit[index].shopAddress!;
                                shopOwnerController.text = shopvisitViewModel.allShopVisit[index].shopOwner!;
                                bookerNameController.text = shopvisitViewModel.allShopVisit[index].bookerName!;
                                photoPathController.text = shopvisitViewModel.allShopVisit[index].photoPath!;
                              });
                            },
                            child: Card(
                              child: ListTile(
                                title: Text(
                                    '${shopvisitViewModel.allShopVisit[index].brand} - ${shopvisitViewModel.allShopVisit[index].shopName} - ${shopvisitViewModel.allShopVisit[index].shopAddress} - ${shopvisitViewModel.allShopVisit[index].shopOwner} - ${shopvisitViewModel.allShopVisit[index].bookerName} - ${shopvisitViewModel.allShopVisit[index].photoPath}'),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    shopvisitViewModel.deleteShopVisit(shopvisitViewModel.allShopVisit[index].id!);
                                  },
                                ),
                              ),
                            ),
                          );
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
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
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