import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart'; // Import for Clipboard and ClipboardData
import 'package:share_plus/share_plus.dart';
import '../global.dart';
import '../helpers/cloud_firestore_helper.dart';
import '../colors/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? searchText;

  void _showDeleteConfirmationDialog() async {
    var hasData =
        await CloudFirestoreHelper.cloudFirestoreHelper.checkDataExist();

    if (!hasData) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(AppColors.black5),
          content: Text(
            "There are no notes to delete.",
            style: const TextStyle(
              color: Color(AppColors.black3),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(AppColors.black1),
          title: const Text(
            'Confirm Delete',
            style: TextStyle(color: Color(AppColors.black5)),
          ),
          content: const Text(
            'Are you sure you want to delete all notes?',
            style: TextStyle(color: Color(AppColors.black5)),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(AppColors.black5)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Delete',
                style: TextStyle(color: Color(AppColors.black5)),
              ),
              onPressed: () async {
                await CloudFirestoreHelper.cloudFirestoreHelper
                    .deleteAllRecords();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Color(AppColors.black5),
                    content: Text(
                      "All notes deleted successfully...",
                      style: TextStyle(
                        color: Color(AppColors.black3),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColors.black2),
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.edit, color: Colors.white),
            const SizedBox(width: 7),
            Text(
              "Notes",
              style: GoogleFonts.poppins(
                color: Colors.white.withOpacity(0.9),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(AppColors.black1),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 37,
              width: MediaQuery.of(context).size.width * 0.51,
              child: TextField(
                style: const TextStyle(color: Color(AppColors.black5)),
                cursorColor: const Color(AppColors.black5),
                decoration: InputDecoration(
                  hintText: 'Search notes by title...',
                  hintStyle: const TextStyle(
                    color: Color(AppColors.black4),
                  ),
                  filled: true,
                  fillColor: const Color(AppColors.black3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(AppColors.black5),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: const Icon(Icons.delete, color: Color(AppColors.black5)),
              onPressed: _showDeleteConfirmationDialog,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(AppColors.black4),
        foregroundColor: const Color(AppColors.black1),
        onPressed: () {
          Global.isUpdate = false;
          Navigator.of(context).pushNamed("edit_add_notes_page");
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: CloudFirestoreHelper.cloudFirestoreHelper
            .selectRecords(searchText: searchText),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            List<QueryDocumentSnapshot> data = snapshot.data!.docs;

            if (data.isEmpty) {
              return const Center(
                child: Text(
                  "No notes added yet...",
                  style: TextStyle(
                    color: Color(AppColors.black5),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: data.length,
              itemBuilder: (context, i) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: InkWell(
                    onTap: () {
                      Global.isUpdate = true;
                      Navigator.of(context)
                          .pushNamed("edit_add_notes_page", arguments: data[i]);
                    },
                    splashColor: const Color(AppColors.black2),
                    borderRadius: BorderRadius.circular(20),
                    child: Ink(
                      decoration: BoxDecoration(
                        color: const Color(AppColors.black3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(
                            right: 20, left: 20, top: 15, bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${data[i]["title"]}",
                              style: const TextStyle(
                                color: Color(AppColors.black5),
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "${data[i]["description"]}",
                              style: const TextStyle(
                                color: Color(AppColors.black5),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Spacer(),
                                IconButton(
                                  onPressed: () async {
                                    await Share.share(
                                        "Title : ${data[i]["title"]}\nDescription : ${data[i]["description"]}");
                                  },
                                  icon: const Icon(Icons.share_rounded),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await Clipboard.setData(
                                      ClipboardData(
                                        text:
                                            "Title : ${data[i]["title"]}\nDescription : ${data[i]["description"]}",
                                      ),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        duration: Duration(seconds: 2),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor:
                                            Color(AppColors.black5),
                                        content: Text(
                                          "Note copied successfully...",
                                          style: TextStyle(
                                            color: Color(AppColors.black3),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.content_copy_rounded),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await CloudFirestoreHelper
                                        .cloudFirestoreHelper
                                        .deleteRecords(id: data[i].id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        duration: Duration(seconds: 2),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor:
                                            Color(AppColors.black5),
                                        content: Text(
                                          "Note deleted successfully...",
                                          style: TextStyle(
                                            color: Color(AppColors.black3),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.delete_outline),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
