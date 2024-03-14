import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/src/book_now.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                width: 350,
                height: 441,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Text(
                      "Payment Success!",
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Text(
                          "Ref number",
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "00000345678765",
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          "Date",
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "9-9-2024",
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          "Time",
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "05:40 AM",
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          "Payment method",
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "Credit card",
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          "Amount",
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "\$30",
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    OutlinedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          fixedSize: const MaterialStatePropertyAll(
                            Size(350, 50),
                          ),
                          side: MaterialStateProperty.all<BorderSide>(
                            const BorderSide(
                              color:
                                  Colors.grey, // Change the border color here
                              width: 1, // Change the border width here
                            ),
                          ),
                          elevation: MaterialStateProperty.all<double>(5),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  0.0), // Change the border radius as needed
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Get PDF receipt",
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(93, 73, 190, 1),
                  borderRadius: BorderRadius.circular(8)),
              width: 370,
              height: 52,
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Change the border radius as needed
                    ),
                  ),
                  backgroundColor: const MaterialStatePropertyAll(
                    Color(0xff6D31ED),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BookNowPage()));
                },
                child: Text(
                  "View booking",
                  style: GoogleFonts.manrope(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
