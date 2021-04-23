import 'package:amen/blocs/bloc_provider.dart';
import 'package:amen/blocs/bloc_router.dart';
import 'package:amen/blocs/blocsign.dart';
import 'package:amen/models/categorie.dart';
import 'package:amen/ui/widgets/my_text.dart';
import 'package:amen/ui/widgets/my_text_field.dart';
import 'package:amen/ui/widgets/my_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditPage extends StatelessWidget {
  final CategorieModel categorieModele;

  EditPage(this.categorieModele);
  @override
  Widget build(BuildContext context) {
    print(categorieModele.id);
    final size = MediaQuery.of(context).size;
    final bloc = BlocProvider.of<BlocSign>(context);
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.amber,
        child: StreamBuilder<SignState>(
          stream: bloc.stream,
          builder: (context, s) {
            final truc = s.data;
            if (truc == null) {
              return Center(
                child: MyText(
                  label: 'label 1',
                  color: Colors.black,
                ),
              );
            } else if (!s.hasData) {
              return Center(
                child: MyText(
                  label: 'label 2',
                  color: Colors.black,
                ),
              );
            } else {
              return Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 200.0,
                    ),
                    MyText(
                      label: 'Text',
                      color: Colors.white,
                    ),
                    FutureBuilder<DocumentSnapshot>(
                        future: truc.collectionReference!
                            .doc(categorieModele.id)
                            .get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text("Something went wrong");
                          }

                          if (snapshot.hasData && !snapshot.data!.exists) {
                            return Text("Document does not exist");
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            // Map<String, dynamic>? data = snapshot.data!.data();
                            // return Text(
                            //    "Full Name: ${data!['title']} ${data['author']}");
                            return showThat(snapshot.data!, context);
                          }

                          return Text("loading");
                        }),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  showThat(DocumentSnapshot res, BuildContext context) {
    CategorieModel categorieModel = CategorieModel.fromSnapshot(res);
    final _formKey = GlobalKey<FormState>();

    var item = Column(children: [
      MyText(
        label: 'Edit ${categorieModel.title}',
        color: Colors.white,
      ),
      Form(
        key: _formKey,
        child: MyTextField(
          labelText: 'title',
          validator: (value) => value!.isEmpty ? 'Pleaseee' : null,
          initialValue: '${categorieModel.title}',
          onSaved: (newValue) => categorieModel.title = newValue,
        ),
      ),
      Row(
        children: [
          MyTextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  await SignState().updateDate(categorieModel).then((value) =>
                      Navigator.push(context, BlocRouter().halloPage()));
                  print('id: ${categorieModel.id}');
                }
              },
              background: Colors.white,
              label: 'ok'),
        ],
      )
    ]);

    return item;
  }
}
