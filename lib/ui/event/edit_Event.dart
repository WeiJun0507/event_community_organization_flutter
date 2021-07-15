import 'dart:io';

import 'package:event_community_organization/model/event.dart';
import 'package:event_community_organization/services/auth.dart';
import 'package:event_community_organization/services/database.dart';
import 'package:event_community_organization/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class EditEvent extends StatefulWidget {
  final Event event;
  const EditEvent({Key? key, required this.event}) : super(key: key);

  @override
  _EditEventState createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
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
  late DateTime _selectedDate;

  //create TextController
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _eventRequirementController;
  late TextEditingController _termsAndCController;
  late TextEditingController _venueController;


  File? _imageFile;
  String? _urlDownload;


  @override
  void initState() {
    _titleController = new TextEditingController(text: widget.event.eventName);
    _descriptionController = new TextEditingController(text: widget.event.description);
    _eventRequirementController = new TextEditingController(text: widget.event.eventRequirement);
    _termsAndCController = new TextEditingController(text: widget.event.termsAndC);
    _venueController = new TextEditingController(text: widget.event.venue);

    title = _titleController.text;
    description = _descriptionController.text;
    eventRequirement = _eventRequirementController.text;
    termsAndC = _termsAndCController.text;
    venue = _venueController.text;

    _selectedDate = widget.event.date;
    super.initState();
  }


  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _eventRequirementController.dispose();
    _termsAndCController.dispose();
    _venueController.dispose();
    super.dispose();
  }

  _showDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.event.date,
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Photos permission is denied.', style: TextStyle(
          color: Colors.white,
        ),),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red[600],
      ));
    }
  }

  _onSubmit() async {
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();

      if (_imageFile == null) throw 'Image cannot be empty';

      try {
        _urlDownload = await _storage.uploadImageToFirebase(_imageFile);
        if (_urlDownload == null) throw 'No image found. Please select an image.';
        final deleted = await _dbService.deleteEvent(widget.event.id);
        if (deleted) {
          final created = await _dbService.createEvent(user!.uid, user!.displayName!, title,
              _urlDownload!, description, eventRequirement, termsAndC, venue, _selectedDate);
          if (created) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Event Edited successfully', style: TextStyle(
                color: Colors.white,
              ),),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green[600],
            ));
            Navigator.pop(context);
          }
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
            child: Icon(Icons.arrow_back_ios_outlined, size: 20.0,),
          ),
        ),
        title: Text('Edit Event:'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 12.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, left: 10.0),
                        child: Text('Event Title:', style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),),
                      ),
                      TextFormField(
                        controller: _titleController,
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
                            title = _titleController.text;
                          });
                        },
                        validator: (value) => value == null ? 'Title cannot be empty!' : null,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 12.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, left: 10.0),
                        child: Text('Description:', style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),),
                      ),
                      TextFormField(
                        controller: _descriptionController,
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
                        validator: (value) => value == null ? 'Description cannot be empty!' : null,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 12.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, left: 10.0),
                        child: Text('Event Requirements:', style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),),
                      ),
                      TextFormField(
                        controller: _eventRequirementController,
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
                        validator: (value) => value == null ? 'Event Requirement cannot be empty!' : null,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 12.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, left: 10.0),
                        child: Text('Terms & conditions (T&C):', style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),),
                      ),
                      TextFormField(
                        controller: _termsAndCController,
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
                        validator: (value) => value == null ? 'T&C cannot be empty!' : null,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 12.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, left: 10.0),
                        child: Text('Venue/Platform:', style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),),
                      ),
                      TextFormField(
                        controller: _venueController,
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
                        validator: (value) => value == null ? 'Venue cannot be empty!' : null,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 12.0),
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text('Select Date:', style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0
                            ),),
                          )),
                      Expanded(
                        flex:5,
                        child: ElevatedButton(onPressed: () {
                          _showDate();
                        }, child: Text('${_selectedDate.toString().substring(0,16)}', style: TextStyle(
                          color: Colors.black,
                        ),), style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25.0))
                          )
                        ),),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 12.0),
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text('Select Image:', style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0
                            ),),
                          )),
                      Expanded(
                        flex:5,
                        child: ElevatedButton(onPressed: () {
                          _selectImage();
                        }, child: Text('Select Image', style: TextStyle(
                          color: Colors.black,
                        ),), style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(25.0))
                            )
                        ),),
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
                    child: Text('EDIT', style: TextStyle(
                      fontSize: 16.0,
                      letterSpacing: 1.3
                    ),),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFF16A6A),
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
