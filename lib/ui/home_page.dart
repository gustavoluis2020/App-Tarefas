import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskappgetx/ui/addnotepage.dart';
import 'package:taskappgetx/controller/task_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            await Get.to(() => const AddTaskPage());
            _taskController.getTasks();
          }),
      body: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          const Text(
            'Lista de Tarefas',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          _showTasks(),
        ],
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(
        () {
          return ListView.builder(
              itemCount: _taskController.taskList.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {
                    Get.dialog(customDialog(_, index));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Card(
                      elevation: 15,
                      child: SizedBox(
                        width: Get.width * 0.9,
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 10, 0, 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                _taskController.taskList[index].title
                                    .toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              Expanded(flex: 1, child: Container()),
                              Text(
                                _taskController.taskList[index].date.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Container(
                                width: 3,
                                height: 40,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }

  customDialog(_, index) {
    return Dialog(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: kElevationToShadow[4],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4), topRight: Radius.circular(4))),
            child: const Text('Deseja Apagar a Tarefa?',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 20)),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: Get.width * .3,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      'Voltar',
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.white,
                      shadowColor: Colors.black,
                      elevation: 10,
                      shape: (RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width * .3,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      _taskController.delete(_taskController.taskList[index]);
                      _taskController.getTasks();
                      Get.back();
                    },
                    child: const Text(
                      'Apagar',
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.white,
                      shadowColor: Colors.black,
                      elevation: 10,
                      shape: (RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
