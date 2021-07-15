import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_community_organization/model/event.dart';
import 'package:event_community_organization/services/database.dart';
import 'package:event_community_organization/ui/event/add_event.dart';
import 'package:event_community_organization/ui/event/customCard.dart';
import 'package:flutter/material.dart';

class EventDashboard extends StatefulWidget {
  const EventDashboard({Key? key}) : super(key: key);

  @override
  _EventDashboardState createState() => _EventDashboardState();
}

class _EventDashboardState extends State<EventDashboard> {
  final _dbService = Database();
  int eventNumber = 0;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFF4B49B6),
      appBar: AppBar(
        backgroundColor: Color(0xFF4B49B6),
        elevation: 0.0,
        title: Text(
          'Event',
          style: TextStyle(
            fontSize: 28.42,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => AddEvent()));
              },
              icon: Icon(
                Icons.add_circle_outline_outlined,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: _dbService.getAllEvent(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                eventNumber = snapshot.data!.docs.length;

                return CarouselSlider(
                  items: snapshot.data!.docs.map((event) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 15.0),
                        child: CustomCard(
                          event: Event.fromJson(event.data() as Map<String,dynamic>),
                        ),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: size.height * 0.79,
                    viewportFraction: 0.83,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    aspectRatio: 21/9,
                    onPageChanged: (index, _) {
                      setState(() {
                        _currentPage = index;
                      });
                    }
                  ),
                );
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(eventNumber, (index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: index == _currentPage ? Color(0xFF090697) : Colors.white,
                    ),
                  ),
                );
            }),
          )
        ],
      ),
    );
  }
}
