import 'package:customer_cheapee/datasets/search_dataset.dart';
import 'package:customer_cheapee/inputs/search_input.dart';
import 'package:customer_cheapee/viewmodels/search_model.dart';
import 'package:customer_cheapee/views/models/output/search.dart';
import 'package:customer_cheapee/views/utils/common.dart';

abstract class ISearchPresenter {
  void loadSearchScreen(
      double longitude, double latitude, double distance, String name);
  void loadSearchByCategoryScreen(
      double longitude, double latitude, double distance, String name);
}

class SearchPresenter implements ISearchPresenter {
  SearchViewModel _viewModel;

  SearchPresenter() {
    this._viewModel = new SearchViewModel();
  }

  @override
  Future<List<SearchResultOutputModel>> loadSearchScreen(
      double latitude, double longitude, double distance, String name) async {
    List<SearchStoreDataset> result =
        await _viewModel.getNearItems(new SearchScreenLoadingInput(
      latitude: latitude,
      longitude: longitude,
      distance: distance,
      name: name,
    ));
    // * Convert to SearchResultOutputModel
    List<SearchResultOutputModel> listModel = [];
    for (var i = 0; i < result.length; i++) {
      var unit = result[i];
      var model = new SearchResultOutputModel(
          new SearchStore(
            unit.storeName,
            unit.openTime,
            unit.closeTime,
            double.parse(unit.distance.toStringAsFixed(1)),
            unit.stars,
            await FirebaseUtils.getDownloadUrls(unit.imagePath),
          ),
          []);
      // * init productList
      List<SearchItemModel> productList = [];
      for (var j = 0; j < result[i].productList.length; j++) {
        var p = result[i].productList[j];
        var product = new SearchItemModel(
          p.name,
          p.salePrice,
          // CommonUtils.decreaseHundredPercent(p.oldPrice, p.salePrice),
          await FirebaseUtils.getDownloadUrls(p.imagePath),
          // 'HSD còn ${p.expireDate.difference(p.manufactureDate).inDays.toString()} ngày',
        );
        productList.add(product);
      }
      model.itemList = productList;
      listModel.add(model);
    }
    listModel.sort((a, b) => a.store.distance.compareTo(b.store.distance));
    return listModel;
  }

  @override
  Future<List<SearchResultOutputModel>> loadSearchByCategoryScreen(
      double latitude,
      double longitude,
      double distance,
      String category) async {
    List<SearchStoreDataset> result =
        await _viewModel.getNearItemsByCategory(new SearchScreenLoadingInput(
      latitude: latitude,
      longitude: longitude,
      distance: distance,
      name: category,
    ));
    // * Convert to SearchResultOutputModel
    List<SearchResultOutputModel> listModel = [];
    for (var i = 0; i < result.length; i++) {
      var unit = result[i];
      var model = new SearchResultOutputModel(
          new SearchStore(
            unit.storeName,
            unit.openTime,
            unit.closeTime,
            double.parse(unit.distance.toStringAsFixed(1)),
            unit.stars,
            await FirebaseUtils.getDownloadUrls(unit.imagePath),
          ),
          []);
      // * init productList
      List<SearchItemModel> productList = [];
      for (var j = 0; j < result[i].productList.length; j++) {
        var p = result[i].productList[j];
        var product = new SearchItemModel(
          p.name,
          p.salePrice,
          // CommonUtils.decreaseHundredPercent(p.oldPrice, p.salePrice),
          await FirebaseUtils.getDownloadUrls(p.imagePath),
          // 'HSD còn ${p.expireDate.difference(p.manufactureDate).inDays.toString()} ngày',
        );
        productList.add(product);
      }
      model.itemList = productList;
      listModel.add(model);
    }
    listModel.sort((a, b) => a.store.distance.compareTo(b.store.distance));
    return listModel;
  }
}
