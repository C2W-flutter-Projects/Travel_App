import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/src/book_now.dart';

class Add_Guest extends StatefulWidget {
  const Add_Guest({super.key});

  @override
  State<Add_Guest> createState() => _Add_GuestState();
}

class _Add_GuestState extends State<Add_Guest> {
  TextEditingController locController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  int adultCount = 0;
  int childrenCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(
              height: 72,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.cancel),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: locController,
              decoration: InputDecoration(
                hintText: 'Location',
                suffixIcon: const Icon(Icons.location_on),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                hintText: 'Dates',
                suffixIcon: const Icon(Icons.date_range),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "How Many Guests",
                        style: GoogleFonts.lexend(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "Adults",
                        style: GoogleFonts.manrope(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (adultCount > 0) {
                              adultCount--;
                            }
                          });
                        },
                        child: const Icon(Icons.remove),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20),
                          minimumSize: Size(20, 30),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(15),
                        child: Text(
                          "$adultCount",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            adultCount++;
                          });
                        },
                        child: const Icon(Icons.add),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20),
                          minimumSize: Size(20, 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    children: [
                      Text(
                        "Children",
                        style: GoogleFonts.manrope(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (childrenCount > 0) {
                              childrenCount--;
                            }
                          });
                        },
                        child: const Icon(Icons.remove),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20),
                          minimumSize: Size(20, 30),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(15),
                        child: Text(
                          "$childrenCount",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            childrenCount++;
                          });
                        },
                        child: const Icon(Icons.add),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20),
                          minimumSize: Size(20, 20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      adultCount = 0;
                      childrenCount = 0;
                      locController.text = "";
                      dateController.text = "";
                    });
                  },
                  child: Container(
                    child: const Text(
                      "clear all",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.deepPurpleAccent)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BookNowPage()));
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
