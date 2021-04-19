import 'package:amen/blocs/bloc_provider.dart';
import 'package:amen/blocs/bloc_router.dart';
import 'package:amen/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:amen/ui/widgets/my_widgets.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = BlocProvider.of<BlocHome>(context);
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(color: Colors.black),
        child: StreamBuilder<HomeState>(
          stream: bloc.stream,
          builder: (context, s) {
            final truc = s.data;
            if (truc == null) {
              return Center(
                child: MyText(label: 'es ladt'),
              );
            } else if (!s.hasData) {
              return Center(
                child: MyText(label: 'nichts'),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.4,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: MyText(
                      label: 'Not&Do',
                      color: Colors.white,
                      fontSize: 40.0,
                    ),
                  ),
                  MyTextButton(
                    onPressed: () {
                      Navigator.of(context).push(BlocRouter().signupPage());
                    },
                    colorText: Colors.black,
                    background: Colors.amber,
                    label: 'SignUp',
                  ),
                  MyTextButton(
                    onPressed: () {
                      Navigator.of(context).push(BlocRouter().signinPage());
                    },
                    colorText: Colors.black,
                    background: Colors.amber,
                    label: 'SignIn',
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
