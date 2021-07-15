import 'dart:io';
import 'package:event_community_organization/services/auth.dart';
import 'package:event_community_organization/services/database.dart';
import 'package:event_community_organization/services/storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _formKey = GlobalKey<FormState>();

  final picker = ImagePicker();
  final _storage = StorageService();
  final _dbService = Database();
  final user = AuthService().memberDetail;

  late String title;
  late String description;
  late String eventRequirement;
  late String termsAndC;
  late String venue;
  DateTime _selectedDate = DateTime.now();

  File? _imageFile;
  String? _urlDownload;

  _showDate() async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2050),
    );
    if (pickedDate == null) return 'Please select a date';
    setState(() {
      _selectedDate = pickedDate;
    });
  }


  _selectImage() async {
    //check permission first
    PermissionStatus status = await Permission.photos.request();

    if (status.isGranted) {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      if (pickedFile == null) return;

      setState(() {
        //dart.io File, not dart.html
        _imageFile = File(pickedFile.path);
      });
    } else {
      print('Photos permission is denied.');
    }
  }

  _onSubmit() async {
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();

      if (_imageFile == null) throw 'Image cannot be empty';

      try {
        _urlDownload = await _storage.uploadImageToFirebase(_imageFile);
        if (_urlDownload == null)
          return 'Getting uploaded file error. Please Try again';
        final created = await _dbService.createEvent(user!.uid, user!.displayName!, title,
            _urlDownload!, description, eventRequirement, termsAndC, venue, _selectedDate);
        if (created) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Event created successfully', style: TextStyle(
              color: Colors.white,
            ),),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green[600],
          ));
          Navigator.pop(context);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString(), style: TextStyle(
            color: Colors.white,
          ),),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red[600],
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF4B49B6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_back_ios_outlined,
              size: 20.0,
            ),
          ),
        ),
        title: Text('Create New Event:'),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 20.0, right: 12.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, left: 10.0),
                      child: Text(
                        'Event Title:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    TextFormField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 5, top: 5, right: 15),
                      ),
                      onChanged: (value) {
                        setState(() {
                          title = value;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Title cannot be empty!' : null,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 20.0, right: 12.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, left: 10.0),
                      child: Text(
                        'Description:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                      ),
                      onChanged: (value) {
                        setState(() {
                          description = value;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Description cannot be empty!' : null,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 20.0, right: 12.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, left: 10.0),
                      child: Text(
                        'Event Requirements:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    TextFormField(
                      maxLines: 3,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                      ),
                      onChanged: (value) {
                        setState(() {
                          eventRequirement = value;
                        });
                      },
                      validator: (value) => value == null
                          ? 'Event Requirement cannot be empty!'
                          : null,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 20.0, right: 12.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, left: 10.0),
                      child: Text(
                        'Terms & conditions (T&C):',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    TextFormField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                      ),
                      onChanged: (value) {
                        setState(() {
                          termsAndC = value;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'T&C cannot be empty!' : null,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 20.0, right: 12.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, left: 10.0),
                      child: Text(
                        'Venue/Platform:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    TextFormField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 5, top: 5, right: 15),
                      ),
                      onChanged: (value) {
                        setState(() {
                          venue = value;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Venue cannot be empty!' : null,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 20.0, right: 12.0),
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Select Date:',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        )),
                    Expanded(
                      flex: 5,
                      child: ElevatedButton(
                        onPressed: () {
                          _showDate();
                        },
                        child: Text(
                          _selectedDate.toString().substring(0,16),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)))),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 20.0, right: 12.0),
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Select Image:',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        )),
                    Expanded(
                      flex: 5,
                      child: ElevatedButton(
                        onPressed: () {
                          _selectImage();
                        },
                        child: Text(
                          'Image Pick',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)))),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: () {
                  _onSubmit();
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                    'CREATE',
                    style: TextStyle(fontSize: 16.0, letterSpacing: 1.3),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFF16A6A),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
