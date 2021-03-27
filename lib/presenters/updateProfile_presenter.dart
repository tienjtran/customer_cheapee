import 'package:customer_cheapee/inputs/profile.dart';
import 'package:customer_cheapee/viewmodels/updateProfile_model.dart';
import 'package:customer_cheapee/views/ui/viewprofile.dart';

abstract class IUpdateProfilePresenter {
  Future updateProfile(ProfileUpdate input);
}

class UpdateProfilePresenter implements IUpdateProfilePresenter {
  UpdateProfileModel _model;
  IUpdateView _view;

  UpdateProfilePresenter(IUpdateView view) {
    _model = new UpdateProfileModel();
    _view = view;
  }

  @override
  Future updateProfile(ProfileUpdate input) async {
    var result = await _model.update(input);
    if (result) {
      _view.update(result);
    }
  }
}
