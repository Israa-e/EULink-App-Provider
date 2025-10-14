//  Label StoreMax
//
//  Created by Anthony Gordon.
//  2022, WooSignal Ltd. All rights reserved.
//

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CachedAvatarWidget extends StatelessWidget {

  const CachedAvatarWidget({
    Key? key,
    this.image,
    this.height = 70,
    this.width = 70,
    this.color = null,
    this.placeholder = const Center(
      child: CircularProgressIndicator(
          strokeWidth: 2,
          backgroundColor: Colors.black12,
          color: Colors.black54),
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
  Widget build(BuildContext context) {
    Random rnd;
    int min = 1;
    int max = 4;
    rnd = new Random();
   int  r =1;
    return   CachedNetworkImage(
      imageUrl: image.toString(),
      placeholder: (context, url) => placeholder,
      errorWidget: (context, url, error) => Image.asset("assets/icons/avatar.png",fit: BoxFit.cover, height: height,
        width: width,)  ,
      height: height,
      width: width,
      alignment: Alignment.center,
      fit: fit,

    );
  }
}
