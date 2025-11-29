import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamsync_lite/features/authentication/view/signInscreen.dart';
import 'package:streamsync_lite/features/authentication/viewmodel/bloc/authentiction_bloc.dart';
import 'package:streamsync_lite/features/authentication/viewmodel/validators.dart';
import 'package:streamsync_lite/features/home/view/homescreen.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthentictionBloc, AuthentictionState>(
      listener: (context, state) {
        if (state is AuthenticationFailure) {
          // Show error message
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        } else if (state is AuthenticationSucces) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Authentication Successful!"),
              backgroundColor: Colors.green, // optional: green for success
              duration: Duration(seconds: 2),
            ),
          );

          // Navigate to home screen or another screen upon successful signup
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignInScreen()),
          );
        }
      },
      builder: (context, state) {
        var _passwordController = TextEditingController();
        var _nameController = TextEditingController();

        var _emailController = TextEditingController();

        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.book_outlined, size: 48, color: Colors.blue),
                      SizedBox(height: 16),
                      Text(
                        "Create Your Account",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 18),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          " Username",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Enter User Name',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        validator: validateFullName,
                      ),
                      SizedBox(height: 18),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Email",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Enter your Email Address',
                          prefixIcon: Icon(Icons.email_outlined),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: validateEmail,
                      ),
                      SizedBox(height: 18),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Password",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: 'Enter Your Password',
                          prefixIcon: Icon(Icons.lock_outline),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        obscureText: true,
                        validator: validatePassword,
                      ),
                      SizedBox(height: 16),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(
                            double.infinity,
                            48,
                          ), // Full width, height 48px
                          backgroundColor: Color(
                            0xFF1668F2,
                          ), // Solid blue color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              8,
                            ), // Slightly rounded corners
                          ),
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<AuthentictionBloc>(context).add(
                              RegisterUserEvent(
                                email: _emailController.text,
                                password: _passwordController.text,
                                name: _nameController.text,
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white), // White text
                        ),
                      ),

                      SizedBox(height: 16),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: "Already have an account? "),
                            WidgetSpan(
                              child: InkWell(
                                child: Text(
                                  "Log in",
                                  style: TextStyle(
                                    color: Color(0xFF1668F2),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignInScreen(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
