import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class CustomGrid extends StatelessWidget {
  final Widget Function(int index) card;
  final int count;
  CustomGrid({Key? key, required this.card, required this.count}) : super(key: key);

  bool isDesktop = GetPlatform.isDesktop;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return card(index);
          },
          childCount: count,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isDesktop ? 6 : 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 2.0,
        ),
      ),
    ]);
  }
}
