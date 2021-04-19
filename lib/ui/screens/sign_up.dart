import 'package:amen/blocs/bloc_provider.dart';
import 'package:amen/blocs/blocs.dart';
import 'package:amen/services/authenticate.dart';
import 'package:amen/ui/widgets/my_widgets.dart';
import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final size = MediaQuery.of(context).size;
    final bloc = BlocProvider.of<BlocSign>(context);
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(color: Colors.black),
        child: StreamBuilder<SignState>(
          stream: bloc.stream,
          builder: (context, s) {
            final truc = s.data;
            if (truc == null) {
              return Center(
                child: MyText(
                  label: 'das kommt',
                ),
              );
            } else if (!s.hasData) {
              return Center(
                child: MyText(
                  label: 'da ist nichts',
                ),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.2,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: size.width * 0.3,
                      ),
                      MyText(
                        label: 'Sign Up',
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 25.0),
                          child: MyTextField(
                              controller: nameController, labelText: 'Name'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20.0),
                          child: MyTextField(
                              controller: emailController, labelText: 'Email'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 25.0),
                          child: MyTextField(
                              controller: passwordController,
                              obscureText: true,
                              labelText: 'Password'),
                        ),
                      ],
                    ),
                  ),
                  MyTextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          await DbFire().signUp(
                              emailController.text,
                              passwordController.text,
                              nameController.text,
                              context);
                        }
                        _formKey.currentState!.reset();
                      },
                      colorText: Colors.white,
                      background: Colors.amber,
                      label: 'Register')
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
