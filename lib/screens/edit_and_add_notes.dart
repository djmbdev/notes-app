import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../global.dart';
import '../helpers/cloud_firestore_helper.dart';
import '../colors/colors.dart';

class EditAddNotesPage extends StatefulWidget {
  const EditAddNotesPage({Key? key}) : super(key: key);

  @override
  State<EditAddNotesPage> createState() => _EditAddNotesPageState();
}

class _EditAddNotesPageState extends State<EditAddNotesPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? title;
  String? description;

  @override
  void initState() {
    super.initState();
    clearControllersAndVar();
  }

  @override
  Widget build(BuildContext context) {
    QueryDocumentSnapshot? res;
    if (Global.isUpdate) {
      res = ModalRoute.of(context)!.settings.arguments as QueryDocumentSnapshot;

      titleController.text = "${res["title"]}";
      descriptionController.text = "${res["description"]}";
    }
    return Scaffold(
      backgroundColor: const Color(AppColors.black2),
      appBar: AppBar(
        backgroundColor: const Color(AppColors.black1),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(AppColors.black5),
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (titleController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Color(AppColors.black5),
                    content: Text(
                      "Enter Title First...",
                      style: TextStyle(
                        color: Color(AppColors.black3),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
                return;
              }
              if (descriptionController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Color(AppColors.black5),
                    content: Text(
                      "Enter Description First...",
                      style: TextStyle(
                        color: Color(AppColors.black3),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
                return;
              }

              formKey.currentState!.save();

              Map<String, dynamic> data = {
                "title": title,
                "description": description,
              };

              if (Global.isUpdate) {
                await CloudFirestoreHelper.cloudFirestoreHelper
                    .updateRecords(data: data, id: res!.id);
              } else {
                CloudFirestoreHelper.cloudFirestoreHelper
                    .insertData(data: data);
              }

              Navigator.of(context).pop();
            },
            child: Text(
              (Global.isUpdate) ? "✔️ SAVE" : "➕ ADD",
              style: const TextStyle(
                color: Color(AppColors.black5),
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 7),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  style: const TextStyle(
                    color: Color(AppColors.black5),
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  controller: titleController,
                  decoration: textFieldDecoration("Title"),
                  onSaved: (val) {
                    title = val;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  style: const TextStyle(
                    color: Color(AppColors.black5),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 40,
                  controller: descriptionController,
                  decoration: textFieldDecoration("Description"),
                  onSaved: (val) {
                    description = val;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration textFieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(AppColors.black4)),
      fillColor: const Color(AppColors.black3),
      filled: true,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
    );
  }

  void clearControllersAndVar() {
    titleController.clear();
    descriptionController.clear();

    title = null;
    description = null;
  }
}
