import 'package:event_community_organization/model/event.dart';
import 'package:event_community_organization/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'edit_Event.dart';

class EventDetail extends StatefulWidget {
  final Event event;
  const EventDetail({Key? key, required this.event}) : super(key: key);

  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  final _dbService = Database();
  final _auth = FirebaseAuth.instance;

  String? userType;

  @override
  void initState() {
    super.initState();
    identifyUserType();
  }

  void identifyUserType() async {
    final result = await _dbService.getUserProfile(_auth.currentUser!.uid);
    setState(() {
      userType = result!.userType;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height * 0.34,
                width: size.width,
                color: Colors.grey[800],
                child: Stack(
                  children: [
                    Center(child: Image.network(widget.event.imagePath, fit: BoxFit.fill,)),
                    Positioned(
                      top: 5.0,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Color(0xFF8FD0CB),
                          size: 18.0,
                        ),
                      ),
                    ),
                    userType != null && userType == 'Organization' ? Positioned(
                      top: 5.0,
                        right: 5.0,
                        child: IconButton(
                      icon: Icon(
                        Icons.edit_outlined,
                        color: Color(0xFF8FD0CB),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => EditEvent(event: widget.event,)));
                      },
                    )) : Text(''),
                    Positioned(
                      bottom: 5.0,
                        left: 12.0,
                        child: Text(widget.event.eventName, style: TextStyle(
                          color: Color(0xFF8FD0CB),
                          fontSize: 28.42,
                        ),),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
                child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            width: size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom:8.0),
                                  child: Text(
                                    'Description: ',
                                    style: TextStyle(
                                      fontSize: 19.2,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${widget.event.description} ',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            width: size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    'Event Requirements: ',
                                    style: TextStyle(
                                      fontSize: 19.2,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${widget.event.eventRequirement}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            width: size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Text(
                                    'Terms & Conditions: ',
                                    style: TextStyle(
                                      fontSize: 19.2,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${widget.event.termsAndC}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            width: size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Text(
                                    'Venue/Platform: ',
                                    style: TextStyle(
                                      fontSize: 19.2,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${widget.event.venue}',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                         Container(
                            width: size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Date:',
                                  style: TextStyle(
                                    fontSize: 19.2,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                Text(
                                  '${widget.event.date.toString().substring(0, 16)}',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(onPressed: () {
                            _dbService.registerEvent(widget.event.o_id, _auth.currentUser!.uid, _auth.currentUser!.displayName!, widget.event.eventName, widget.event.venue, widget.event.date);
                          }, child: Text('Register', style: TextStyle(
                            fontSize: 16.0,
                          ),), style: ElevatedButton.styleFrom(
                            primary: Color(0xffF16A6A),
                          ),),
                        )
                      ],
                    )
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
