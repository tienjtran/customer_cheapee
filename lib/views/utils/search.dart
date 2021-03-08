import 'package:customer_cheapee/views/models/output/search.dart';
import 'package:customer_cheapee/views/utils/common.dart';
import 'package:customer_cheapee/views/utils/constants.dart';
import 'package:flutter/material.dart';

class SearchResultItemWidget extends StatefulWidget {
  SearchResultOutputModel _model;

  SearchResultItemWidget(SearchResultOutputModel model) {
    this._model = model;
  }

  @override
  _SearchResultItemWidgetState createState() => _SearchResultItemWidgetState();
}

class _SearchResultItemWidgetState extends State<SearchResultItemWidget> {
  double _contextHeight;
  double _contextWidth;

  void _onPressedFavoritedIcon() {
    setState(() {
      this.widget._model.isLike = !this.widget._model.isLike;
    });
  }

  @override
  Widget build(BuildContext context) {
    _contextHeight = MediaQuery.of(context).size.height;
    _contextWidth = MediaQuery.of(context).size.width;
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(18),
        child: Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    this.widget._model.imagePath,
                    height: 90,
                    width: 90,
                  ),
                ),
                Container(
                  child: Center(
                    child: IconButton(
                      padding: EdgeInsets.all(0),
                      icon: Icon(
                          (this.widget._model.isLike)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: AppColors.red,
                          size: 18),
                      onPressed: _onPressedFavoritedIcon,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  width: 25,
                  height: 25,
                ),
              ],
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  this.widget._model.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppFontSizes.largeSize),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(this.widget._model.category),
                Row(
                  children: [
                    Icon(
                      Icons.history,
                      size: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Còn ${this.widget._model.daysLeft} ngày'),
                  ],
                ),
                SizedBox(
                  height: 13,
                ),
                Row(
                  children: [
                    Text(
                      CommonUtils.convertDoubleToMoney(
                          this.widget._model.currentPrice),
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      CommonUtils.convertDoubleToMoney(
                          this.widget._model.oldPrice),
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: AppColors.strongGrey,
                          fontSize: AppFontSizes.mediumSize),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          NamedRoutes.productDetailRoute,
        );
      },
    );
  }
}
