import 'package:firebase_code_challenge/common/presentation/viewmodels/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseWidget<G extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, G model, Widget child) builder;
  final G model;
  final Widget child;

  BaseWidget({Key key, this.builder, this.model, this.child}) : super(key: key);

  @override
  _BaseWidgetState<G> createState() => _BaseWidgetState<G>();
}

class _BaseWidgetState<G extends BaseViewModel> extends State<BaseWidget<G>> {
  G viewModel;

  @override
  void initState() {
    viewModel = widget.model;
    viewModel.onLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<G>(
      create: (context) => viewModel,
      child: Consumer<G>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
