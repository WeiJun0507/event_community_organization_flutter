import 'package:event_community_organization/model/event.dart';
import 'package:flutter/material.dart';

import 'edit_Event.dart';

class EventDetail extends StatelessWidget {
  final Event event;
  const EventDetail({Key? key, required this.event}) : super(key: key);

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
                    Center(child: Image.network(event.imagePath, fit: BoxFit.fill,)),
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
                    Positioned(
                      top: 5.0,
                        right: 5.0,
                        child: IconButton(
                      icon: Icon(
                        Icons.edit_outlined,
                        color: Color(0xFF8FD0CB),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => EditEvent(event: event,)));
                      },
                    )),
                    Positioned(
                      bottom: 5.0,
                        left: 12.0,
                        child: Text(event.eventName, style: TextStyle(
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
                                  '${event.description} ',
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
                                  '${event.eventRequirement}',
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
                                  '${event.termsAndC}',
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
                                  '${event.venue}',
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
                                  '${event.date.toString().substring(0, 16)}',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(onPressed: () {}, child: Text('Register', style: TextStyle(
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
