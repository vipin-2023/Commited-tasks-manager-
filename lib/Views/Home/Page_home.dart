import 'package:flutter/material.dart';
import 'package:tasks/Controller/todo_db_functions.dart';

import 'package:tasks/Models/ToDoModels/To_Do_Models.dart';

import 'package:tasks/Views/Complete/Page_Completed.dart';
import 'package:tasks/Views/Uncomplete/Page_Uncomplete.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);
  static final _pages = [
    const PageUncomplete(),
    const PageComplete(),
  ];

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  static final _toDoController = TextEditingController();

  @override
  void dispose() {
    // other dispose methods
    _toDoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> _bottomNavigationNotifier = ValueNotifier(0);
    return Scaffold(
      appBar: AppBar(
        elevation: .5,
        title: ValueListenableBuilder(
          valueListenable: _bottomNavigationNotifier,
          builder: (BuildContext context, int index, Widget? _) {
            return Text(
              index == 0 ? 'You Can' : 'You Did',
              style: const TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
            );
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: ValueListenableBuilder(
        valueListenable: _bottomNavigationNotifier,
        builder: (BuildContext context, int index, Widget? _) {
          return PageHome._pages[index];
        },
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _bottomNavigationNotifier,
        builder: (BuildContext context, int index, Widget? _) {
          return BottomNavigationBar(
            currentIndex: index,
            elevation: 40,
            onTap: (index) {
              _bottomNavigationNotifier.value = index;

              _bottomNavigationNotifier.notifyListeners();
            },
            selectedItemColor: Colors.black,
            unselectedItemColor: const Color.fromARGB(255, 183, 183, 183),
            items: const [
              BottomNavigationBarItem(
                tooltip: "todos",
                icon: Icon(
                  Icons.today,
                  size: 35,
                ),
                label: " ",
              ),
              BottomNavigationBarItem(
                tooltip: "completed",
                icon: Icon(
                  Icons.check_box_outlined,
                  size: 35,
                ),
                label: " ",
              ),
            ],
          );
        },
      ),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: _bottomNavigationNotifier,
        builder: (BuildContext context, int index, Widget? _) {
          return index == 0
              ? FloatingActionButton(
                  backgroundColor: Colors.black,
                  onPressed: () {
                    _toDoController.clear();
                    showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return AlertDialog(
                            insetPadding:
                                const EdgeInsets.symmetric(horizontal: 30),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            title: const Center(
                                child: Text(
                              "Great Decision",
                              style: TextStyle(fontSize: 28),
                            )),
                            content: Builder(builder: (context) {
                              var height = MediaQuery.of(context).size.height;
                              var width = MediaQuery.of(context).size.width;
                              return SizedBox(
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: _toDoController,
                                      keyboardType: TextInputType.name,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 25),
                                      maxLength: 50,
                                      cursorColor: Colors.grey,
                                      decoration: InputDecoration(
                                        counterText: "",
                                        hintText: "Todo",
                                        hintStyle:
                                            const TextStyle(fontSize: 20),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 145, 145, 145),
                                            width: 1.0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: (() {
                                            Navigator.of(context).pop();
                                          }),
                                          child: const Text(
                                            "Cancel",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (_toDoController.text.isEmpty) {
                                              return;
                                            }
                                            final String _input =
                                                _toDoController.text;

                                            final _model = TodoModel(
                                                todo: _input,
                                                id: DateTime.now()
                                                    .millisecondsSinceEpoch
                                                    .toString());

                                            TodoDB().incertToFunction(_model);

                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            "Confirm",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 16, 159, 0),
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                width: width,
                                height: height * .2,
                              );
                            }),
                          );
                        });
                  },
                  child: const Icon(
                    Icons.add,
                    size: 32,
                  ),
                )
              : const SizedBox();
        },
      ),
    );
  }
}
