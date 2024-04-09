// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_task/modules/dashboard/models/note_model.dart';
import 'package:flutter_task/services/database_helper.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController decsController = TextEditingController();

  RxBool isLoading = false.obs;
  // State variables
  var userData = <String, dynamic>{}.obs;

  final DatabaseHelper _databaseHelper = DatabaseHelper();
  var itemList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    loadItemList();
  }

  Future<void> loadItemList() async {
    try {
      isLoading.value = true;
      update();
      List<Map<String, dynamic>> result = await _databaseHelper.queryItemList();
      itemList.value = result;
      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      update();
      print('Error loading item list: $e');
    }
  }

  Future<void> loadUserData() async {
    try {
      isLoading.value = true;
      update();
      Map<String, dynamic>? result = await _databaseHelper.queryUserData();
      if (result != null) {
        userData.value = result;
        isLoading.value = false;
        update();
      } else {
        isLoading.value = false;
        update();
        print('No user data found');
      }
    } catch (e) {
      isLoading.value = false;
      update();
      print('Error loading user data: $e');
    }
  }

  RxBool isLoadingSave = false.obs;

  Future<void> addNote() async {
    isLoadingSave.value = true;
    update();
    DatabaseHelper databaseHelper = DatabaseHelper();
    NoteModel newItem = NoteModel(
      title: titleController.text,
      subtitle: decsController.text,
    );
    await databaseHelper.initializeDatabase(); // Ensure database is initialized
    int result = await databaseHelper.insertItem(newItem);
    if (result != -1) {
      print('Item inserted successfully with ID: $result');
      loadItemList();
      isLoadingSave.value = false;
      update();
      Get.back();
    } else {
      isLoadingSave.value = false;
      update();
      print('Failed to insert item');
    }
  }

  Future<void> deleteNote(int id) async {
    try {
      int result = await _databaseHelper.deleteItem(id);
      if (result != -1) {
        print('Item deleted successfully');
        loadItemList();
      } else {
        print('Failed to delete item');
      }
    } catch (e) {
      print('Error deleting item: $e');
    }
  }

  Future<void> updateNote({
    required int id,
    required String title,
    required String subtitle,
  }) async {
    try {
      int result = await _databaseHelper.updateNote(id, title, subtitle);
      if (result != -1) {
        print('Item updated successfully');
        loadItemList();
        Get.back();
      } else {
        print('Failed to update item');
      }
    } catch (e) {
      print('Error deleting item: $e');
    }
  }
}
