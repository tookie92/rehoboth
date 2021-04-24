import 'package:amen/blocs/bloc_provider.dart';
import 'package:amen/blocs/bloc_router.dart';
import 'package:amen/blocs/blocs.dart';
import 'package:amen/models/categorie.dart';
import 'package:amen/ui/widgets/my_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HalloPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = BlocProvider.of<BlocSign>(context);
    final _formkey = GlobalKey<FormState>();
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
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
                    left: size.width * 0.04,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: MyText(
                            label: 'Hallo \n ${truc!.user!.displayName}',
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
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
                                  ? Container(
                                      height: size.height * 0.4,
                                      width: size.width,
                                      child: Center(
                                        child: MyText(
                                          label:
                                              'no Categories press the green button',
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  : ListView(
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
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
                      child: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                            color: Colors.green, shape: BoxShape.circle),
                        child: IconButton(
                            onPressed: () async {
                              // Dialog categorie
                              await showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.green,
                                    title: Text('Add a Categorie'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          //form

                                          Column(
                                            children: [
                                              SizedBox(
                                                width: 200,
                                                // height: 200.0,
                                                child: Form(
                                                  key: _formkey,
                                                  child: MyTextField(
                                                    validator: (value) => value!
                                                            .isEmpty
                                                        ? 'Please enter a titel'
                                                        : null,
                                                    labelText: 'title',
                                                    onSaved: (newValue) => truc
                                                        .categorieModel!
                                                        .title = newValue,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          //form end
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      MyTextButton(
                                          onPressed: () async {
                                            if (_formkey.currentState!
                                                .validate()) {
                                              _formkey.currentState!.save();
                                              await truc.addCategorie().then(
                                                  (value) =>
                                                      Navigator.of(context)
                                                          .pop());
                                            }
                                            _formkey.currentState!.reset();
                                          },
                                          background: Colors.amber,
                                          colorText: Colors.white,
                                          label: 'ok')
                                    ],
                                  );
                                },
                              );
                              //dialog ende
                            },
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                            )),
                      ))
                ],
              );
            }
          },
        ),
      ),
    );
  }

// Da sind die Categories
  showCategorie(DocumentSnapshot res, BuildContext context) {
    CategorieModel categorieModel = CategorieModel.fromSnapshot(res);
    final size = MediaQuery.of(context).size;

    var item = Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Stack(
          children: [
            Container(
              height: 300.0,
              width: 300.0,
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(05.0)),
            ),
            Positioned(
                top: size.height * 0.15,
                left: size.height * 0.18,
                child: Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                      color: Colors.redAccent, shape: BoxShape.circle),
                )),
            Positioned(
                top: size.height * 0.20,
                left: size.height * 0.24,
                child: Container(
                  height: 120.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                      color: Colors.amber, shape: BoxShape.circle),
                )),
            //design ende
            Positioned(
              top: size.height * 0.02,
              left: size.width * 0.03,
              child: MyText(
                label: '${categorieModel.title}',
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            Positioned(
              top: size.height * 0.05,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () async {},
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: Colors.white,
                      )),
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
                  IconButton(
                      onPressed: () async {
                        await SignState().deleteData(categorieModel);
                        // await _showMyUpdate(context, categorieModel);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white,
                      )),
                ],
              ),
            )
          ],
        ));

    return item;
  }
}
