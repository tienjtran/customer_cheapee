import 'package:customer_cheapee/datasets/product_dataset.dart';
import 'package:customer_cheapee/inputs/productdetail_input.dart';
import 'package:customer_cheapee/viewmodels/productdetail_model.dart';
import 'package:customer_cheapee/views/models/output/productDetailModel.dart';
import 'package:customer_cheapee/views/utils/common.dart';

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
    // * get PIS dataset
    ProductInStoreDataset result = await _viewModel
        .getProductDetail(new ProductDetailInput(id: productInStoreId));
    // * get brand dataset
    BrandDataset brandDataset =
        await _viewModel.getBrand(result.product.brandid);
    // * get manufacturer dataset
    ManufacturerDataset manufacturerDataset =
        await _viewModel.getManufacturer(result.product.manufacturerid);
    // * get photo dataset
    PhotoDataset photoDataset =
        await _viewModel.getPhoto(result.product.imagePathid);
    // * Convert to SearchResultOutputModel
    ProductDetailModel model = new ProductDetailModel(
      result.productInStoreId,
      result.product.name,
      await FirebaseUtils.getDownloadUrls(photoDataset.url), //Photo path
      result.salePrice,
      result.product.price,
      result.expireDate.toString(),
      result.description,
      manufacturerDataset.fullname,
      brandDataset.name, // Brand name
      result.product.categoryid,
    );
    return model;
  }
}
