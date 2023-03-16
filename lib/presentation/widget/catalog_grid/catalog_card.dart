import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/product_model.dart';
import '../rate.dart';

class CatalogCard extends StatelessWidget {
  final ProductModel productModel;
  final bool didFavorite;
  final Function(int itemId) onFavoriteClicked;

  const CatalogCard(
      {Key? key,
      required this.productModel,
      required this.didFavorite,
      required this.onFavoriteClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardRadius = Theme.of(context).cardTheme.shape;
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
        return Column(
          children: [
            Expanded(
              child: SizedBox(
                height: constraints.maxHeight / 2,
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: productModel.image,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                            )),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.image),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: constraints.maxWidth / 0.5 , child: Text(productModel.title, style: Theme.of(context).textTheme.titleMedium, overflow: TextOverflow.fade, maxLines: 1,softWrap: false,)),
                RateWidget(
                  rate: productModel.rating.rate.toInt(),
                  width: constraints.maxWidth / 4,
                  height: 10,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("\$ 75.000"),
                  GestureDetector(
                    onTap: () => onFavoriteClicked.call(productModel.id),
                    child: Icon(
                      didFavorite
                          ? Icons.favorite_outlined
                          : Icons.favorite_border,
                      size: 18,
                      color: didFavorite
                          ? Theme.of(context).colorScheme.error
                          : Colors.black,
                    ),
                  )
                ],
              ),
            )
          ],
        );
      }),
    ));
  }
}
