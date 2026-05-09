import 'package:flutter/material.dart';

const double kBannerWidth = 520;
const double kBannerHeight = 160;

/// Simple global state so main.dart can trigger fade in/out
class BannerState {
  BannerState._();
  static final instance = BannerState._();
  final opacity = ValueNotifier<double>(0.0);
  void fadeTo(double value) => opacity.value = value;
}

class AnimatedBanner extends StatelessWidget {
  const AnimatedBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: kBannerWidth,
        height: kBannerHeight,
        child: ValueListenableBuilder<double>(
          valueListenable: BannerState.instance.opacity,
          builder: (context, opacity, child) {
            return AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(milliseconds: 400),
              child: child,
            );
          },
          child: const _BannerCard(),
        ),
      ),
    );
  }
}

class _BannerCard extends StatelessWidget {
  const _BannerCard();

  @override
  Widget build(BuildContext context) {
    // Footer is fixed at 28px, main area gets the rest
    const double footerH = 28;
    const double mainH = kBannerHeight - footerH;

    return SizedBox(
      width: kBannerWidth,
      height: kBannerHeight,
      child: ClipRect(
        child: ColoredBox(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: mainH,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const _Logo(),
                      const SizedBox(width: 24),
                      Container(
                        width: 1,
                        height: 80,
                        color: const Color(0xFFE0E0E0),
                      ),
                      const SizedBox(width: 24),
                      const Expanded(child: _InfoBlock()),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: footerH, child: _Footer()),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Logo ──────────────────────────────────────────────────────────────────────
class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 48,
          height: 48,
          child: CustomPaint(painter: _ChipPainter()),
        ),
        const SizedBox(height: 4),
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Micro',
                style: TextStyle(
                  color: Color(0xFF1565C0),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'Tech',
                style: TextStyle(
                  color: Color(0xFF29B6F6),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const Text(
          'Computers',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 8,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.6,
          ),
        ),
      ],
    );
  }
}

class _ChipPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const blue = Color(0xFF1565C0);
    const lightBlue = Color(0xFF29B6F6);

    final borderPaint = Paint()
      ..color = blue
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = const Color(0xFFE3F2FD)
      ..style = PaintingStyle.fill;

    final pinPaint = Paint()
      ..color = blue
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    final circuitPaint = Paint()
      ..color = lightBlue.withValues(alpha: 0.7)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final double pad = size.width * 0.20;
    final rect = Rect.fromLTWH(
      pad,
      pad,
      size.width - pad * 2,
      size.height - pad * 2,
    );
    final rRect = RRect.fromRectAndRadius(rect, const Radius.circular(4));

    canvas.drawRRect(rRect, fillPaint);
    canvas.drawRRect(rRect, borderPaint);

    for (final r in [0.33, 0.5, 0.67]) {
      final x = size.width * r;
      final y = size.height * r;
      canvas.drawLine(Offset(x, 0), Offset(x, pad), pinPaint);
      canvas.drawLine(
        Offset(x, size.height - pad),
        Offset(x, size.height),
        pinPaint,
      );
      canvas.drawLine(Offset(0, y), Offset(pad, y), pinPaint);
      canvas.drawLine(
        Offset(size.width - pad, y),
        Offset(size.width, y),
        pinPaint,
      );
    }

    final cx = size.width / 2;
    final cy = size.height / 2;
    canvas.drawCircle(Offset(cx, cy), size.width * 0.10, circuitPaint);
    canvas.drawLine(Offset(cx - 6, cy), Offset(cx + 6, cy), circuitPaint);
    canvas.drawLine(Offset(cx, cy - 6), Offset(cx, cy + 6), circuitPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Info block ────────────────────────────────────────────────────────────────
class _InfoBlock extends StatelessWidget {
  const _InfoBlock();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'MicroTech Computers',
          style: TextStyle(
            color: Color(0xFF1565C0),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'ENTERPRISE INFRASTRUCTURE V4.0',
          style: TextStyle(
            color: Color(0xFF1E88E5),
            fontSize: 9,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Icon(Icons.location_on, color: Color(0xFF1E88E5), size: 13),
            SizedBox(width: 3),
            Flexible(
              child: Text(
                'መገናኛ መተባበር\nህንፃ 2ኛ ፎቅ',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.black87,
                  height: 1.3,
                ),
              ),
            ),
            SizedBox(width: 12),
            Text('•', style: TextStyle(color: Colors.black38, fontSize: 11)),
            SizedBox(width: 8),
            Flexible(
              child: Text(
                'Megenagna Metebaber\nBuilding, 2nd Floor',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.black87,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: const [
            Icon(Icons.phone, color: Color(0xFF1E88E5), size: 13),
            SizedBox(width: 4),
            Text(
              '0921778272 / 0944032128',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Footer ────────────────────────────────────────────────────────────────────
class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF2F2F2),
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(width: 14, height: 14, color: const Color(0xFF757575)),
          const SizedBox(width: 7),
          const Text(
            'POWERED BY HONOR SYSTEMS',
            style: TextStyle(
              fontSize: 8,
              color: Color(0xFF757575),
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          const Text(
            'honourhq.app@gmail.com   |   0944032128',
            style: TextStyle(
              fontSize: 8,
              color: Color(0xFF9E9E9E),
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}
