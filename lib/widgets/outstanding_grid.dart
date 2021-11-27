import '../widgets/outstanding_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sites_provider.dart';
import '../providers/site.dart';
class OutstandingGrid extends StatelessWidget {
  List<Site> randomList;
  OutstandingGrid(this.randomList);
  @override
  Widget build(BuildContext context) {
    
    return GridView.builder(
      padding: const EdgeInsets.all(5),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 1,
        crossAxisSpacing: 5,
      ),
      itemBuilder: (ctx, i) => OutstandingItem(site: randomList[i],),
      itemCount: randomList.length,
    );
  }
}
