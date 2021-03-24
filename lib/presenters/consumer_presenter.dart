import 'package:customer_cheapee/datasets/consumer_dataset.dart';
import 'package:customer_cheapee/inputs/consumer_input.dart';
import 'package:customer_cheapee/viewmodels/consumer_model.dart';
import 'package:customer_cheapee/views/models/output/consumer.dart';

abstract class IConsumerPresenter {
  void loadConsumerInfo(String email);
}

class ConsumerPresenter implements IConsumerPresenter {
  ConsumerViewModel _viewModel;

  ConsumerPresenter() {
    this._viewModel = new ConsumerViewModel();
  }

  @override
  Future<ConsumerOutputModel> loadConsumerInfo(String email) async {
    ConsumerDataset result = await _viewModel
        .getConsumerInfo(new ConsumerLoadingInput(email: email));
    var model = new ConsumerOutputModel(
        result.email, result.name, result.phone, result.address);
    return model;
  }
}
