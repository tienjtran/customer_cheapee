import 'package:customer_cheapee/viewmodels/login_model.dart';
import 'package:customer_cheapee/views/ui/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ISignInPresenter {
  Future checkExists();
}

class SignInPresenter implements ISignInPresenter {
  SignInPresenter(ILoginScreen view) {
    _model = new LoginModel();
    _view = view;
  }

  LoginModel _model;
  ILoginScreen _view;

  @override
  Future checkExists() async {
    var email = FirebaseAuth.instance.currentUser?.email;
    if (email == null) {
      throw new Exception();
    }
    var result = await _model.isSignup(email);
    _view.setUserStatus(result);
  }
}
