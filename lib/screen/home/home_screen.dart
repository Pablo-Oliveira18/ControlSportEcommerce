import 'package:controlsport_app_ecommerce/common/custom_drawer/custom_drawer.dart';
import 'package:controlsport_app_ecommerce/models/home/home_manager.dart';
import 'package:controlsport_app_ecommerce/models/usuarios/user_manager.dart';
import 'package:controlsport_app_ecommerce/screen/home/components/section_staggered.dart';
import 'package:controlsport_app_ecommerce/screen/home/components/section_staggeredCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/add_section_widget.dart';
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
                  Consumer2<UserManager, HomeManager>(
                    builder: (_, userManager, homeManager, __) {
                      if (userManager.adminEnabled && !homeManager.loading) {
                        if (homeManager.editing) {
                          return PopupMenuButton(
                            color: Theme.of(context).primaryColor,
                            icon: Icon(
                              Icons.subject_sharp,
                              color: Colors.white,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.white)),
                            onSelected: (e) {
                              if (e == 'Aplicar') {
                                homeManager.saveEditing();
                              } else {
                                homeManager.discardEditing();
                              }
                            },
                            itemBuilder: (_) {
                              return ['Aplicar', 'Descartar'].map((e) {
                                return PopupMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }).toList();
                            },
                          );
                        } else {
                          return IconButton(
                            icon: Icon(Icons.edit),
                            color: Colors.white,
                            onPressed: homeManager.enterEditing,
                          );
                        }
                      } else
                        return Container();
                    },
                  ),
                ],
              ),
              Consumer<HomeManager>(
                builder: (_, homeManager, __) {
                  if (homeManager.loading) {
                    return SliverToBoxAdapter(
                      child: LinearProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                        backgroundColor: Colors.transparent,
                      ),
                    );
                  }
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
                  if (homeManager.editing)
                    children.add(AddSectionWidget(homeManager));
                  return SliverList(
                    delegate: SliverChildListDelegate(children),
                  );
                },
              )
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        foregroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).pushNamed('/cart');
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        child: Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      ),
    );
  }
}
