import 'package:customer_cheapee/datasets/home_view.dart';
import 'package:customer_cheapee/inputs/home_view.dart';
import 'package:customer_cheapee/viewmodels/home_model.dart';
import 'package:customer_cheapee/views/models/output/productDetailModel.dart';
import 'package:customer_cheapee/views/models/output/store.dart';
import 'package:customer_cheapee/views/ui/home.dart';
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
          unit.storeId,
          unit.storeName,
          await FirebaseUtils.getDownloadUrls(unit.imagePath),
          double.parse(unit.distance.toStringAsFixed(1)),
          unit.openTime,
          unit.closeTime, []);
      List<SuggestedProductModel> productList = [];
      for (var j = 0; j < result[i].productList.length; j++) {
        var p = result[i].productList[j];
        String image;
        await FirebaseUtils.getDownloadUrls(p.imagePath)
            .then((value) => image = value)
            .catchError((_) => {});
        DateTime now = new DateTime.now();

        int differenceDate = p.expireDate.difference(now).inDays;

        if (differenceDate <= 0) {
          continue;
        }
        var product = new SuggestedProductModel(
            p.productInStoreId,
            p.name,
            image,
            CommonUtils.decreaseHundredPercent(p.oldPrice, p.salePrice),
            'đ ' + p.salePrice.toStringAsFixed(0),
            'HSD còn ${differenceDate.toString()} ngày',
            1,
            true);
        productList.add(product);
      }
      model.productList = productList;
      listModel.add(model);
    }
    listModel.sort((a, b) => a.distance.compareTo(b.distance));
    view.initHomeScreen(listModel);
  }
}
