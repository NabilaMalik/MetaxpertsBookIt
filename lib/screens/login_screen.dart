import 'package:flutter/material.dart';
import 'package:order_booking_app/screens/signup_screen.dart';
import '../components/under_part.dart';
import '../constants.dart';
import '../widgets/rounded_button.dart';
import '../widgets/rounded_icon.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>(); // GlobalKey for form validation
  bool isChecked = true; // To manage checkbox state
  bool isPasswordVisible = false; // To manage password visibility

  String? email; // Store email
  String? password; // Store password

  // Simulated backend user database
  final List<String> _registeredUsers = ['test@example.com', 'user@example.com'];

  Future<bool> _checkIfUserExists(String email) async {
    // Simulate backend API call with a delay
    await Future.delayed(const Duration(seconds: 1));
    return _registeredUsers.contains(email);
  }

  void _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Check if the user exists
      bool userExists = await _checkIfUserExists(email!);

      if (!userExists) {
        // Show error if the user doesn't exist
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Account does not exist. Please sign up first.'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        // Perform login logic here
        print('Login successful: Email: $email, Password: $password');
        // Navigate to the main screen or show success message
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                // Blue background
                Container(
                  height: 440,
                  width: double.infinity,
                  color: Colors.blue,
                ),
                const Positioned(
                  top: 210,
                  left: 0,
                  right: 155,
                  child: Text(
                    'Welcome Back',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: "poppins",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Positioned(
                  top: 250,
                  left: 0,
                  right: 152,
                  child: Text(
                    'Signin to Continue',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "poppins",
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 330.0),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Form(
                          key: _formKey, // Attach GlobalKey to Form
                          child: Column(
                            children: [
                              // Email field
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 20),
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.email, color: Colors.blue),
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                    ),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) => email = value,
                                ),
                              ),
                              const SizedBox(height: 32),
                              // Password field
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 19),
                                  obscureText: !isPasswordVisible,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock, color: Colors.blue),
                                    hintText: "Password",
                                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 17),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isPasswordVisible = !isPasswordVisible;
                                        });
                                      },
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    } else if (value.length < 6) {
                                      return 'Password must be at least 6 characters';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) => password = value,
                                ),
                              ),
                              const SizedBox(height: 50),
                              // Remember me checkbox and forgot password
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: isChecked,
                                      activeColor: kPrimaryColor,
                                      onChanged: (bool? newValue) {
                                        setState(() {
                                          isChecked = newValue!;
                                        });
                                      },
                                    ),
                                    const Text(
                                      'Remember Me',
                                      style: TextStyle(fontSize: 19, fontFamily: 'OpenSans'),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        // Forgot password logic here
                                      },
                                      child: const Text(
                                        'Forgot password?',
                                        style: TextStyle(
                                          color: kPrimaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              // Login button
                              RoundedButton(
                                text: 'Sign in',
                                press: _handleSignIn,
                              ),
                              const SizedBox(height: 30),
                              // UnderPart navigation
                              UnderPart(
                                title: "Don't have an account?",
                                navigatorText: "Login here",
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => const SignUpScreen()));
                                },
                              ),
                              const SizedBox(height: 40),
                              const SizedBox(height: 40),
                              iconButton(context),
                              const SizedBox(height: 40),
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
}

iconButton(BuildContext context) {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      RoundedIcon(imageUrl: "assets/images/fb.jpg"),
      SizedBox(width: 35),
      RoundedIcon(imageUrl: "assets/images/2504839.png"),
      SizedBox(width: 35),
      RoundedIcon(imageUrl: "assets/images/Google.jpg"),
    ],
  );
}
