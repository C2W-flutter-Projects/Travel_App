import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.blue[50],
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 56,
                  ),
                  Container(
                    color: Colors.white,
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Where do you want to stay?",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 60,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 4, color: Colors.deepPurpleAccent),
                            ),
                          ),
                          child: const Icon(
                            size: 30,
                            Icons.beach_access_rounded,
                            color: Colors.deepPurpleAccent,
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 100,
                          child: const Icon(
                            size: 30,
                            Icons.terrain,
                            color: Colors.deepPurpleAccent,
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 100,
                          child: const Icon(
                            size: 30,
                            Icons.business,
                            color: Colors.deepPurpleAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.asset("assets/images/place1.jpg"),
                      const SizedBox(
                        height: 13,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 25,
                            ),
                            Text(
                              "Resort in Goa",
                              style: GoogleFonts.manrope(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Text(
                              "5.0",
                              style: GoogleFonts.manrope(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 25,
                            ),
                            Text(
                              "Beach",
                              style: GoogleFonts.manrope(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.currency_rupee,
                              color: Colors.black,
                              size: 18,
                            ),
                            Text(
                              "850/night",
                              style: GoogleFonts.manrope(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        showUnselectedLabels: true,
        onTap: (index) {
          selectedIndex = index;
        },
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.black),
            label: 'Search',
            activeIcon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.black),
            label: 'favourites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.widgets_outlined, color: Colors.black),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message, color: Colors.black),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.black),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
