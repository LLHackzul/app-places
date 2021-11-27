import 'package:flutter/material.dart';
import '../widgets/places_grid.dart';
import 'package:provider/provider.dart';
import '../providers/places_provider.dart';
import '../providers/sites_provider.dart';

class PlacesScreen extends StatefulWidget {
  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Places>(context).fetchAndSetPlaces();
      Provider.of<Sites>(context).fetchAndSetSites().then((_) {
        _isLoading = false;
      });
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HeaderWidget(),
            Expanded(
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : PlacesGrid())
          ],
        ),
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/img/QuetzalLogo.png',
                fit: BoxFit.cover,
                height: 50,
              ),
              SizedBox(
                width: 5,
              ),
              const Text(
                'Departamentos',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ],
          ),
          Divider(
            color: Colors.black87,
          ),
        ],
      ),
    );
  }
}
