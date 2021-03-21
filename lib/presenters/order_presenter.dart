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

abstract class IOrderPresenter {
  Future<List<OrderModel>> loadOrderScreen(String email);
}

class OrderPresenter implements IOrderPresenter {
  OrderViewModel _orderViewModel;
  StoreViewModel _storeViewModel;
  ProductDetailViewModel _productDetailViewModel;

  OrderPresenter() {
    this._orderViewModel = new OrderViewModel();
  }

  @override
  Future<List<OrderModel>> loadOrderScreen(inputEmail) async {
    // * get PIS dataset
    List<OrderDataset> result =
        await _orderViewModel.getAllOrder(new OrderInput(email: inputEmail));
    // * Convert to SearchResultOutputModel
    List<OrderModel> model = [];
    for (var i = 0; i < result.length; i++) {
      var orderModel = new OrderModel(
        result[i].orderId.toString(), //TODO: fix
        result[i].storeId.toString(), //TODO: fix
        result[i].total,
        (await _storeViewModel.getStore(result[i].storeId)).imagePath,
        await getProductModelList(
            await _orderViewModel.getListOrderDetail(result[i].orderId)),
        await getProductModelQuantityList(
            await _orderViewModel.getListOrderDetail(result[i].orderId)),
        result[i].orderDate,
        result[i].confirmedDate,
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
      result.add(
        new ProductModel(
            pis.product.id,
            pis.product.name,
            pis.product.price,
            pis.salePrice,
            DateTime.now().difference(pis.expireDate).inDays,
            (await _productDetailViewModel.getPhoto(pis.product.imagePathid))
                .url),
      );
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
