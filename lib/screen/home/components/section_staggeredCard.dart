import 'package:controlsport_app_ecommerce/models/home/home_manager.dart';
import 'package:controlsport_app_ecommerce/models/section/section.dart';
import 'package:controlsport_app_ecommerce/screen/home/components/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import 'add_tile_widget.dart';
import 'item_tile.dart';

class SectionStaggeredCard extends StatelessWidget {
  const SectionStaggeredCard(this.section);

  final Section section;

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();

    return ChangeNotifierProvider.value(
      value: section,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SectionHeader(),
            Consumer<Section>(
              builder: (_, section, __) {
                return StaggeredGridView.countBuilder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  itemCount: homeManager.editing
                      ? section.items.length + 1
                      : section.items.length,
                  itemBuilder: (_, index) {
                    if (index < section.items.length)
                      return ItemTile(section.items[index]);
                    else
                      return AddTileWidget();
                  },
                  staggeredTileBuilder: (index) => StaggeredTile.count(2, 2),
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
