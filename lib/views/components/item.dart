import 'package:flutter/material.dart';

import '../../models/data_model.dart';
import '../../utils/constant/string_constants.dart';
import 'item_image.dart';

class Item extends StatelessWidget {
  const Item({Key? key, required this.element}) : super(key: key);

  final DataItem element;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            element.images == null ? const Text(StringConstants.nullImageErrorMessage) : ItemImage(imageUrl: element.images!),
            Text('Title: ${element.title}'),
            Text('Description: ${element.description}'),
          ],
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
