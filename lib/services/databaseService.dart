import 'package:golet/models/post_model.dart';
import 'package:golet/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:golet/utilities/constants.dart';

class DatabaseService {

  static void updateUser(User user){
    Firestore.instance.collection('users').document(user.id).updateData({
      'name': user.name,
      'profileImageUrl': user.profileImageUrl,
      'bio': user.bio,
    });
  }

  static Future<QuerySnapshot> searchUsers(String name) {
    Future<QuerySnapshot> users = usersRef.where('name', isGreaterThanOrEqualTo: name).getDocuments();
    return users;
  }

  static void createPost(Post post){
    Firestore.instance.collection('posts').document(post.authorId).collection('usersPosts').add({
      'imageUrl': post.imageUrl,
      'location': post.location,
      'type': post.type,
      'description': post.description,
      'price': post.price,
      'authorId': post.authorId,
      'timeStamp': post.timeStamp,
    });
  }

}