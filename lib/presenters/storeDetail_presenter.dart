import 'package:customer_cheapee/datasets/storeDetail_dataset.dart';
import 'package:customer_cheapee/inputs/storeDetail_input.dart';
import 'package:customer_cheapee/viewmodels/storeDetail_model.dart';
import 'package:customer_cheapee/views/models/output/productDetailModel.dart';
import 'package:customer_cheapee/views/models/output/store.dart';
import 'package:customer_cheapee/views/ui/storeDetail.dart';
import 'package:customer_cheapee/views/utils/common.dart';

abstract class IStoreDetailPresenter {
  void loadStoreDetailScreen(
      int storeId, double longitude, double latitude, double distance);
}

class StoreDetailPresenter implements IStoreDetailPresenter {
  StoreDetailViewModel _viewModel;

  StoreDetailPresenter() {
    this._viewModel = new StoreDetailViewModel();
  }
  @override
  Future<NearStoreOutputModel> loadStoreDetailScreen(
      int storeId, double latitude, double longitude, double distance) async {
    List<StoreDetailDataset> result = await _viewModel.getStoreDetail(
      new StoreDetailScreenLoadingInput(
          storeId: storeId,
          latitude: latitude,
          longitude: longitude,
          distance: distance),
    );
    NearStoreOutputModel model;
    for (var i = 0; i < result.length; i++) {
      var unit = result[i];
      if (unit.storeId == storeId) {
        List<SuggestedProductModel> productList = [];
        model = new NearStoreOutputModel(
            unit.storeId,
            unit.storeName,
            await FirebaseUtils.getDownloadUrls(unit.imagePath),
            double.parse(unit.distance.toStringAsFixed(1)),
            unit.openTime,
            unit.closeTime, []);
        for (var j = 0; j < unit.productList.length; j++) {
          var p = unit.productList[j];
          var product = new SuggestedProductModel(
              p.productInStoreId,
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
        return model;
      }
    }
    //view.initStoreDetailScreen(model);
  }
}
