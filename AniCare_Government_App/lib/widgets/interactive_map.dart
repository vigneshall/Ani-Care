import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../theme/app_theme.dart';

class HotspotData {
  final LatLng location;
  final int count;
  final String type;
  final Color color;

  HotspotData(this.location, this.count, this.type, this.color);
}

class InteractiveMap extends StatefulWidget {
  const InteractiveMap({super.key});

  @override
  State<InteractiveMap> createState() => _InteractiveMapState();
}

class _InteractiveMapState extends State<InteractiveMap> {
  final MapController _mapController = MapController();

  final List<HotspotData> _hotspots = [
    HotspotData(const LatLng(28.6139, 77.2090), 24, 'Accidents', AppTheme.emergencyRed),
    HotspotData(const LatLng(28.6200, 77.2150), 15, 'Disease Cluster', AppTheme.warningOrange),
    HotspotData(const LatLng(28.6100, 77.2200), 8, 'Construction Zone', AppTheme.textGrey),
    HotspotData(const LatLng(28.6250, 77.2050), 32, 'Accidents', AppTheme.emergencyRed),
    HotspotData(const LatLng(28.6050, 77.2100), 12, 'Disease Cluster', AppTheme.warningOrange),
  ];

  List<CircleMarker> _buildCircles() {
    return _hotspots.map((hotspot) {
      double radius = 50 + (hotspot.count * 3);
      return CircleMarker(
        point: hotspot.location,
        radius: radius,
        color: hotspot.color.withOpacity(0.3),
        borderColor: hotspot.color,
        borderStrokeWidth: 2,
      );
    }).toList();
  }

  List<Marker> _buildMarkers() {
    return _hotspots.map((hotspot) {
      return Marker(
        point: hotspot.location,
        width: 60,
        height: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: hotspot.color,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
              ),
              child: Text(
                '${hotspot.count}',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              hotspot.type.split(' ')[0],
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: hotspot.color, shadows: [const Shadow(color: Colors.white, blurRadius: 2)]),
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: const MapOptions(
            initialCenter: LatLng(28.6139, 77.2090),
            initialZoom: 12.0,
            minZoom: 5.0,
            maxZoom: 18.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.anicare.governmentapp',
            ),
            CircleLayer(circles: _buildCircles()),
            MarkerLayer(markers: _buildMarkers()),
          ],
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [const BoxShadow(color: Colors.black26, blurRadius: 4)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildLegend(AppTheme.emergencyRed, 'Accidents'),
                _buildLegend(AppTheme.warningOrange, 'Disease'),
                _buildLegend(AppTheme.textGrey, 'Construction'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLegend(Color color, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}
