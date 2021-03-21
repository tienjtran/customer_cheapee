import 'package:customer_cheapee/datasets/order_dataset.dart';
import 'package:customer_cheapee/datasets/productinstore_dataset.dart';
import 'package:customer_cheapee/datasets/store_dataset.dart';
import 'package:customer_cheapee/inputs/productdetail_input.dart';
import 'package:customer_cheapee/viewmodels/order_viewmodel.dart';
import 'package:customer_cheapee/viewmodels/productdetail_viewmodel.dart';
import 'package:customer_cheapee/viewmodels/store_viewmodel.dart';
import 'package:customer_cheapee/views/models/output/orderModel.dart';
import 'package:customer_cheapee/inputs/order_input.dart';
import 'package:customer_cheapee/views/models/output/product.dart';
import 'package:customer_cheapee/views/utils/common.dart';

abstract class IOrderPresenter {
  Future<List<OrderModel>> loadOrderScreen(String email);
}

class OrderPresenter implements IOrderPresenter {
  OrderViewModel _orderViewModel;
  StoreViewModel _storeViewModel;
  ProductDetailViewModel _productDetailViewModel;

  OrderPresenter() {
    this._orderViewModel = new OrderViewModel();
    this._storeViewModel = new StoreViewModel();
    this._productDetailViewModel = new ProductDetailViewModel();
  }

  @override
  Future<List<OrderModel>> loadOrderScreen(inputEmail) async {
    // * get PIS dataset
    List<OrderDataset> result = await _orderViewModel.getAllOrder(
        new OrderInput(email: inputEmail, pageNumber: 1, pageSize: 50));
    // * Convert to SearchResultOutputModel
    List<OrderModel> model = [];
    for (var i = 0; i < result.length; i++) {
      var orderModel = new OrderModel(
        result[i].orderId.toString(),
        (await _storeViewModel.getStore(result[i].storeId)).storeName,
        result[i].total,
        await FirebaseUtils.getDownloadUrls(
            (await _storeViewModel.getStore(result[i].storeId)).imagePath),
        await getProductModelList(
            await _orderViewModel.getListOrderDetail(result[i].orderId)),
        await getProductModelQuantityList(
            await _orderViewModel.getListOrderDetail(result[i].orderId)),
        result[i].orderDate,
        result[i].confirmedDate.isBefore(DateTime.utc(2, 1, 1, 0, 0, 0))
            ? null
            : result[i].confirmedDate,
        result[i].process,
      );
      model.add(orderModel);
    }
    return model;
  }

  Future<String> getImagePathThroughStore(int storeId) async {
    // * get store dataset
    StoreDataset storeDataset = await _storeViewModel.getStore(storeId);

    return storeDataset.imagePath;
  }

// * Product Model List
  Future<List<ProductModel>> getProductModelList(
      List<OrderDetailDataset> listOrderDetail) async {
    List<ProductInStoreDataset> pisList = [];
    List<ProductModel> result = [];
    for (var od in listOrderDetail) {
      pisList.add(await _productDetailViewModel
          .getProductDetail(new ProductDetailInput(id: od.productInStoreId)));
    }
    for (var pis in pisList) {
      result.add(new ProductModel(
        pis.product.id,
        pis.product.name,
        pis.product.price,
        pis.salePrice,
        pis.expireDate,
        await FirebaseUtils.getDownloadUrls(
            ((await _productDetailViewModel.getPhoto(pis.product.imagePathid))
                .url)),
      ));
    }
    return result;
  }

  // * Quantity List
  Future<List<int>> getProductModelQuantityList(
      List<OrderDetailDataset> listOrderDetail) async {
    List<int> result = [];
    for (var od in listOrderDetail) {
      result.add(od.quantity);
    }
    return result;
  }
}
