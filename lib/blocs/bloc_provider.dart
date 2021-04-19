import 'package:amen/blocs/bloc.dart';
import 'package:flutter/material.dart';

class BlocProvider<T extends Bloc> extends StatefulWidget {
  final T bloc;

  final Widget child;

  BlocProvider({required this.bloc, required this.child});

  static T of<T extends Bloc>(BuildContext context) {
    final BlocProvider<T>? _provider =
        context.findAncestorWidgetOfExactType<BlocProvider<T>>();
    return _provider!.bloc;
  }

  @override
  _BlocProviderState createState() => _BlocProviderState();
}

class _BlocProviderState extends State<BlocProvider> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
