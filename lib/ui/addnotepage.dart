import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskappgetx/widgets/inputfield.dart';
import 'package:taskappgetx/controller/task_controller.dart';
import 'package:taskappgetx/model/task_model.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  //

  final TaskController _taskController = Get.put(TaskController());
  //

  final TextEditingController _titleController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back),
                      iconSize: 30,
                    ),
                    const Text(
                      'Adicione suas Tarefas',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                MyInputField(
                  title: 'Tarefa',
                  hint: ' Digite Sua Tarefa',
                  controller: _titleController,
                ),
                GestureDetector(
                  onTap: () {
                    _getDateFromUser();
                  },
                  child: MyInputField(
                    title: 'Data',
                    hint: DateFormat('dd/MM/yyyy').format(_selectedDate),
                    widget: IconButton(
                      icon: const Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        _getDateFromUser();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: Get.width * .7,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      _validateDate();
                    },
                    child: const Text(
                      'Salvar Tarefa',
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
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
          ),
        ),
      ),
    );
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty) {
      _addTasktODb();
      Get.back();
    } else if (_titleController.text.isEmpty) {
      Get.snackbar(
        'O campo Tarefa não pode ficar em branco!',
        '',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.red,
        icon: const Icon(Icons.warning_amber_rounded),
      );
    }
  }

  _addTasktODb() async {
    int value = await _taskController.addTask(
      task: Task(
        title: _titleController.text,
        date: DateFormat('dd MMM').format(_selectedDate),
      ),
    );
  }

  Future _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {}
  }
}
