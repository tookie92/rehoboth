import 'package:amen/blocs/bloc_provider.dart';
import 'package:amen/blocs/bloc_router.dart';
import 'package:amen/blocs/blocs.dart';
import 'package:amen/models/categorie.dart';
import 'package:amen/ui/widgets/my_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HalloPage extends StatelessWidget {
  //final User? user;

  //HalloPage(this.user);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = BlocProvider.of<BlocSign>(context);
    final _formkey = GlobalKey<FormState>();
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: StreamBuilder<SignState>(
          stream: bloc.stream,
          builder: (context, snapshot) {
            final truc = snapshot.data;
            // ignore: unnecessary_null_comparison
            if (snapshot == null && truc == null) {
              return Center(
                child: Container(
                  child: MyText(
                    label: 'es ladt',
                  ),
                ),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: Container(
                  child: MyText(
                    label: 'es ladt nichts',
                  ),
                ),
              );
            } else {
              return Stack(
                children: [
                  Positioned(
                    top: size.height * 0.15,
                    left: size.width * 0.06,
                    child: Column(
                      children: [
                        Container(
                          child: MyText(
                            label: 'hallo ${truc!.user!.displayName}',
                            color: Colors.amber,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.7,
                              // height: 200.0,
                              child: Form(
                                key: _formkey,
                                child: MyTextField(
                                  validator: (value) => value!.isEmpty
                                      ? 'Please enter a titel'
                                      : null,
                                  labelText: 'title',
                                  onSaved: (newValue) =>
                                      truc.categorieModel!.title = newValue,
                                ),
                              ),
                            ),
                            MyTextButton(
                                onPressed: () async {
                                  if (_formkey.currentState!.validate()) {
                                    _formkey.currentState!.save();
                                    await truc.addCategorie();
                                  }
                                  _formkey.currentState!.reset();
                                },
                                background: Colors.amber,
                                colorText: Colors.white,
                                label: 'ok')
                          ],
                        ),
                        SizedBox(
                          height: 300.0,
                          width: 400.0,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: truc.collectionReference!.snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Something went wrong');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text("Loading");
                              }

                              return (snapshot.data!.docs.isEmpty)
                                  ? MyText(
                                      label: 'nothing',
                                      color: Colors.white,
                                    )
                                  : ListView(
                                      children: snapshot.data!.docs
                                          .map((DocumentSnapshot document) {
                                        return Container(
                                          child:
                                              showCategorie(document, context),
                                        );
                                      }).toList(),
                                    );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: size.height * 0.05,
                      right: size.width * 0.04,
                      child: IconButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.remove('email').then((value) =>
                                Navigator.pushReplacement(
                                    context, BlocRouter().homePager()));
                          },
                          icon: Icon(
                            Icons.door_back,
                            color: Colors.green,
                          )))
                ],
              );
            }
          },
        ),
      ),
    );
  }

  showCategorie(DocumentSnapshot res, BuildContext context) {
    CategorieModel categorieModel = CategorieModel.fromSnapshot(res);

    var item = Container(
      child: Column(
        children: [
          MyText(
            label: '${categorieModel.title}',
            color: Colors.white,
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    Navigator.pushReplacement(
                        context, BlocRouter().editcatPage(categorieModel));
                    // await _showMyUpdate(context, categorieModel);
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  )),
              GestureDetector(
                onDoubleTap: () async {
                  await SignState().deleteData(categorieModel);
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              )
            ],
          )
        ],
      ),
    );

    return item;
  }
}
