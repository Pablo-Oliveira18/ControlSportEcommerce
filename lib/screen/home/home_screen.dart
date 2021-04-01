import 'package:controlsport_app_ecommerce/common/custom_drawer/custom_drawer.dart';
import 'package:controlsport_app_ecommerce/models/home/home_manager.dart';
import 'package:controlsport_app_ecommerce/screen/home/components/section_staggered.dart';
import 'package:controlsport_app_ecommerce/screen/home/components/section_staggeredCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/section_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: const [
              Color.fromARGB(255, 218, 165, 32),
              Color.fromARGB(255, 219, 165, 32)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                snap: true,
                floating: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text('Control Sport\'s'),
                  centerTitle: true,
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    color: Colors.white,
                    onPressed: () => Navigator.of(context).pushNamed('/cart'),
                  ),
                ],
              ),
              Consumer<HomeManager>(
                builder: (_, homeManager, __) {
                  final List<Widget> children =
                      homeManager.sections.map<Widget>((section) {
                    switch (section.type) {
                      case 'List':
                        return SectionList(section);
                      case 'Staggered':
                        return SectionStaggered(section);
                      case 'StaggeredCard':
                        return SectionStaggeredCard(section);
                      default:
                        return Container();
                    }
                  }).toList();

                  return SliverList(
                    delegate: SliverChildListDelegate(children),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
