import 'package:amen/blocs/bloc_provider.dart';
import 'package:amen/blocs/bloc_router.dart';
import 'package:amen/blocs/blocs.dart';
import 'package:amen/services/authenticate.dart';
import 'package:amen/ui/widgets/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HalloPage extends StatelessWidget {
  final User? user;
  HalloPage(this.user);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = BlocProvider.of<BlocSign>(context);
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
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
              return Column(
                children: [
                  SizedBox(
                    height: size.height * 0.4,
                  ),
                  Container(
                    child: MyText(
                      label: 'hallo ${truc!.user!.displayName}',
                    ),
                  ),
                  MyTextButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.remove('email');
                      await DbFire().signOut();
                      Navigator.pushReplacement(
                          context, BlocRouter().homePager());
                    },
                    label: 'Out',
                    colorText: Colors.black,
                    background: Colors.amber,
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
