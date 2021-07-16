import 'package:event_community_organization/services/database.dart';
import 'package:flutter/material.dart';

class PostDetail extends StatefulWidget {
  final VoidCallback onPress;
  final String username;
  final DateTime postDate;
  final String userId;
  final String content;
  final String imageLink;
  final int like;
  final String postId;

  const PostDetail(
      {Key? key,
      required this.onPress,
      required this.userId,
      required this.username,
      required this.postDate,
      required this.content,
      required this.imageLink,
      required this.like,
      required this.postId,})
      : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  final _dbService = Database();


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    int likes = widget.like;

    return Card(
      elevation: 2.0,
      child: Container(
        height: size.height * 0.4,
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: () {
                widget.onPress();
              },
              child: ListTile(
                title: Text(
                  widget.username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(widget.postDate.toString().substring(0,16)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 5.0),
              child: Text(widget.content,
              maxLines: 3,
              overflow: TextOverflow.fade,),
            ),
            Expanded(
              //Change to Image
              child: Image.network(widget.imageLink),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      try {
                        _dbService.like(widget.postId);
                        setState(() {
                          likes += 1;
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.thumb_up_outlined,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          //make real time changes view of likes
                          child: Text("${likes != 0 ? likes : 'Likes'}"),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onPress,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.comment_outlined,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text("Comment"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
