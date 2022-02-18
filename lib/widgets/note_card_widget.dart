import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:notekepper/models/notes.dart';
import 'package:notekepper/page/note.dart';
import 'package:notekepper/utils/database_helper.dart';

final _lightColors = [
  Colors.red.shade200,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade500,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100
];

class NoteCardWidget extends StatefulWidget {
  NoteCardWidget({
    Key? key,
    required this.note,
    required this.index,
    required this.noteId,
  }) : super(key: key);

  final Note note;
  final int index;
  final int noteId;

  @override
  State<NoteCardWidget> createState() => _NoteCardWidgetState();
}

class _NoteCardWidgetState extends State<NoteCardWidget> {
  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final color = _lightColors[widget.index % _lightColors.length];
    final time = DateFormat.yMMMd().format(widget.note.createdTime);
    final minHeight = getMinHeight(widget.index);
    double rate = widget.note.number.toDouble();
    Widget deleteButton() => IconButton(
          icon: Icon(Icons.delete),
          onPressed: () async {
            await NotesDatabase.instance.delete(widget.noteId);

            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NotesPage(),
            ));
          },
        );

    return Card(
      color: color,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                  time,
                  style: TextStyle(color: Colors.grey.shade700),
                )),
                Expanded(
                  
                    child: RatingBar.builder(
                     
                  itemCount: widget.note.number,
                  
                  initialRating: widget.note.number.toDouble(),
                  itemSize: 17,
                  
                  onRatingUpdate: (number)  {
                    
                  },
                  ignoreGestures: true,
                  itemBuilder: (BuildContext context, int index) =>
                      Icon(Icons.star),
                      
                ))
              ],
            ),
            SizedBox(height: 4),
            Text(
              widget.note.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              widget.note.description,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 20,
                //fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Spacer(),
                deleteButton(),
              ],
            )
          ],
        ),
      ),
    );
  }

  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}
