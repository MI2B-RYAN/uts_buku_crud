import 'dart:async';
import 'package:flutter/material.dart';
import '../models/buku.dart';
import '../utils/database_helper.dart';
import 'package:intl/intl.dart';

class NoteDetail extends StatefulWidget {

	final String appBarTitle;
	final Note note;

	NoteDetail(this. note, this.appBarTitle);

	@override
  State<StatefulWidget> createState() {

    return NoteDetailState(this.note, this.appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {

	static var _priorities = ['Buku Rusak', 'Buku Sobek'];

	DatabaseHelper helper = DatabaseHelper();

	String appBarTitle;
	Note note;

	TextEditingController judulController = TextEditingController();
	TextEditingController deskripsiController = TextEditingController();

	NoteDetailState(this.note, this.appBarTitle);

	@override
  Widget build(BuildContext context) {

		TextStyle textStyle = Theme.of(context).textTheme.title;

		judulController.text = note.judul;
		deskripsiController.text = note.deskripsi;

    return WillPopScope(

	    onWillPop: () {
	    
		    moveToLastScreen();
	    },

	    child: Scaffold(
	    appBar: AppBar(
		    title: Text(appBarTitle),
		    leading: IconButton(icon: Icon(
				    Icons.arrow_back),
				    onPressed: () {
		    	    
		    	    moveToLastScreen();
				    }
		    ),
	    ),

	    body: Padding(
		    padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
		    child: ListView(
			    children: <Widget>[

			    
				    ListTile(
					    title: DropdownButton(
							    items: _priorities.map((String dropDownStringItem) {
							    	return DropdownMenuItem<String> (
									    value: dropDownStringItem,
									    child: Text(dropDownStringItem),
								    );
							    }).toList(),

							    style: textStyle,

							    value: getPriorityAsString(note.priority),

							    onChanged: (valueSelectedByUser) {
							    	setState(() {
							    	  debugPrint('User selected $valueSelectedByUser');
							    	  updatePriorityAsInt(valueSelectedByUser);
							    	});
							    }
					    ),
				    ),

				  
				    Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: TextField(
						    controller: judulController,
						    style: textStyle,
						    onChanged: (value) {
						    	debugPrint('Something changed in Title Text Field');
						    	updateTitle();
						    },
						    decoration: InputDecoration(
							    labelText: 'Title',
							    labelStyle: textStyle,
							    border: OutlineInputBorder(
								    borderRadius: BorderRadius.circular(5.0)
							    )
						    ),
					    ),
				    ),

				    
				    Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: TextField(
						    controller: deskripsiController,
						    style: textStyle,
						    onChanged: (value) {
							    debugPrint('Something changed in Description Text Field');
							    updateDescription();
						    },
						    decoration: InputDecoration(
								    labelText: 'Description',
								    labelStyle: textStyle,
								    border: OutlineInputBorder(
										    borderRadius: BorderRadius.circular(5.0)
								    )
						    ),
					    ),
				    ),

				    Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: Row(
						    children: <Widget>[
						    	Expanded(
								    child: RaisedButton(
									    color: Theme.of(context).primaryColorDark,
									    textColor: Theme.of(context).primaryColorLight,
									    child: Text(
										    'Save',
										    textScaleFactor: 1.5,
									    ),
									    onPressed: () {
									    	setState(() {
									    	  debugPrint("Save button clicked");
									    	  _save();
									    	});
									    },
								    ),
							    ),

							    Container(width: 5.0,),

							    Expanded(
								    child: RaisedButton(
									    color: Theme.of(context).primaryColorDark,
									    textColor: Theme.of(context).primaryColorLight,
									    child: Text(
										    'Delete',
										    textScaleFactor: 1.5,
									    ),
									    onPressed: () {
										    setState(() {
											    debugPrint("Delete button clicked");
											    _delete();
										    });
									    },
								    ),
							    ),

						    ],
					    ),
				    ),

			    ],
		    ),
	    ),

    ));
  }

  void moveToLastScreen() {
		Navigator.pop(context, true);
  }

	
	void updatePriorityAsInt(String value) {
		switch (value) {
			case 'High':
				note.priority = 1;
				break;
			case 'Low':
				note.priority = 2;
				break;
		}
	}

	
	String getPriorityAsString(int value) {
		String priority;
		switch (value) {
			case 1:
				priority = _priorities[0];  
				break;
			case 2:
				priority = _priorities[1];  
				break;
		}
		return priority;
	}

	
  void updateTitle(){
    note.judul = judulController.text;
  }


	void updateDescription() {
		note.deskripsi = deskripsiController.text;
	}

	
	void _save() async {

		moveToLastScreen();

		note.tanggal = DateFormat.yMMMd().format(DateTime.now());
		int result;
		if (note.id != null) {  
			result = await helper.updateNote(note);
		} else { 
			result = await helper.insertNote(note);
		}

		if (result != 0) {  
			_showAlertDialog('Status', 'Buku Berhasil Di Update');
		} else {  
			_showAlertDialog('Status', 'Gagal');
		}

	}

	void _delete() async {

		moveToLastScreen();

		
		if (note.id == null) {
			_showAlertDialog('Status', 'Buku Berhasil Di Hapus');
			return;
		}

		
		int result = await helper.deleteNote(note.id);
		if (result != 0) {
			_showAlertDialog('Status', 'Data Buku Berhasil Di Hapus');
		} else {
			_showAlertDialog('Status', 'Gagal Menghapus Buku');
		}
	}

	void _showAlertDialog(String title, String message) {

		AlertDialog alertDialog = AlertDialog(
			title: Text(title),
			content: Text(message),
		);
		showDialog(
				context: context,
				builder: (_) => alertDialog
		);
	}

}









