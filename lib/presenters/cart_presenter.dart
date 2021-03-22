import 'package:customer_cheapee/viewmodels/cart_model.dart';
import 'package:customer_cheapee/views/models/output/cart.dart';
import 'package:customer_cheapee/views/ui/cart.dart';
import 'package:customer_cheapee/views/utils/common.dart';

abstract class ICartPresenter {
  Future<void> loadCart();
}

class CartPresenter implements ICartPresenter {
  ICartView _view;
  CartViewModel _viewModel;

  CartPresenter(this._view) {
    this._viewModel = new CartViewModel();
  }

  @override
  Future<void> loadCart() async {
    var loadTask = _viewModel.loadingCart();
    var loadDataset = await loadTask;
    var cartModel = new CartOutputModel(
        loadDataset.storeId, loadDataset.storeName, loadDataset.storeAddress);
    for (var i = 0; i < loadDataset.productList.length; i++) {
      var dataset = loadDataset.productList[i];
      var model = new CartItemOutputModel();
      await FirebaseUtils.getCartReference()
          .doc(dataset.productInStoreId.toString())
          .get()
          .then((value) => model.quantity = value.data()['quantity']);
      model.productId = dataset.productInStoreId;
      model.name = dataset.productName;
      model.oldPrice = dataset.oldPrice;
      model.currentPrice = dataset.salePrice;
      model.leftDays = dataset.leftDay;
      model.imagePath = await FirebaseUtils.getDownloadUrls(dataset.imagePath);
      cartModel.productList.add(model);
    }
    _view.loadingCart(cartModel);
  }
}
