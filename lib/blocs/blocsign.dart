import 'dart:async';

import 'package:amen/models/categorie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'bloc.dart';

class BlocSign extends Bloc {
  final _streamController = StreamController<SignState>();
  final currentUser = FirebaseAuth.instance.currentUser;

  Sink<SignState> get sink => _streamController.sink;
  Stream<SignState> get stream => _streamController.stream;

  void init() {
    final resultat = SignState(
        isActive: true,
        user: currentUser,
        categorielist: [],
        collectionReference: FirebaseFirestore.instance
            .collection('users/${currentUser!.uid}/tasks'),
        categorieModel: CategorieModel(
          '',
          '',
          '',
          '',
        ));
    sink.add(resultat);
  }

  BlocSign() {
    init();
  }

  @override
  dispose() {
    _streamController.close();
  }
}

class SignState {
  final bool isActive;
  final User? user;
  CategorieModel? categorieModel;
  List<CategorieModel>? categorielist;
  CollectionReference? collectionReference;

  final currentUser = FirebaseAuth.instance.currentUser;

  SignState(
      {this.isActive = false,
      this.user,
      this.categorielist,
      this.categorieModel,
      this.collectionReference});

  Future<void> addCategorie() async {
    collectionReference = FirebaseFirestore.instance
        .collection('users/${currentUser!.uid}/tasks');

    await collectionReference!
        .doc()
        .set(categorieModel!.toJson())
        .then((value) => print('success'))
        .catchError((error) => print("Failed to  mmd: $error"));
  }

  Future<void> deleteData(CategorieModel categorieModele) async {
    collectionReference = FirebaseFirestore.instance
        .collection('users/${currentUser!.uid}/tasks');

    await collectionReference!
        .doc(categorieModele.id)
        .delete()
        .then((value) => print("Categorie Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> updateDate(CategorieModel categorieModele) async {
    collectionReference = FirebaseFirestore.instance
        .collection('users/${currentUser!.uid}/tasks');

    await collectionReference!
        .doc(categorieModele.id)
        .update(categorieModele.toJson())
        .then((value) => print('Categorie Updated'))
        .catchError((error) => print('$error'));
  }
}
