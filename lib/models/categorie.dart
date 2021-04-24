import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CategorieModel {
  String? id;
  String? title;
  String? author;
  String? jour;

  CategorieModel(this.title, this.author, this.jour);

  CategorieModel.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        title = snapshot.data()!['title'],
        author = snapshot.data()!['author'],
        jour = snapshot.data()!['jour'];

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'title': this.title,
      'author': FirebaseAuth.instance.currentUser!.displayName,
      'jour': this.jour
    };
    if (id != null) {
      map['id'] = this.id;
    }
    return map;
  }
}
