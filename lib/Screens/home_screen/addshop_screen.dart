import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../viewmodel/add_shop_view_model.dart';
import 'package:order_booking_app/model/add_shop_model.dart'; // Consistent import
import '../../widgets/rounded_button.dart';

class AddshopScreen extends StatefulWidget {
  const AddshopScreen({super.key});

  @override
  _AddshopScreenState createState() => _AddshopScreenState();
}

class _AddshopScreenState extends State<AddshopScreen> {
  final addShopViewModel = Get.put(AddShopViewModel());
  final shopNameController = TextEditingController();
  final cityController = TextEditingController();
  final shopAddressController = TextEditingController();
  final ownerNameController = TextEditingController();
  final ownerCNICController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final alterPhoneNumberController = TextEditingController();
  int? addShopId;
  final _formKey = GlobalKey<FormState>();
  String? selectedCity;
  List<String> cities = [
    'Karachi',
    'Lahore',
    'Islamabad',
    'Rawalpindi',
    'Faisalabad',
    'Peshawar',
    'Quetta',
    'Multan',
    'Gujranwala',
    'Sialkot',
    'Hyderabad',
    'Sukkur',
    'Sargodha',
    'Bahawalpur',
    'Abbottabad',
    'Mardan',
    'Sheikhupura',
    'Gujrat',
    'Jhelum',
    'Kasur',
    'Okara',
    'Sahiwal',
    'Rahim Yar Khan',
    'Dera Ghazi Khan',
    'Chiniot',
    'Nawabshah',
    'Mirpur Khas',
    'Khairpur',
    'Mansehra',
    'Swat',
    'Muzaffarabad',
    'Kotli',
    'Larkana',
    'Jacobabad',
    'Shikarpur',
    'Hafizabad',
    'Toba Tek Singh',
    'Mianwali',
    'Bannu',
    'Dera Ismail Khan',
    'Chaman',
    'Gwadar',
    'Zhob',
    'Lakhdar',
    'Ghotki',
    'Snowshed',
    'Haripur',
    'Charade'
  ];

  bool _isSwitchOn = false;

  @override
  void dispose() {
    shopNameController.dispose();
    cityController.dispose();
    shopAddressController.dispose();
    ownerNameController.dispose();
    ownerCNICController.dispose();
    phoneNumberController.dispose();
    alterPhoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add Shop',
            style: TextStyle(color: Colors.white, fontSize: 29),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.blue,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              _buildTextField(
                                label: "Shop Name",
                                icon: Icons.home_work_outlined,
                                controller: shopNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the shop name';
                                  }
                                  return null;
                                },
                              ),
                              _buildCityDropdown(
                                label: "City",
                                icon: Icons.location_city,
                                items: cities,
                                selectedValue: selectedCity,
                                onChanged: (value) {
                                  setState(() {
                                    selectedCity = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a city';
                                  }
                                  return null;
                                },
                              ),
                              _buildTextField(
                                label: "Shop Address",
                                icon: Icons.location_on,
                                controller: shopAddressController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the shop address';
                                  }
                                  return null;
                                },
                              ),
                              _buildTextField(
                                label: "Owner Name",
                                icon: Icons.person_outlined,
                                controller: ownerNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the owner\'s name';
                                  }
                                  return null;
                                },
                              ),
                              _buildTextField(
                                label: "Owner CNIC",
                                icon: Icons.person_outlined,
                                controller: ownerCNICController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the CNIC';
                                  }
                                  const cnicPattern = r'^\d{5}-\d{7}-\d{1}$';
                                  final regExp = RegExp(cnicPattern);
                                  if (!regExp.hasMatch(value)) {
                                    return 'Please enter a valid CNIC (e.g., 12345-1234567-1)';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
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
                                label: "Alternative Phone Number",
                                icon: Icons.phone,
                                controller: alterPhoneNumberController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the phone number';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.phone,
                              ),
                              const SizedBox(height: 40),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Switch(
                                    value: _isSwitchOn,
                                    onChanged: (value) {
                                      setState(() {
                                        _isSwitchOn = value;
                                      });
                                    },
                                    activeColor: Colors.blue,
                                  ),
                                  const Text(
                                    "  GPS Enabled",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 29),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        addShopViewModel.addAddShop(AddShopModel(
                                          id: null,
                                          shopName: shopNameController.text,
                                          city: selectedCity,
                                          shopAddress: shopAddressController.text,
                                          ownerName: ownerNameController.text,
                                          ownerCNIC: ownerCNICController.text,
                                          phoneNumber: phoneNumberController.text,
                                          alterPhoneNumber: alterPhoneNumberController.text,
                                        ));
                                        shopNameController.clear();
                                        cityController.clear();
                                        shopAddressController.clear();
                                        ownerNameController.clear();
                                        ownerCNICController.clear();
                                        phoneNumberController.clear();
                                        alterPhoneNumberController.clear();
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
                                itemCount: addShopViewModel.allAddShop.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        addShopId = addShopViewModel.allAddShop[index].id;
                                        shopNameController.text = addShopViewModel.allAddShop[index].shopName!;
                                        cityController.text = addShopViewModel.allAddShop[index].city!;
                                        shopAddressController.text = addShopViewModel.allAddShop[index].shopAddress!;
                                        ownerNameController.text = addShopViewModel.allAddShop[index].ownerName!;
                                        ownerCNICController.text = addShopViewModel.allAddShop[index].ownerCNIC!;
                                        phoneNumberController.text = addShopViewModel.allAddShop[index].phoneNumber!;
                                        alterPhoneNumberController.text = addShopViewModel.allAddShop[index].alterPhoneNumber!;
                                      });
                                    },
                                    child: Card(
                                      child: ListTile(
                                        title: Text(
                                            '${addShopViewModel.allAddShop[index].shopName} - ${addShopViewModel.allAddShop[index].city} - ${addShopViewModel.allAddShop[index].shopAddress} - ${addShopViewModel.allAddShop[index].ownerName} - ${addShopViewModel.allAddShop[index].ownerCNIC} - ${addShopViewModel.allAddShop[index].phoneNumber} - ${addShopViewModel.allAddShop[index].alterPhoneNumber}'),
                                        trailing: IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            addShopViewModel.deleteAddShop(addShopViewModel.allAddShop[index].id!);
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
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
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
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

  Widget _buildCityDropdown({
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
            .map((city) => DropdownMenuItem<String>(
          value: city,
          child: Text(city),
        ))
            .toList(),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
