import 'package:flutter/material.dart';
import '../widgets/outstanding_grid.dart';
import 'package:provider/provider.dart';
import '../providers/sites_provider.dart';
import '../providers/site.dart';

class OutstandingPlacesScreen extends StatefulWidget {
  @override
  State<OutstandingPlacesScreen> createState() =>
      _OutstandingPlacesScreenState();
}

class _OutstandingPlacesScreenState extends State<OutstandingPlacesScreen> {
  List<Site> randomSites = [];
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() async{
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Sites>(context).fetchAndSetSites().then((_) {
        _isLoading = false;
      });
      randomSites = await Provider.of<Sites>(context, listen: false).randomList;
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _getRandomItems() async {
      randomSites = await Provider.of<Sites>(context, listen: false).randomList;
      setState(() {});
    }

    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Te podría interesar',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: const Text(
                        'Los mejores lugares para explorar',
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                    const Divider(
                      color: Colors.black87,
                    ),
                    Expanded(
                        child: RefreshIndicator(
                            onRefresh: _getRandomItems,
                            child: OutstandingGrid(randomSites))),
                  ],
                ),
              ),
      ),
    );
  }
}
