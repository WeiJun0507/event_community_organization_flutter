import 'package:event_community_organization/model/event.dart';
import 'package:event_community_organization/ui/event/event_detail.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Event event;

  const CustomCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.85,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  event.eventName,
                  style: TextStyle(
                    fontSize: 21.32,
                    color: Color(0xFFE14F4F),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Container(
                  width: size.width,
                  height: size.height * 0.19,
                  child: Image.network(
                    event.imagePath,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  height: size.height * 0.1,
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description: ',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFFFF1E1E),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${event.description.substring(0, event.description.length < 80 ? null : 80)}... ',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFFE14F4F),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  height: size.height * 0.08,
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          'Event Requirements: ',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Color(0xFFFF1E1E),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '${event.eventRequirement.substring(0, event.eventRequirement.split('.')[0].length < 80 ? event.eventRequirement.split('.')[0].length : 80)}..',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFFE14F4F),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  height: size.height * 0.08,
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          'Terms & Conditions: ',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Color(0xFFFF1E1E),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '${event.termsAndC.substring(0, event.termsAndC.split('.')[0].length < 60 ? event.termsAndC.split('.')[0].length : 60)}..',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFFE14F4F),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  height: size.height * 0.03,
                  width: size.width,
                  child: Row(
                    children: [
                      Text(
                        'Venue/Platform: ',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFFFF1E1E),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${event.venue.substring(0, event.venue.length < 20 ? null : 20)}',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFFE14F4F),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  height: size.height * 0.03,
                  width: size.width,
                  child: Row(
                    children: [
                      Text(
                        'Date: ',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFFFF1E1E),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${event.date.toString().substring(0, 16)}',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFFE14F4F),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => EventDetail(
                                      event: event,
                                    )));
                      },
                      child: Text(
                        'View More',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFFE14F4F),
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
