import 'package:flutter/material.dart';
import '../widgets/places_grid.dart';

class PlacesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HeaderWidget(),
            Expanded(child: PlacesGrid()),
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
          const Text(
            'Buscar y explorar',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Row(
            children: [
              const Icon(
                Icons.search,
                size: 30,
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Buscar lugares ',
                  ),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Porfavor ingrese un valor';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Departamentos',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ],
      ),
    );
  }
}
