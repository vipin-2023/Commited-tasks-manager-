import 'package:flutter/material.dart';
import 'package:tasks/Controller/todo_db_functions.dart';

import 'package:tasks/Models/ToDoModels/To_Do_Models.dart';

class PageUncomplete extends StatefulWidget {
  const PageUncomplete({Key? key}) : super(key: key);

  @override
  State<PageUncomplete> createState() => _PageUncompleteState();
}

class _PageUncompleteState extends State<PageUncomplete> {
  final ValueNotifier<int> _selectedItemNotifier = ValueNotifier(0);
  @override
  void initState() {
    _selectedItemNotifier.value = -1;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: TodoDB.instance.uncompletedTodosNotifier,
        builder:
            (BuildContext contex, List<TodoModel> unCompletedList, Widget? _) {
          return TodoDB.instance.uncompletedTodosNotifier.value.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.only(bottom: 70),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemBuilder: (BuildContext ctx, int index) {
                    final toDo = unCompletedList[index];
                    return GestureDetector(
                      onLongPress: () {
                        _selectedItemNotifier.value = index;
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext ctx) {
                              return AlertDialog(
                                insetPadding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                title: const Center(
                                    child: Text(
                                  "Delete",
                                  style: TextStyle(fontSize: 32),
                                )),
                                content: Builder(builder: (context) {
                                  var height =
                                      MediaQuery.of(context).size.height;
                                  var width = MediaQuery.of(context).size.width;
                                  return SizedBox(
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Do you really want to \ndelete?",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 54, 54, 54),
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            GestureDetector(
                                              onTap: (() {
                                                TodoDB.instance
                                                    .deleteTodo(toDo.id);

                                                TodoDB.instance.reFreshUi();
                                                _selectedItemNotifier.value =
                                                    -1;

                                                Navigator.of(context).pop();
                                              }),
                                              child: const Text(
                                                "Delete",
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 255, 53, 38)),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                _selectedItemNotifier.value =
                                                    -1;

                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    width: width,
                                    height: height * .17,
                                  );
                                }),
                              );
                            });
                      },
                      onTap: () {
                        _selectedItemNotifier.value = -1;
                      },
                      child: ValueListenableBuilder(
                          valueListenable: _selectedItemNotifier,
                          builder: (BuildContext context, int selectedIndex,
                              Widget? _) {
                            return Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(16.0),
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                color: selectedIndex == index
                                    ? const Color.fromARGB(255, 186, 186, 186)
                                    : const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: selectedIndex == index
                                        ? const Color.fromARGB(
                                            255, 255, 255, 255)
                                        : const Color.fromARGB(
                                            255, 155, 155, 155),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    toDo.todo,
                                    style: const TextStyle(fontSize: 27),
                                  )),
                                  Container(
                                    // width: 45,
                                    // height: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50.0)),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (BuildContext ctx) {
                                              return AlertDialog(
                                                insetPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 30),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0))),
                                                title: const Center(
                                                    child: Text(
                                                  "Congratulations",
                                                  style:
                                                      TextStyle(fontSize: 27),
                                                )),
                                                content:
                                                    Builder(builder: (context) {
                                                  var height =
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height;
                                                  var width =
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width;
                                                  return SizedBox(
                                                    child: Column(
                                                      children: [
                                                        const Text(
                                                          "You are going to prove that you have commitment",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    54,
                                                                    54,
                                                                    54),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 25,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: (() {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              }),
                                                              child: const Text(
                                                                "Back",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        22,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            0,
                                                                            0,
                                                                            0)),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                TodoDB.instance
                                                                    .updateStatusToCompete(
                                                                        toDo);
                                                                TodoDB.instance
                                                                    .reFreshUi();
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: const Text(
                                                                "Complete",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blue,
                                                                    fontSize:
                                                                        22,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    width: width,
                                                    height: height * .18,
                                                  );
                                                }),
                                              );
                                            });
                                      },
                                      child: const CircleAvatar(
                                        maxRadius: 22,
                                        backgroundColor:
                                            Color.fromARGB(255, 255, 255, 255),
                                        child: CircleAvatar(
                                          maxRadius: 17,
                                          backgroundColor: Color.fromARGB(
                                              255, 189, 189, 189),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    );
                  },
                  itemCount: unCompletedList.length,
                )
              : Center(
                  child: Icon(
                  Icons.computer_rounded,
                  size: 60,
                  color: Colors.grey.shade400,
                ));
        });
  }
}
