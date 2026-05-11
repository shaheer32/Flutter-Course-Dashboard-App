import 'package:flutter/material.dart';

import '../utils/validators.dart';

import '../controllers/auth_controller.dart';

import '../enums/auth_state_enum.dart';

import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  bool obscurePassword = true;

  bool rememberMe = false;

  @override
  void initState() {

    super.initState();

    loadSavedSession();
  }

  Future<void> loadSavedSession() async {

    AuthState authState =
        await AuthController
            .checkLoginState();

    if (authState ==
        AuthState.loggedIn) {

      String savedEmail =
          await AuthController
              .getSavedEmail();

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (context) =>
              DashboardScreen(
            email: savedEmail,
          ),
        ),
      );
    }
  }

  Future<void> loginUser() async {

    if (_formKey.currentState!
        .validate()) {

      bool success =
          await AuthController.login(

        email: emailController.text,

        password:
            passwordController.text,

        rememberMe: rememberMe,
      );

      if (success) {

        ScaffoldMessenger.of(context)
            .showSnackBar(

          const SnackBar(
            content:
                Text("Login Successful"),
          ),
        );

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder: (context) =>
                DashboardScreen(
              email:
                  emailController.text,
            ),
          ),
        );

      } else {

        ScaffoldMessenger.of(context)
            .showSnackBar(

          const SnackBar(
            content: Text(
              "Invalid Credentials",
            ),
          ),
        );
      }
    }
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

    emailController.dispose();

    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text("Login"),

        centerTitle: true,
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(20),

        child: Form(

          key: _formKey,

          child: Column(

            children: [

              const SizedBox(height: 20),

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

              const SizedBox(height: 20),

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
                        .validateEmpty(
                  value ?? '',
                  "Password",
                ),
              ),

              const SizedBox(height: 10),

              Row(

                children: [

                  Checkbox(

                    value: rememberMe,

                    onChanged: (value) {

                      setState(() {

                        rememberMe =
                            value!;
                      });
                    },
                  ),

                  const Text(
                    "Remember Me",
                  ),
                ],
              ),

              const SizedBox(height: 20),

              SizedBox(

                width: double.infinity,
                height: 55,

                child: ElevatedButton(

                  onPressed: loginUser,

                  child: const Text(

                    "Login",

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