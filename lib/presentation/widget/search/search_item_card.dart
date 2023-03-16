

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_1/models/product_model.dart';

import '../rate.dart';

class SearchItemCard extends StatelessWidget {
  final ProductModel productModel;
  final bool didFavorite;
  final Function(int itemId) onFavoriteClicked;
  const SearchItemCard({Key? key, required this.productModel, required this.didFavorite, required this.onFavoriteClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LayoutBuilder(
            builder: (context, BoxConstraints constraints) {
              return SizedBox(
                width: constraints.maxWidth,
                child: Row(
                  children: [
                     SizedBox(
                      height: 80,
                      width: 80,
                      child: ClipRRect(
                        // borderRadius: BorderRadius.only(topLeft: Radius.circular(11), topRight: Radius.circular(11)),
                        child: CachedNetworkImage(
                          imageUrl: productModel.image,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              SizedBox(width: 50, height: 50, child: CircularProgressIndicator(value: downloadProgress.progress,)),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: constraints.maxWidth / 1.4 , child: Text(productModel.title, style: Theme.of(context).textTheme.titleSmall, overflow: TextOverflow.fade, maxLines: 1,softWrap: false,)),
                          RateWidget(rate: productModel.rating.rate.toInt(), width: 50, height: 10,),
                          const Spacer(),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text("\$ 75.000"),
                                GestureDetector(
                                  onTap: ()=> onFavoriteClicked.call(productModel.id),
                                  child: Icon(didFavorite? Icons.favorite : Icons.favorite_border, size: 18, color: didFavorite? Theme.of(context).colorScheme.error  :  Colors.black,),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
