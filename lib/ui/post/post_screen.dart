import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_community_organization/services/database.dart';
import 'package:event_community_organization/ui/post/add_Post.dart';
import 'package:event_community_organization/ui/post/comment_screen.dart';
import 'package:event_community_organization/ui/post/post_detail.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
  final _dbService = Database();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        title: Text(
          "Posts Feed",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.greenAccent,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => AddPost()));
                    },
                    icon: Icon(Icons.create),
                    label: Text("Create an Event")),
              ],
            ),
          ),
          Container(
            width: size.width * 0.9,
            height: size.height * 0.77,
            child: FutureBuilder<QuerySnapshot?>(
                future: _dbService.getAllPost(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  return ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) => PostDetail(
                            onPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => CommentScreen(
                                            userId: snapshot.data!.docs[index]
                                                ['userId'],
                                            content: snapshot.data!.docs[index]
                                                ['content'],
                                            likes: snapshot.data!.docs[index]
                                                ['likes'],
                                            imageLink: snapshot.data!
                                                .docs[index]['downloadedLink'],
                                            postDate: (snapshot
                                                    .data!.docs[index]['date'])
                                                .toDate(),
                                            username: snapshot.data!.docs[index]
                                                ['username'],
                                            postId: snapshot.data!.docs[index]
                                                ['id'],
                                          )));
                            },
                            userId: snapshot.data!.docs[index]['userId'],
                            content: snapshot.data!.docs[index]['content'],
                            like: snapshot.data!.docs[index]['likes'],
                            imageLink: snapshot.data!.docs[index]
                                ['downloadedLink'],
                            postDate:
                                (snapshot.data!.docs[index]['date']).toDate(),
                            username: snapshot.data!.docs[index]['username'],
                            postId: snapshot.data!.docs[index]['id'],
                          ));
                }),
          ),
        ],
      ),
    );
  }
}
