import 'package:controlsport_app_ecommerce/models/section/section.dart';
import 'package:controlsport_app_ecommerce/screen/home/components/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'item_tile.dart';

class SectionStaggeredCard extends StatelessWidget {
  const SectionStaggeredCard(this.section);

  final Section section;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeader(section),
          StaggeredGridView.countBuilder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            crossAxisCount: 4,
            itemCount: section.items.length,
            itemBuilder: (_, index) {
              return Card(
                color: Colors.amber[200],
                child: ItemTile(section.items[index]),
              );
            },
            staggeredTileBuilder: (index) => StaggeredTile.count(2, 2),
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
          ),
        ],
      ),
    );
  }
}
