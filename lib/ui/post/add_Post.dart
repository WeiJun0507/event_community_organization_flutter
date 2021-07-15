import 'dart:io';

import 'package:event_community_organization/services/auth.dart';
import 'package:event_community_organization/services/database.dart';
import 'package:event_community_organization/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _formKey = GlobalKey<FormState>();

  final picker = ImagePicker();
  final _storage = StorageService();
  final _dbService = Database();
  final user = AuthService().memberDetail;

  late String content;

  File? _imageFile;
  String? _urlDownload;

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

      try{
        _urlDownload = await _storage.uploadImageToFirebasePost(_imageFile);
        if (_urlDownload == null)
          return 'Getting uploaded file error. Please Try again';
        final created = await _dbService.createPost(user!.uid, user!.displayName!, content, _urlDownload!);

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
          backgroundColor: Colors.green[600],
        ));
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined),
            iconSize: 18.0,
            color: Colors.teal[400],
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text('Content:', style: TextStyle(
                        fontSize: 16.0,
                      ),),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: (Colors.grey[400])!, width: 1.0),
                      ),
                      width: size.width * 0.85,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          maxLines: 6,
                          onChanged: (value) {
                            setState(() {
                              content = value;
                            });
                          },
                          validator: (value) => value!.isEmpty ? 'Content cannot be empty' : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0,),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: Text('Image:', style: TextStyle(
                        fontSize: 16.0,
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0),
                      child: Container(
                        width: size.width * 0.5,
                        child: OutlinedButton(
                          onPressed: () {
                            _selectImage();
                          },
                          child: Text('Select an Image to Post'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.0,),
              ElevatedButton(onPressed: () {
                _onSubmit();
              }, child: Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
