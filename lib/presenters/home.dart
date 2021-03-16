import 'package:customer_cheapee/datasets/home_view.dart';
import 'package:customer_cheapee/inputs/home_view.dart';
import 'package:customer_cheapee/viewmodels/home_model.dart';
import 'package:customer_cheapee/views/models/output/productDetailModel.dart';
import 'package:customer_cheapee/views/models/output/store.dart';
import 'package:customer_cheapee/views/ui/home.dart';
import 'package:customer_cheapee/views/utils/common.dart';
import 'package:customer_cheapee/views/utils/common.dart';

abstract class IHomePresenter {
  void loadHomeScreen(double longitude, double latitude, double distance);
}

class HomePresenter implements IHomePresenter {
  HomeViewModel _viewModel;
  HomeView view;

  HomePresenter() {
    this._viewModel = new HomeViewModel();
  }

  @override
  void loadHomeScreen(
      double latitude, double longitude, double distance) async {
    List<ProductInNearStoreDataset> result = await _viewModel.fetchNearStore(
      new HomeScreenLoadingInput(
          latitude: latitude, longitude: longitude, distance: distance),
    );
    List<NearStoreOutputModel> listModel = [];
    for (var i = 0; i < result.length; i++) {
      var unit = result[i];
      var model = new NearStoreOutputModel(
          unit.storeName,
          await FirebaseUtils.getDownloadUrls(unit.imagePath),
          double.parse(unit.distance.toStringAsFixed(1)),
          unit.openTime,
          unit.closeTime, []);
      List<SuggestedProductModel> productList = [];
      for (var j = 0; j < result[i].productList.length; j++) {
        var p = result[i].productList[j];
        var product = new SuggestedProductModel(
            p.name,
            await FirebaseUtils.getDownloadUrls(p.imagePath),
            CommonUtils.decreaseHundredPercent(p.oldPrice, p.salePrice),
            'đ ' + p.salePrice.toStringAsFixed(0),
            'HSD còn ${p.expireDate.difference(p.manufactureDate).inDays.toString()} ngày',
            1,
            true);
        productList.add(product);
      }
      model.productList = productList;
      listModel.add(model);
    }
    view.initHomeScreen(listModel);
  }
}
