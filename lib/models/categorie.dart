import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CategorieModel {
  String? id;
  String? title;
  String? author;

  CategorieModel(this.title, this.author);

  CategorieModel.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        title = snapshot.data()!['title'],
        author = snapshot.data()!['author'];

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'title': this.title,
      'author': FirebaseAuth.instance.currentUser!.displayName
    };
    if (id != null) {
      map['id'] = this.id;
    }
    return map;
  }
}
