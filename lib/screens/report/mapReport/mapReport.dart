import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart'; // إضافة الحزمة الجديدة هنا
import 'package:latlong2/latlong.dart';
import 'package:mopidati/screens/report/newReportScreen.dart';
import 'package:mopidati/widgets/message.dart';
import 'package:mopidati/widgets/my_button_widget.dart';

class MapReport extends StatefulWidget {
  const MapReport({super.key});

  // const MapReport({super.key});
  // const MapReport({super.key, required this.selectedPoint});
  // final LatLng selectedPoint;

  @override
  State<MapReport> createState() => _MapReportState();
}

class _MapReportState extends State<MapReport> {
  final MapController _mapController = MapController();
  List<Marker> markerss = [];
  LatLng? _selectedPoint; // متغير لحفظ النقطة المختارة
  void _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // تحقق مما إذا كانت خدمات الموقع مفعلة
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('خدمات الموقع معطلة');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('أذونات الموقع مرفوضة');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // أذونات الموقع مرفوضة بشكل دائم
      return Future.error(
          'أذونات الموقع مرفوضة بشكل دائم, نحن لا نستطيع طلب الأذونات.');
    }

    // عندما تمت الموافقة على الأذونات: احصل على الموقع الحالي
    Position position = await Geolocator.getCurrentPosition();
    final userLocation = LatLng(position.latitude, position.longitude);
    _mapController.move(userLocation, 15.0); // يمكنك تعديل مستوى التكبير
    final marker = Marker(
      width: 120.0,
      height: 120.0,
      point: userLocation,
      child: const Column(
        children: [
          Text('مكانك حاليا'),
          Icon(
            Icons.location_on,
            size: 30.0,
            color: Color.fromARGB(255, 73, 54, 244),
          ),
        ],
      ),
    );

    setState(() {
      markerss.add(marker);
    });
  }

  void _addMarker(LatLng point) {
    setState(() {
      markerss.clear();
      markerss.add(
        Marker(
          width: 100.0,
          height: 100.0,
          point: point,
          child: const Icon(Icons.location_pin, color: Colors.red),
        ),
      );
      _selectedPoint = point; // حفظ النقطة المختارة في المتغير
    });

    // هنا يمكنك إضافة التعليمات البرمجية لحفظ النقطة في Firebase
  }

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مكان المنتشرة الحشرة فيه للإبلاغ'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: const LatLng(35.0,
                    38.0), // تحدد إحداثيات مركز الخريطة لسوريا على سبيل المثال
                initialZoom: 6.0,
                onTap: (tapPosition, point) {
                  _addMarker(point);
                  print(point);
                },
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(markers: markerss),
              ],
            ),
          ),
          ButtonWidget(
              child: const Text('التالي'),
              onPressed: () {
                if (_selectedPoint != null) {
                  // تأكد من أن هناك نقطة مختارة
                  Navigator.pop(context, _selectedPoint);
                  print(_selectedPoint);

                  // Navigator.pop(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         const NewReportScreen(), // يجب أن تستبدل هذا بالصفحة الهدف الفعلية
                  //     settings: RouteSettings(arguments: _selectedPoint),
                  // ),
                  // );
                } else {
                  // يمكنك إضافة تعليق للمستخدم ليختار نقطة إذا لم يكن قد اختار واحدة بعد
                  print("يرجى اختيار نقطة على الخريطة أولاً.");
                  message(context,
                      'يرجى اختيار نقطة انتشار الحشرة  على الخريطة أولاً');
                }
              }),
        ],
      ),
    );
  }
}
