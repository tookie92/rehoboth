import 'package:amen/blocs/bloc_provider.dart';
import 'package:amen/blocs/blocs.dart';
import 'package:amen/blocs/blocsign.dart';
import 'package:amen/models/categorie.dart';
import 'package:amen/ui/screens/edit_page.dart';
import 'package:amen/ui/screens/screens.dart';

import 'package:flutter/material.dart';

class BlocRouter {
  MaterialPageRoute signupPage() =>
      MaterialPageRoute(builder: (context) => signup());
  MaterialPageRoute signinPage() =>
      MaterialPageRoute(builder: (context) => signin());
  MaterialPageRoute halloPage() => MaterialPageRoute(builder: (ctx) => hallo());
  MaterialPageRoute homePager() =>
      MaterialPageRoute(builder: (ctx) => homePage());

  //probe
  MaterialPageRoute editcatPage(CategorieModel cat) =>
      MaterialPageRoute(builder: (context) => editCat(cat));

  BlocProvider editCat(CategorieModel categorieModel) =>
      BlocProvider<BlocSign>(bloc: BlocSign(), child: EditPage(categorieModel));
  //probe ende

  BlocProvider hallo() =>
      BlocProvider<BlocSign>(bloc: BlocSign(), child: HalloPage());
  BlocProvider signin() =>
      BlocProvider<BlocSign>(bloc: BlocSign(), child: Signin());
  BlocProvider signup() =>
      BlocProvider<BlocSign>(bloc: BlocSign(), child: Signup());
  BlocProvider homePage() =>
      BlocProvider<BlocHome>(bloc: BlocHome(), child: MyHomePage());
}
