import 'package:flutter/material.dart';

import '../utils/validators.dart';
import '../enums/gender_enum.dart';

import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() =>
      _RegistrationScreenState();
}

class _RegistrationScreenState
    extends State<RegistrationScreen> {

  final _formKey = GlobalKey<FormState>();

  final firstNameController =
      TextEditingController();

  final lastNameController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final confirmPasswordController =
      TextEditingController();

  Gender? selectedGender;

  bool isFormValid = false;

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  void checkFormValidity() {

    bool valid =
        _formKey.currentState?.validate() ?? false;

    setState(() {
      isFormValid =
          valid && selectedGender != null;
    });
  }

  InputDecoration inputDecoration(
    String label,
  ) {

    return InputDecoration(

      labelText: label,

      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
      ),
    );
  }

  @override
  void dispose() {

    firstNameController.dispose();

    lastNameController.dispose();

    emailController.dispose();

    passwordController.dispose();

    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Registration",
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(

        padding:
            const EdgeInsets.all(20),

        child: Form(

          key: _formKey,

          onChanged: checkFormValidity,

          child: Column(

            children: [

              TextFormField(

                controller:
                    firstNameController,

                decoration:
                    inputDecoration(
                  "First Name",
                ),

                validator: (value) =>
                    Validators
                        .validateEmpty(
                  value ?? '',
                  "First Name",
                ),
              ),

              const SizedBox(height: 15),

              TextFormField(

                controller:
                    lastNameController,

                decoration:
                    inputDecoration(
                  "Last Name",
                ),

                validator: (value) =>
                    Validators
                        .validateEmpty(
                  value ?? '',
                  "Last Name",
                ),
              ),

              const SizedBox(height: 15),

              TextFormField(

                controller:
                    emailController,

                keyboardType:
                    TextInputType
                        .emailAddress,

                decoration:
                    inputDecoration(
                  "Email",
                ),

                validator: (value) =>
                    Validators
                        .validateEmail(
                  value ?? '',
                ),
              ),

              const SizedBox(height: 15),

              DropdownButtonFormField<Gender>(

                value: selectedGender,

                decoration:
                    inputDecoration(
                  "Gender",
                ),

                items: Gender.values.map(

                  (gender) {

                    return DropdownMenuItem(

                      value: gender,

                      child: Text(
                        gender.name
                            .toUpperCase(),
                      ),
                    );
                  },
                ).toList(),

                onChanged: (value) {

                  setState(() {
                    selectedGender = value;
                  });

                  checkFormValidity();
                },

                validator: (value) {

                  if (value == null) {
                    return "Select Gender";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(

                controller:
                    passwordController,

                obscureText:
                    obscurePassword,

                decoration:
                    inputDecoration(
                  "Password",
                ).copyWith(

                  suffixIcon: IconButton(

                    icon: Icon(

                      obscurePassword
                          ? Icons.visibility
                          : Icons
                              .visibility_off,
                    ),

                    onPressed: () {

                      setState(() {

                        obscurePassword =
                            !obscurePassword;
                      });
                    },
                  ),
                ),

                validator: (value) =>
                    Validators
                        .validatePassword(
                  value ?? '',
                ),
              ),

              const SizedBox(height: 15),

              TextFormField(

                controller:
                    confirmPasswordController,

                obscureText:
                    obscureConfirmPassword,

                decoration:
                    inputDecoration(
                  "Confirm Password",
                ).copyWith(

                  suffixIcon: IconButton(

                    icon: Icon(

                      obscureConfirmPassword
                          ? Icons.visibility
                          : Icons
                              .visibility_off,
                    ),

                    onPressed: () {

                      setState(() {

                        obscureConfirmPassword =
                            !obscureConfirmPassword;
                      });
                    },
                  ),
                ),

                validator: (value) =>
                    Validators
                        .validateConfirmPassword(

                  value ?? '',

                  passwordController.text,
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(

                width: double.infinity,
                height: 55,

                child: ElevatedButton(

                  onPressed: isFormValid

                      ? () {

                          ScaffoldMessenger.of(
                                  context)
                              .showSnackBar(

                            const SnackBar(
                              content: Text(
                                "Registration Successful",
                              ),
                            ),
                          );

                          Navigator.push(

                            context,

                            MaterialPageRoute(

                              builder:
                                  (context) =>
                                      const LoginScreen(),
                            ),
                          );
                        }

                      : null,

                  child: const Text(

                    "Register",

                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}