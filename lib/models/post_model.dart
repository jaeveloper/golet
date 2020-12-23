import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String imageUrl;
  final String location;
  final String type;
  final String description;
  final String price;
  final dynamic favs;
  final String authorId;
  final Timestamp timeStamp;

  Post({
    this.id,
    this.imageUrl,
    this.location,
    this.type,
    this.description,
    this.price,
    this.favs,
    this.authorId,
    this.timeStamp,
  });

  factory Post.fromDoc(DocumentSnapshot doc) {
    return Post(
      id: doc.documentID,
      imageUrl: doc['imageUrl'],
      location: doc['location'],
      type: doc['type'],
      description: doc['description'],
      price: doc['price'],
      favs: doc['favs'],
      authorId: doc['timeStamp'],
    );
  }
}
