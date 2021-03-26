import 'package:customer_cheapee/datasets/search_dataset.dart';
import 'package:customer_cheapee/inputs/search_input.dart';
import 'package:customer_cheapee/viewmodels/search_model.dart';
import 'package:customer_cheapee/views/models/output/search.dart';
import 'package:customer_cheapee/views/ui/search.dart';
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
            unit.storeId,
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
          p.productInStoreId,
          p.name,
          p.salePrice,
          // CommonUtils.decreaseHundredPercent(p.oldPrice, p.salePrice),
          await FirebaseUtils.getDownloadUrls(p.imagePath),
          unit.storeId,
          // 'HSD còn ${p.expireDate.difference(p.manufactureDate).inDays.toString()} ngày',
        );
        productList.add(product);
      }
      model.itemList = productList;
      listModel.add(model);
    }
    listModel.sort((a, b) => a.store.distance.compareTo(b.store.distance));
    // save result in history for next time serach
    FirebaseUtils.saveQuery(name).catchError((e) => {print(e)});
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
            unit.storeId,
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
          p.productInStoreId,
          p.name,
          p.salePrice,
          // CommonUtils.decreaseHundredPercent(p.oldPrice, p.salePrice),
          await FirebaseUtils.getDownloadUrls(p.imagePath),
          unit.storeId,
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

  Future<List<String>> loadSearhSuggestionOrHistory(String query) async {
    List<String> result;
    if (query.isEmpty) {
      await FirebaseUtils.getSearchHistory()
          .then((value) => result = value)
          .catchError((e) => print(e));
    } else {
      await _viewModel
          .getListSearch(query)
          .then((value) => result = value.take(10).toList())
          .catchError((e) => print(e));
    }
    return result;
  }
}
