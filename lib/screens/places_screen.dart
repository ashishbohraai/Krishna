import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class _Place {
  final String region;
  final String name;
  final String subtitle;
  final String query;
  const _Place(this.region, this.name, this.subtitle, this.query);
}

// The last value of each place is what Google Maps searches for.
// You can change any of them to a different temple or town.
const _places = [
  _Place(
    'Uttar Pradesh',
    'Mathura',
    'Birthplace of Shri Krishna',
    'Shri Krishna Janmabhoomi Temple, Mathura',
  ),
  _Place(
    'Uttar Pradesh',
    'Gokul',
    'Childhood home with Nanda and Yashoda',
    'Nand Bhavan, Gokul, Uttar Pradesh',
  ),
  _Place(
    'Uttar Pradesh',
    'Vrindavan',
    'Land of the flute and the Rasa Lila',
    'Banke Bihari Temple, Vrindavan',
  ),
  _Place(
    'Gujarat',
    'Dwarka',
    "Krishna's kingdom by the sea",
    'Dwarkadhish Temple, Dwarka, Gujarat',
  ),
  _Place(
    'Haryana',
    'Kurukshetra',
    'Where the Gita was spoken',
    'Jyotisar, Kurukshetra, Haryana',
  ),
];

class PlacesScreen extends StatelessWidget {
  const PlacesScreen({super.key});

  Future<void> _openUri(BuildContext context, Uri uri) async {
    var opened = false;
    try {
      opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {}
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Could not open Maps. Please check that Google Maps or a browser is installed.',
          ),
        ),
      );
    }
  }

  void _openPlace(BuildContext context, _Place p) {
    _openUri(
      context,
      Uri.https('www.google.com', '/maps/search/', {
        'api': '1',
        'query': p.query,
      }),
    );
  }

  void _openRoute(BuildContext context) {
    _openUri(
      context,
      Uri.https('www.google.com', '/maps/dir/', {
        'api': '1',
        'origin': 'Mathura, Uttar Pradesh',
        'destination': 'Dwarka, Gujarat',
        'travelmode': 'driving',
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
        title: const Text('Sacred Places'),
        actions: [
          IconButton(
            tooltip: 'Home',
            icon: const Icon(Icons.home_outlined),
            onPressed: () =>
                Navigator.of(context).popUntil((route) => route.isFirst),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              'In the footsteps of Shri Krishna',
              style: TextStyle(fontSize: 13, color: AppColors.muted),
            ),
          ),
          _mapCard(context),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pilgrimage sites',
                style: headingStyle(18, color: AppColors.gold),
              ),
              const Text(
                'Tap to open in Maps',
                style: TextStyle(fontSize: 13, color: AppColors.muted),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final p in _places)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _row(context, p),
            ),
        ],
      ),
    );
  }

  Widget _mapCard(BuildContext context) {
    return Container(
      height: 210,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.border),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.navy, Color(0xFF0E4A58)],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _MapPainter())),
          const Positioned(
            left: 14,
            bottom: 12,
            child: Text(
              'Illustrative map',
              style: TextStyle(fontSize: 12, color: AppColors.muted),
            ),
          ),
          Positioned(
            right: 12,
            bottom: 12,
            child: FilledButton(
              onPressed: () => _openRoute(context),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: AppColors.background,
                minimumSize: const Size(0, 44),
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: const Text('Open in Maps'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(BuildContext context, _Place p) {
    return Material(
      color: AppColors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _openPlace(context, p),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.background,
                  border: Border.all(color: AppColors.gold),
                ),
                child: const Icon(Icons.place, size: 22, color: AppColors.gold),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p.region.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 12,
                        letterSpacing: 1.2,
                        color: AppColors.gold,
                      ),
                    ),
                    Text(
                      p.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      p.subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.muted,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.open_in_new, size: 20, color: AppColors.muted),
            ],
          ),
        ),
      ),
    );
  }
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final sx = size.width / 350;
    final sy = size.height / 210;
    Offset p(double x, double y) => Offset(x * sx, y * sy);

    final contour = Paint()
      ..color = AppColors.border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (final y in [60.0, 110.0, 160.0]) {
      final path = Path()
        ..moveTo(0, y * sy)
        ..quadraticBezierTo(90 * sx, (y - 30) * sy, 170 * sx, y * sy)
        ..quadraticBezierTo(260 * sx, (y + 30) * sy, 350 * sx, (y - 10) * sy);
      canvas.drawPath(path, contour);
    }

    final route = Path()
      ..moveTo(p(200, 90).dx, p(200, 90).dy)
      ..quadraticBezierTo(p(130, 100).dx, p(130, 100).dy, p(60, 140).dx,
          p(60, 140).dy);
    final dash = Paint()
      ..color = AppColors.gold
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round;
    for (final metric in route.computeMetrics()) {
      double d = 0;
      while (d < metric.length) {
        canvas.drawPath(metric.extractPath(d, d + 5), dash);
        d += 10;
      }
    }

    void pin(String name, double x, double y, {bool labelLeft = false}) {
      final c = p(x, y);
      canvas.drawCircle(c, 10, Paint()..color = const Color(0x40F2B84B));
      canvas.drawCircle(c, 5.5, Paint()..color = AppColors.gold);
      canvas.drawCircle(
        c,
        5.5,
        Paint()
          ..color = AppColors.background
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
      final tp = TextPainter(
        text: TextSpan(
          text: name,
          style: const TextStyle(color: AppColors.cream, fontSize: 12),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      final dx = labelLeft ? c.dx - tp.width - 12 : c.dx + 12;
      tp.paint(canvas, Offset(dx, c.dy - tp.height / 2));
    }

    pin('Kurukshetra', 205, 40);
    pin('Mathura', 200, 90, labelLeft: true);
    pin('Vrindavan', 226, 106);
    pin('Gokul', 248, 132);
    pin('Dwarka', 60, 140);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
