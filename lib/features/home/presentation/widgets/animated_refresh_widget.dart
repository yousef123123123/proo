
import 'package:flutter/material.dart';

class AnimatedRefreshWidget extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final List<Widget> children;

  const AnimatedRefreshWidget({
    super.key,
    required this.onRefresh,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      displacement: 80,
      edgeOffset: 40,
      color: Colors.deepPurple,
      backgroundColor: Colors.white,
      strokeWidth: 3.0,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [SliverList(delegate: SliverChildListDelegate(children))],
      ),
    );
  }
}
