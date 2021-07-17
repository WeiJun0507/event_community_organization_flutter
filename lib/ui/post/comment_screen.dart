import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_community_organization/services/database.dart';
import 'package:flutter/material.dart';

class CommentScreen extends StatefulWidget {
  final String username;
  final DateTime postDate;
  final String userId;
  final String content;
  final String imageLink;
  final int likes;
  final String postId;

  const CommentScreen(
      {Key? key,
      required this.username,
      required this.postDate,
      required this.userId,
      required this.content,
      required this.imageLink,
      required this.likes,
      required this.postId})
      : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {

  final _formKey = GlobalKey<FormState>();
  final _dbService = Database();

  late String comment;




  void _commentSection() {
    showDialog(context: context, builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0,top: 15.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      maxLines: 4,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                      ),
                      onChanged: (value) {
                        setState(() {
                          comment = value;
                        });
                      },
                      validator: (value) => value!.isEmpty ? "Comment cannot be empty" : null,
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed:() {
                    _onSubmit();
                  },
                  icon: Icon(Icons.add_comment_outlined)),
            ],
          ),
        ),
      );
    });
  }

  void _onSubmit() async {
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();

      try {
        final commented = await _dbService.createComment(comment, widget.postId);

        if (commented) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Comment added', style: TextStyle(
              color: Colors.white,
            ),),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green[600],
          ));
          Navigator.pop(context);
        } else throw 'Comment Error. Try again later';
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString(), style: TextStyle(
            color: Colors.white,
          ),),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green[600],
        ));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    late int likes = widget.likes;

    return Scaffold(
      backgroundColor: Colors.teal[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_outlined,
                    size: 17.0,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: size.height * 0.5,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(widget.username),
                        subtitle: Text(widget.postDate.toString().substring(0, 16)),
                      ),
                      Expanded(
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
                                    child:
                                        Text("${likes != 0 ? likes : 'Likes'}"),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _commentSection();
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.comment_outlined,
                                    color: Colors.grey,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3.0),
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
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: SizedBox(width: size.width * 0.9, child: Divider(height: 1, color: Colors.grey[400], thickness: 1,)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder<QuerySnapshot?>(
                  future: _dbService.getComment(widget.postId),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Center(child: CircularProgressIndicator(),);
                      return ListView.builder(
                        reverse: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            margin: EdgeInsets.fromLTRB(7, 0, 7, 7),
                            child: ListTile(
                              title: Text(snapshot.data!.docs[index]['student_name']),
                              subtitle: Text(snapshot.data!.docs[index]['commentT']),
                            ),
                          );
                        },
                      );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
