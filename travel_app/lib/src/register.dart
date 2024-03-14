// import 'dart:ffi';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/src/home_page.dart';
import 'package:travel_app/src/login.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void showSignInSnackBar(BuildContext context, String text, Color color) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(text),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
    );
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (phoneController.text.isNotEmpty) {
        showSignInSnackBar(context, "Sign in Sucessfull!", Colors.green);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        showSignInSnackBar(context, "Please Enter Mobile Number!", Colors.red);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding:
                const EdgeInsets.only(right: 10.0, left: 10.0, bottom: 20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        "Create an Account",
                        style: GoogleFonts.lexend(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        "Enter Your Mobile Number:",
                        style: GoogleFonts.manrope(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 11,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 12),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 52,
                        color: Colors.blue[50],
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 15, left: 20, right: 20),
                          child: Image.network(
                            "https://img.freepik.com/free-vector/illustration-india-flag_53876-27130.jpg",
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            hintText: "+91  Enter Mobile Number",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Mobile number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 23,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(93, 73, 190, 1),
                      borderRadius: BorderRadius.circular(3)),
                  width: 370,
                  height: 52,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromRGBO(93, 73, 190, 1)),
                    ),
                    onPressed: () {
                      setState(() {
                        submit(context);
                      });
                    },
                    child: const Text(
                      "Continue",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text("or"),
                const SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: () {
                    showSignInSnackBar(
                      context,
                      "Signing in with Apple",
                      Colors.black,
                    );
                  },
                  child: Container(
                    width: 370,
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.apple),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Continue With Apple",
                                style: GoogleFonts.manrope(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    showSignInSnackBar(
                      context,
                      "Signing in with Facebook",
                      Colors.black,
                    );
                  },
                  child: Container(
                    width: 370,
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.blue),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.facebook,
                                color: Colors.blue,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Continue With Facebook",
                                style: GoogleFonts.manrope(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.blue),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    showSignInSnackBar(
                      context,
                      "Signing in with Google",
                      Colors.black,
                    );
                  },
                  child: Container(
                    width: 370,
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.red),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.g_mobiledata_outlined,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Continue With Google",
                                style: GoogleFonts.manrope(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "By singning up you agree to our",
                          style: GoogleFonts.manrope(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: [
                            Text(
                              "Terms of Service",
                              style: GoogleFonts.manrope(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              "and",
                              style: GoogleFonts.manrope(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              "Privacy Policy",
                              style: GoogleFonts.manrope(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 190,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already had an account ?",
                      style: GoogleFonts.manrope(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      },
                      child: Text(
                        "Log in",
                        style: GoogleFonts.manrope(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
