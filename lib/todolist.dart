import 'package:flutter/material.dart';
import 'package:flutter_pj/screen/edit_note_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_pj/component/firestore.dart';
import 'package:flutter_pj/component/note_model.dart';

class ToDoList extends StatefulWidget {
  final Note _note;
  ToDoList(this._note, {Key? key}) : super(key: key);

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        height: 130,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 2, 63, 117).withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              imageWidget(),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget._note.title,
                        ),
                        Checkbox(
                          activeColor: const Color.fromARGB(255, 2, 153, 7),
                          value: isDone,
                          onChanged: (value) {
                            setState(() {
                              isDone = value ?? false;
                              Firestore_Datasource()
                                  .isdone(widget._note.id, isDone);
                            });
                          },
                        ),
                        Text(
                          'Title:',
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Subtitle:',
                      style: GoogleFonts.lato(fontSize: 14),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        imageWidget(),
                        SizedBox(width: 15), // Add this SizedBox
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=> EditNoteScreen(widget._note))
                            );
                          },
                          child: Container(
                            width: 90,
                            height: 28,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(247, 251, 106, 2),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Edit',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container imagewidget() {
    return Container(
      width: 90,
      height: 28,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.timelapse,
            color: Colors.white,
            size: 18,
          ),
          SizedBox(width: 10),
          Text(
            widget._note.time,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Container imageWidget() {
    return Container(
      width: 100,
      height: 130,
      decoration: BoxDecoration(
        color: Colors.amber,
        image: DecorationImage(
          // image: AssetImage('../assets/image/${widget._note.image}.png'),
          image: AssetImage('lib/assets/image/1.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}