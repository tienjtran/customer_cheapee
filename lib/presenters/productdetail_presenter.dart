import 'package:customer_cheapee/datasets/product_dataset.dart';
import 'package:customer_cheapee/inputs/productdetail_input.dart';
import 'package:customer_cheapee/viewmodels/productdetail_model.dart';
import 'package:customer_cheapee/views/models/output/productDetailModel.dart';

abstract class IProductDetailPresenter {
  void loadProductDetailScreen(int id);
}

class ProductDetailPresenter implements IProductDetailPresenter {
  ProductDetailViewModel _viewModel;

  ProductDetailPresenter() {
    this._viewModel = new ProductDetailViewModel();
  }

  @override
  Future<ProductDetailModel> loadProductDetailScreen(productInStoreId) async {
    ProductInStoreDataset result = await _viewModel
        .getProductDetail(new ProductDetailInput(id: productInStoreId));
    // * Convert to SearchResultOutputModel
    ProductDetailModel model = new ProductDetailModel(
      result.productInStoreId,
      result.product.name,
      result.product.imagePathid,
      result.salePrice,
      result.product.price,
      result.expireDate.toString(),
      result.product.manufacturerid,
      result.product.brandid,
      result.product.categoryid,
    );
    return model;
  }
}
