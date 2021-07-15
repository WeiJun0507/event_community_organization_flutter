import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_community_organization/model/comment.dart';
import 'package:event_community_organization/model/event.dart';
import 'package:event_community_organization/model/member.dart';
import 'package:event_community_organization/model/post.dart';
import 'package:event_community_organization/model/register_event.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {
  FirebaseFirestore _cloud = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  //Todo: Create user into database
  Future<bool> createMember(
      String uid, String username, String email, String userType) async {
    try {
      Map<String, dynamic> data =
          Member(uid, username, email, userType).toJson();
      await _cloud.collection('Member').doc(uid).set(data);

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  //getUserProfile
  Future<Member?> getUserProfile(String uid) async {
    try {
      DocumentSnapshot data = await _cloud.collection('Member').doc(uid).get();

      if (data.exists) {
        return Member.fromJson(data.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print(e.toString());
    }
  }

  //---------------------------------------Post Database--------------------------------------------------------//
  Future<bool> createPost(
      String id, String username, String content, String downloadedLink) async {
    try {
      Map<String, dynamic> data = Post(
              '${DateTime.now().toString().substring(0, 19)} $id',
              id,
              username,
              content,
              DateTime.now(),
              downloadedLink)
          .toJson();
      await _cloud
          .collection('Post')
          .doc('${DateTime.now().toString().substring(0, 19)} $id')
          .set(data);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  //get self post
  //use Future Builder to get the data
  Future getPost() async {
    try {
      QuerySnapshot result = await _cloud
          .collection('Post')
          .where('username', isEqualTo: _auth.currentUser!.uid)
          .get();
      return result.docs;
    } catch (e) {
      print(e.toString());
    }
  }

  //need to get the data.
  Future<QuerySnapshot?>? getAllPost() async {
    try {
      QuerySnapshot result = await _cloud.collection('Post').get();
      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> deletePost(DateTime date, String id) async {
    try {
      _cloud.collection('Post').doc('${date.toString()} $id').delete();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  void like(String postId) {
    try {
      Map<String, dynamic> data = {
        'likes': FieldValue.increment(1),
      };
      _cloud.collection('Post').doc(postId).update(data);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> createComment(String comment, String postId) async {
    try {
      Map<String, dynamic> data = PComment(
              '${DateTime.now().toString().substring(0, 19)} ${_auth.currentUser!.uid}',
              _auth.currentUser!.displayName!,
              comment,
              postId,
              DateTime.now())
          .toJson();

      await _cloud
          .collection('Post')
          .doc(postId)
          .collection('Comment')
          .doc(
              '${DateTime.now().toString().substring(0, 19)} ${_auth.currentUser!.displayName!}')
          .set(data);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<QuerySnapshot?>? getComment(String postId) async {
    try {
      final result = await _cloud
          .collection('Post')
          .doc(postId)
          .collection('Comment')
          .get();
      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //----------------------------------------Event Database-------------------------------------------------------------//
  Future<bool> createEvent(
      String o_id,
      String o_name,
      String eventName,
      String uploadImage,
      String description,
      String eventRequirement,
      String termsAndC,
      String venue,
      DateTime date) async {
    try {
      Map<String, dynamic> data = Event(
              '${DateTime.now().toString().substring(0, 19)} $o_id',
              o_id,
              o_name,
              uploadImage,
              eventName,
              description,
              eventRequirement,
              termsAndC,
              venue,
              date)
          .toJson();
      await _cloud
          .collection('Event')
          .doc('${DateTime.now().toString().substring(0, 19)} $o_id')
          .set(data);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> deleteEvent(String id) async {
    try {
      await _cloud.collection('Event').doc(id).delete();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  //get all event
  Stream<QuerySnapshot>? getAllEvent() {
    try {
      final result = _cloud.collection('Event').snapshots();
      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getSpecificOrganizationEvent(String o_id) async {
    try {
      final result =
          await _cloud.collection('Event').where('o_id', isEqualTo: o_id).get();
      return result.docs;
    } catch (e) {
      print(e.toString());
    }
  }

  //Register to the event
  void registerEvent(String o_id, DateTime date, String s_id, String s_name,
      String title, String venue) {
    try {
      Map<String, dynamic> data =
          RegisterEvent('$s_id $title', s_id, s_name, title, o_id, venue, date)
              .toJson();
      _cloud.collection('Register Event').doc('$s_id $title').set(data);
    } catch (e) {
      print(e.toString());
    }
  }
}
