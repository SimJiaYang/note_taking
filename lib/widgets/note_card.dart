import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_taking/style/app_style.dart';
import 'package:intl/intl.dart';

// Show the notes title, date, and content
Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc){
  int number = doc["colour_id"];
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppStyle.cardsColor[number],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(doc["note_title"],
            style: AppStyle.mainTitle,overflow: TextOverflow.ellipsis),
            SizedBox(height: 4.0),
          Text(
            timestampToDateString(doc["create_date"]),
            style: AppStyle.dateTitle,overflow: TextOverflow.ellipsis,
          ),
            SizedBox(height: 8.0),
          Text(
            doc["note_content"],style:
            AppStyle.mainContent,
            overflow: TextOverflow.ellipsis,
          ),
        ], //Children
      ),
    ),
  );
}

// Convert Firebase timestamp to Flutter date format
String timestampToDateString(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
  return formattedDate;
}