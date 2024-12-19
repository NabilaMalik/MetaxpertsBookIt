import 'package:flutter/material.dart';
import '../widgets/rounded_button.dart';
class AddshopScreen extends StatefulWidget {
  const AddshopScreen({super.key});

  @override
  _AddshopScreenState createState() => _AddshopScreenState();
}

class _AddshopScreenState extends State<AddshopScreen> {
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

  bool _isSwitchOn = false; // State for the switch

  @override
  void dispose() {
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
            style: TextStyle(color: Colors.white, fontSize: 29), // Set text color here
          ),
          centerTitle: true, // Centers the title
          backgroundColor: Colors.blue, // Set background color to white
        ),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: 780,
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the shop Address';
                                  }
                                  return null;
                                },
                              ),
                              _buildTextField(
                                label: "Owner Name",
                                icon: Icons.person_outlined,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the name';
                                  }
                                  return null;
                                },
                              ),
                              _buildTextField(
                                label: "Owner CNIC",
                                icon: Icons.person_outlined,
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
                                keyboardType: TextInputType.phone,
                              ),

                              _buildTextField(
                                label: "Phone Number",
                                icon: Icons.phone,
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
                                      print("Switch is now: ${_isSwitchOn ? "ON" : "OFF"}");
                                    },
                                    activeColor: Colors.blue,
                                  ),
                                  const Text(
                                    "GPS Enabled",
                                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 29),
                              RoundedButton(
                                text: 'Add',

                                press: () {
                                  if (_formKey.currentState!.validate()) {
                                    print("Registration successful");
                                    print("Notifications: ${_isSwitchOn ? "Enabled" : "Disabled"}");
                                  }
                                },
                              ),

                              const SizedBox(height: 110),
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
