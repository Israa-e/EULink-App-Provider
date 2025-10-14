//  Label StoreMax
//
//  Created by Anthony Gordon.
//  2022, WooSignal Ltd. All rights reserved.
//

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/utils/common.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CachedImageWidget extends StatelessWidget {
  const CachedImageWidget({
    Key? key,
    this.image,
    this.height = 70,
    this.width = 70,
    this.color = null,
    this.placeholder = const Center(
      child: CircularProgressIndicator(
          strokeWidth: 2,
          backgroundColor: Colors.transparent,
          color: Colors.transparent),
    ),
    this.fit = BoxFit.contain,
  }) : super(key: key);

  final String? image;
  final double height;
  final double width;
  final Widget placeholder;
  final BoxFit fit;
  final Color? color;

  @override
  Widget build(BuildContext context) => CachedNetworkImage(
        imageUrl: image.toString(),
        placeholderFadeInDuration: Duration(milliseconds: 0),
        fadeOutDuration: Duration(milliseconds: 0),
        fadeInDuration: Duration(milliseconds: 0),
        cacheKey: image.toString(),
        placeholder: (context, url) => placeholder,
        errorWidget: (context, url, error) => Image.asset(
          "assets/images/empty_image.png",
          fit: BoxFit.cover,
          height: height,
        ),
        height: height,
        width: width,

        alignment: Alignment.center,
        fit: fit,
        color: color,
      );
}
