import 'package:flutter/material.dart';
import 'screens/buku_list.dart';
import 'screens/buku_detail.dart';

void main() {
	runApp(MyApp());
}

class MyApp extends StatelessWidget {

	@override
  Widget build(BuildContext context) {

    return MaterialApp(
	    title: 'DataBuku',
	    debugShowCheckedModeBanner: false,
	    theme: ThemeData(
		    primarySwatch: Colors.deepOrange 
	    ),
	    home: NoteList(),
    );
  }
}