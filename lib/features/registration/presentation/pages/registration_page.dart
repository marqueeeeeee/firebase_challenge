import 'package:firebase_code_challenge/common/presentation/widgets/base_widget.dart';
import 'package:firebase_code_challenge/dependencies/injector_container.dart';
import 'package:firebase_code_challenge/features/registration/presentation/viewmodels/registration_view_model.dart';
import 'package:firebase_code_challenge/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<RegistrationViewModel>(
      model: sl(),
      builder: (context, model, child) => _RegistrationView(),
    );
  }
}

class _RegistrationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RegistrationViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (viewModel.registrationState ==
                RegistrationState.NewRegistration)
              _RegistrationFieldsView()
            else if (viewModel.registrationState ==
                RegistrationState.VerifyRegistration)
              _RegistrationVerifyView()
            else if (viewModel.registrationState ==
                RegistrationState.RegistrationSuccessful)
              _RegistrationSuccessView()
            else
              _RegistrationErrorView()
          ],
        ));
  }
}

class _RegistrationVerifyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RegistrationViewModel>(context);

    return Column(
      children: [
        TextField(
          controller: viewModel.verifyTextField,
          decoration: InputDecoration(labelText: "Pin"),
        ),
        RaisedButton(
          child: Text("Verify"),
          onPressed: () {
            viewModel.verify();
          },
        )
      ],
    );
  }
}

class _RegistrationFieldsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RegistrationViewModel>(context);

    return Column(
      children: [
        TextField(
          controller: viewModel.mobileTextField,
          decoration: InputDecoration(labelText: "Mobile Number"),
        ),
        RaisedButton(
          child: Text("Register"),
          onPressed: () {
            viewModel.register();
          },
        )
      ],
    );
  }
}

class _RegistrationSuccessView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Success!"),
        RaisedButton(
          onPressed: () =>
              navigatorKey.currentState.pushReplacementNamed("/home"),
          child: Text("Go To Home Page"),
        )
      ],
    );
  }
}

class _RegistrationErrorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RegistrationViewModel>(context);
    return Column(
      children: [
        Text("Error"),
        Text(viewModel.errorMessage),
        RaisedButton(
          onPressed: () => viewModel.retry(),
          child: Text("Retry"),
        )
      ],
    );
  }
}
