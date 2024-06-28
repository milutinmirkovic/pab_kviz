import 'package:flutter/material.dart';
import 'package:pab_kviz/services/lokacija_service.dart';
import 'package:pab_kviz/models/lokacija.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final LokacijaService _lokacijaService = LokacijaService();
  late Future<List<Lokacija>> _locations;

  @override
  void initState() {
    super.initState();
    _locations = _lokacijaService.getLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lokacije'),
      ),
      body: FutureBuilder<List<Lokacija>>(
        future: _locations,
        builder: (context, snapshot) {
          print('Connection state: ${snapshot.connectionState}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No locations found'));
          } else {
            List<Lokacija>? locations = snapshot.data;
            return ListView.builder(
              itemCount: locations?.length ?? 0,
              itemBuilder: (context, index) {
                Lokacija lokacija = locations![index];
                return ListTile(
                  title: Text(lokacija.naziv),
                  subtitle: Text('${lokacija.adresa}, Kapacitet: ${lokacija.kapacitet}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      if (lokacija.id != null) {
                        _lokacijaService.deleteLokacija(lokacija.id!).then((_) {
                          setState(() {
                            _locations = _lokacijaService.getLocations();
                          });
                        });
                      } else {
                        print('Lokacija ID is null');
                      }
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
