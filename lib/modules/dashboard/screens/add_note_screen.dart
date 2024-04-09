import 'package:flutter/material.dart';
import 'package:flutter_task/modules/dashboard/controllers/home_getx_controller.dart';
import 'package:get/get.dart';

class AddNotesScreen extends StatefulWidget {
  final Map<String, dynamic>? noteModel;
  const AddNotesScreen({super.key, this.noteModel});

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  final formKey = GlobalKey<FormState>();
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    if (widget.noteModel != null) {
      homeController.titleController.text =
          widget.noteModel!['title'].toString();
      homeController.titleController.text =
          widget.noteModel!['subtitle'].toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.noteModel != null
            ? const Text("Edit task")
            : const Text("Create your task"),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 100, bottom: 15, left: 15, right: 15),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.task,
                    color: Colors.black,
                    size: 50,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: homeController.titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter title";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.task,
                          color: Colors.black,
                        ),
                        hintText: "Enter title"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: homeController.decsController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter decription";
                      }
                      return null;
                    },
                    maxLines: 4,
                    decoration:
                        const InputDecoration(hintText: "Enter description"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (widget.noteModel != null) {
                          homeController.updateNote(
                              id: widget.noteModel!['id'],
                              title: widget.noteModel!['title'],
                              subtitle: widget.noteModel!['subtitle']);
                        } else {
                          homeController.addNote();
                        }
                      }
                    },
                    child: homeController.isLoadingSave.value == true
                        ? const CircularProgressIndicator()
                        : widget.noteModel != null
                            ? const Text("Edit Task")
                            : const Text("Save Task"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
