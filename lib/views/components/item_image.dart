import 'package:flutter/material.dart';

import '../../utils/constant/string_constants.dart';

class ItemImage extends StatelessWidget {
  const ItemImage({Key? key, required this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(border: Border.all()),
      alignment: Alignment.center,
      child: Image.network(
        imageUrl,
        errorBuilder: (context, object, stackTrace) {
          return const Text(StringConstants.wrongImageUrlMessage);
        },
      ),
    );
  }
}
