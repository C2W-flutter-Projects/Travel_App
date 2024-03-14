// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class TODOModel {
  int? taskId;
  String? title;
  String? description;
  String? date;

  TODOModel({this.taskId, this.title, this.description, this.date});

  Map<String, dynamic> todoMap() {
    return {
      "taskId": taskId,
      "title": title,
      "description": description,
      "date": date
    };
  }

  @override
  String toString() {
    return """{taskId -> $taskId, title -> $title, description -> $description, date -> $date,}""";
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  ///Text Editing Controllers
  final TextEditingController searchController = TextEditingController();

  final TextEditingController dateController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<TODOModel> cardList = [
    // TODOModel(
    //     title: "Daily Tasks",
    //     description:
    //         "This list includes essential tasks that need to be completed each day, such as responding to emails, making phone calls, and tidying up the workspace.",
    //     date: "3/2/2022"),
    // TODOModel(
    //     title: "Grocery Shopping",
    //     description:
    //         "Keep track of the items you need to purchase from the grocery store, including fresh produce, pantry staples, and household essentials.",
    //     date: "3/2/2022"),
  ];

  double rangeStart = 0;
  double rangeEnd = 100;

  void clearControllers() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
  }

  void submit(bool doEdit, [TODOModel? obj]) {
    if (titleController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        dateController.text.trim().isNotEmpty) {
      if (!doEdit) {
        setState(() {
          cardList.add(TODOModel(
              title: titleController.text.trim(),
              description: descriptionController.text.trim(),
              date: dateController.text.trim()));
        });
      } else {
        setState(() {
          obj!.title = titleController.text.trim();
          obj.description = descriptionController.text.trim();
          obj.date = dateController.text.trim();
        });
      }
    }
    clearControllers();
  }

  void editEntry(TODOModel obj) {
    titleController.text = obj.title!;
    descriptionController.text = obj.description!;
    dateController.text = obj.date!;
    showBottomSht(true, obj);
  }

  void deleteEntry(TODOModel obj) {
    setState(() {
      cardList.remove(obj);
    });
  }

  Future<void> showBottomSht(bool doEdit, [TODOModel? todoModelObj]) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Filters",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Price range",
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              SfRangeSliderTheme(
                data: SfRangeSliderThemeData(
                  tooltipBackgroundColor: Colors.white,
                  tooltipTextStyle: const TextStyle(
                      color: Color.fromRGBO(89, 57, 241, 1),
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                child: SfRangeSlider(
                  shouldAlwaysShowTooltip: true,

                  dragMode: SliderDragMode.both,

                  tooltipTextFormatterCallback: (actualValue, formattedText) {
                    double d = actualValue;

                    return '${d.toStringAsFixed(1000)} ₹';
                  },

                  // enableTooltip: true,

                  min: 1000,

                  max: 10000,

                  activeColor: const Color.fromRGBO(89, 57, 241, 1),

                  startThumbIcon: Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(89, 57, 241, 1),
                        shape: BoxShape.circle),
                    child: const Icon(
                      fill: BorderSide.strokeAlignCenter,
                      size: 15,
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                  ),

                  endThumbIcon: Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(89, 57, 241, 1),
                        shape: BoxShape.circle),
                    child: const Icon(
                      fill: BorderSide.strokeAlignCenter,
                      size: 15,
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                  ),

                  values: SfRangeValues(rangeStart, rangeEnd),

                  onChanged: (value) {
                    setState(() {
                      rangeStart = value.start;

                      rangeEnd = value.end;
                    });
                  },
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title",
                      style: GoogleFonts.quicksand(
                        color: const Color.fromRGBO(89, 57, 241, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: "Enter Title",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(89, 57, 241, 1),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Description",
                      style: GoogleFonts.quicksand(
                        color: const Color.fromRGBO(89, 57, 241, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: "Enter Description",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(89, 57, 241, 1),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Date",
                      style: GoogleFonts.quicksand(
                        color: const Color.fromRGBO(89, 57, 241, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    TextFormField(
                      controller: dateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "Enter Date",
                        suffixIcon: const Icon(Icons.date_range_rounded),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(89, 57, 241, 1),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2023),
                          lastDate: DateTime(2025),
                        );
                        String formatedDate =
                            DateFormat.yMMMd().format(pickedDate!);
                        dateController.text = formatedDate;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: 300,
                margin: const EdgeInsets.all(10),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        13,
                      ),
                    ),
                    backgroundColor: const Color.fromRGBO(89, 57, 241, 1),
                  ),
                  onPressed: () {
                    doEdit ? submit(doEdit, todoModelObj) : submit(doEdit);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Submit",
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

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
                        suffixIcon: IconButton(
                            onPressed: () async {
                              await showBottomSht(false);
                            },
                            icon: const Icon(Icons.filter_alt_outlined)),
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
                          decoration: const BoxDecoration(
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
