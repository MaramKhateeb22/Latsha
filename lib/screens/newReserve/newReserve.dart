import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class NewReserve extends StatefulWidget {
  const NewReserve({super.key});

  @override
  State<NewReserve> createState() => _NewReserveState();
}

class _NewReserveState extends State<NewReserve> {
  List<Marker> markerss = [];
  void _addMarker(LatLng point) {
    setState(() {
      markerss.clear();
      markerss.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: point,
          child: const Icon(Icons.location_pin, color: Colors.red),
        ),
      );
    });

    // هنا يمكنك إضافة التعليمات البرمجية لحفظ النقطة في Firebase
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: const LatLng(
              35.0, 38.0), // تحدد إحداثيات مركز الخريطة لسوريا على سبيل المثال
          initialZoom: 6.0,
          onTap: (tapPosition, point) {
            _addMarker(point);
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(markers: markerss),
        ],
      ),
    );
  }
}
