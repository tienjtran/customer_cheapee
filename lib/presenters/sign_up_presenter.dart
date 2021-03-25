import 'package:customer_cheapee/inputs/sign_up_input.dart';
import 'package:customer_cheapee/viewmodels/signup_model.dart';
import 'package:customer_cheapee/views/ui/signup.dart';

abstract class ISignUpPresenter {
  Future signUp(SignUpInput input);
}

class SignUpPresenter implements ISignUpPresenter {
  SignupModel _model;
  ISignUpView _view;

  SignUpPresenter(ISignUpView view) {
    _model = new SignupModel();
    _view = view;
  }

  @override
  Future signUp(SignUpInput input) async {
    var result = await _model.signUp(input);
    if (result) {
      _view.signUp(result);
    }
  }
}
