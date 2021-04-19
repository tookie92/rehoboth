import 'package:amen/blocs/bloc_provider.dart';
import 'package:amen/blocs/blocs.dart';
import 'package:amen/blocs/blocsign.dart';
import 'package:amen/ui/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class BlocRouter {
  MaterialPageRoute signupPage() =>
      MaterialPageRoute(builder: (context) => signup());
  MaterialPageRoute signinPage() =>
      MaterialPageRoute(builder: (context) => signin());
  MaterialPageRoute halloPage(User? u) =>
      MaterialPageRoute(builder: (ctx) => hallo(u));
  MaterialPageRoute homePager() =>
      MaterialPageRoute(builder: (ctx) => homePage());

  BlocProvider hallo(User? user) =>
      BlocProvider<BlocSign>(bloc: BlocSign(), child: HalloPage(user));
  BlocProvider signin() =>
      BlocProvider<BlocSign>(bloc: BlocSign(), child: Signin());
  BlocProvider signup() =>
      BlocProvider<BlocSign>(bloc: BlocSign(), child: Signup());
  BlocProvider homePage() =>
      BlocProvider<BlocHome>(bloc: BlocHome(), child: MyHomePage());
}
