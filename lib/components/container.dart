import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

Widget defaultContainer({required List<Widget> child}) {
  return Scrollable(
    viewportBuilder: (BuildContext context, ViewportOffset position) {
      return Viewport(
        anchor: 0.0,
        cacheExtent: 0.1,
        cacheExtentStyle: CacheExtentStyle.viewport,
        offset: position,
        slivers: [SliverList(delegate: SliverChildListDelegate(child))],
      );
    },
  );
}
