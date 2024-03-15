import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
// import 'package:todolist_app/advancetodobysir.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

dynamic database;
List<TODOModel> taskList = [];
double starsRating = 0.0;

// insert
Future<void> insertTaskData(TODOModel obj) async {
  final localDB = await database;

  await localDB.insert("AddTask", obj.todoMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

// fetch data
Future<List<TODOModel>> getTaskData() async {
  final localDB = await database;

  List<Map<String, dynamic>> taskMap = await localDB.query("AddTask");
  print("INSIDE MAP: $taskMap");
  return List.generate(taskMap.length, (i) {
    return TODOModel(
      taskId: taskMap[i]['taskId'],
      title: taskMap[i]['title'],
      description: taskMap[i]['description'],
      stars: taskMap[i]['stars'],
      // date: taskMap[i]['date'],
    );
  });
}

// delete
Future<void> deleteTaskData(int? data) async {
  final localDB = await database;

  await localDB.delete(
    "AddTask",
    where: "taskId = ?",
    whereArgs: [data],
  );
}

// update
Future<void> updateTaskData(TODOModel obj) async {
  final localDB = await database;
  await localDB.update(
    "AddTask",
    obj.todoMap(),
    where: "taskId = ?",
    whereArgs: [obj.taskId],
  );
}

class TODOModel {
  final int? taskId;
  String? title;
  String? description;
  double? stars;
  // String? date;

  TODOModel({this.taskId, this.title, this.description, this.stars});

  Map<String, dynamic> todoMap() {
    return {
      "taskId": taskId,
      "title": title,
      "description": description,
      "stars": stars,
    };
  }

  @override
  String toString() {
    return """{taskId : $taskId, title : $title, description : $description, stars : $stars}""";
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TODOAppUI(),
    );
  }
}

class TODOAppUI extends StatefulWidget {
  const TODOAppUI({super.key});
  @override
  State<TODOAppUI> createState() => _TODOAppUIState();
}

class _TODOAppUIState extends State<TODOAppUI> {
  List<TODOModel> cardList = taskList;

  ///Text Editing Controllers
  // final TextEditingController dateController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void clearControllers() {
    titleController.clear();
    descriptionController.clear();
    // dateController.clear();
  }

  void submit(bool doEdit, [TODOModel? obj]) async {
    if (titleController.text.trim().isNotEmpty &&
            descriptionController.text.trim().isNotEmpty &&
            starsRating != 0.0
        // dateController.text.trim().isNotEmpty
        ) {
      if (!doEdit) {
        setState(() {
          insertTaskData(TODOModel(
              title: titleController.text.trim(),
              description: descriptionController.text.trim(),
              stars: starsRating));

          cardList.add(TODOModel(
            title: titleController.text.trim(),
            description: descriptionController.text.trim(),
            // date: dateController.text.trim()
          ));
        });
        print("After Insertion: ${await getTaskData()}");
      } else {
        setState(() {
          obj!.title = titleController.text.trim();
          obj.description = descriptionController.text.trim();
          // obj.date = dateController.text.trim();
        });
      }
    }
    clearControllers();
  }

  void editEntry(TODOModel obj) async {
    titleController.text = obj.title!;
    descriptionController.text = obj.description!;
    // dateController.text = obj.date!;
    updateTaskData(obj);
    print("After update:  ${await getTaskData()}");

    showBottomSht(true, obj);
  }

  void deleteEntry(TODOModel obj) async {
    setState(() {
      cardList.remove(obj);
      deleteTaskData(obj.taskId);
      for (int? i = obj.taskId! + 1; i! < taskList.length; i += 1) {
        updateTaskData(TODOModel(taskId: i - 1));
      }
    });
    print("After delete:  ${await getTaskData()}");
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
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Add Review",
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 15,
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
                        hintText: "Enter Review",
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
                      "Rating",
                      style: GoogleFonts.quicksand(
                        color: const Color.fromRGBO(89, 57, 241, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        starsRating = rating;
                        print(rating);
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
    print("Inside buildcontext $cardList or $taskList");
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35),
              child: Text(
                "Good Morning",
                style: GoogleFonts.quicksand(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 22,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(left: 35),
              child: Text(
                "User",
                style: GoogleFonts.quicksand(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(217, 217, 217, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(
                      40,
                    ),
                  ),
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "REVIEWS",
                      style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top: 30),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(
                              40,
                            ),
                          ),
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: cardList.length,
                          itemBuilder: (context, index) {
                            return Slidable(
                              // closeOnScroll: true,
                              endActionPane: ActionPane(
                                extentRatio: 0.2,
                                motion: const DrawerMotion(),
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        GestureDetector(
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  89, 57, 241, 1),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: const Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                          onTap: () {
                                            editEntry(cardList[index]);
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        GestureDetector(
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  89, 57, 241, 1),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                          onTap: () {
                                            deleteEntry(cardList[index]);
                                          },
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              key: ValueKey(index),
                              child: Container(
                                margin: const EdgeInsets.only(top: 10),
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  bottom: 20,
                                  top: 20,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                  border: Border.all(
                                      color:
                                          const Color.fromRGBO(0, 0, 0, 0.05),
                                      width: 0.5),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0, 4),
                                      blurRadius: 20,
                                      color: Color.fromRGBO(0, 0, 0, 0.13),
                                    )
                                  ],
                                  borderRadius:
                                      const BorderRadius.all(Radius.zero),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    cardList[index].title!,
                                                    style: GoogleFonts.manrope(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                cardList[index].description!,
                                                style: GoogleFonts.manrope(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    size: 18,
                                                    color: Colors.amber,
                                                  ),
                                                  Text(
                                                    "$starsRating",
                                                    style: GoogleFonts.manrope(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          const Spacer(),
                                          Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                image: const DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                      "assets/images/place1.jpg",
                                                    ))),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.all(20),
        height: 100,
        width: 150,
        child: FloatingActionButton(
          backgroundColor: Colors.blue.shade100,
          onPressed: () async {
            await showBottomSht(false);
          },
          child: Container(
            child: Text(
              "Add Reviews",
              style: GoogleFonts.manrope(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
