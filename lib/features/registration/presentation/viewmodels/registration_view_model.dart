import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_code_challenge/common/presentation/viewmodels/base_view_model.dart';
import 'package:firebase_code_challenge/main.dart';
import 'package:flutter/material.dart';

enum RegistrationState {
  NewRegistration,
  VerifyRegistration,
  RegistrationSuccessful,
  RegistrationError
}

class RegistrationViewModel extends BaseViewModel {
  var registrationState = RegistrationState.NewRegistration;
  final mobileTextField = TextEditingController();
  final verifyTextField = TextEditingController();

  String verificationId;
  String errorMessage;

  @override
  onLoad() {
    checkIfRegistered();
  }

  checkIfRegistered() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      navigatorKey.currentState.pushReplacementNamed("/home");
    }
  }

  Future register() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: mobileTextField.text,
        timeout: Duration(seconds: 60),
        verificationCompleted: (x) {},
        verificationFailed: (x) {
          registrationState = RegistrationState.RegistrationError;
          errorMessage = x.message;
          notifyListeners();
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          registrationState = RegistrationState.VerifyRegistration;
          this.verificationId = verificationId;
          notifyListeners();
        },
        codeAutoRetrievalTimeout: (x) {});
  }

  Future verify() async {
    final credentials = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: verifyTextField.text);
    final user = await FirebaseAuth.instance.signInWithCredential(credentials);

    if (user != null) {
      registrationState = RegistrationState.RegistrationSuccessful;
    }

    notifyListeners();
  }

  Future retry() async {
    registrationState = RegistrationState.NewRegistration;
    notifyListeners();
  }
}
