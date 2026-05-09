import 'package:flutter/material.dart';

class AnimatedBanner extends StatefulWidget {
  const AnimatedBanner({super.key});

  @override
  State<AnimatedBanner> createState() => _AnimatedBannerState();
}

class _AnimatedBannerState extends State<AnimatedBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Reveal
    _controller.forward();

    // Hold for 3s then slide back down
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (mounted) _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.18),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Main content ──────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo block
                  _Logo(),
                  const SizedBox(width: 20),
                  // Divider
                  Container(width: 1, height: 80, color: Colors.grey.shade200),
                  const SizedBox(width: 20),
                  // Info block
                  Expanded(child: _InfoBlock()),
                ],
              ),
            ),

            // ── Footer ────────────────────────────────────────────
            _Footer(),
          ],
        ),
      ),
    );
  }
}

// ── Logo ──────────────────────────────────────────────────────────────────────
class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Chip icon composed from Flutter widgets
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF1565C0), width: 2.5),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Inner chip body
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E88E5).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              // Chip pins – top & bottom
              ..._chipPins(),
              // "Micro" text inside chip
              const Positioned(
                child: Text(
                  'Micro',
                  style: TextStyle(
                    color: Color(0xFF1565C0),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Micro',
                style: TextStyle(
                  color: Color(0xFF1565C0),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'Tech\n',
                style: TextStyle(
                  color: Color(0xFF29B6F6),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'Computers',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  static List<Widget> _chipPins() {
    // Simple decorative pin lines on top and bottom
    return [
      Positioned(
        top: 4,
        left: 14,
        right: 14,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            3,
            (_) =>
                Container(width: 6, height: 3, color: const Color(0xFF1565C0)),
          ),
        ),
      ),
      Positioned(
        bottom: 4,
        left: 14,
        right: 14,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            3,
            (_) =>
                Container(width: 6, height: 3, color: const Color(0xFF1565C0)),
          ),
        ),
      ),
    ];
  }
}

// ── Info block ────────────────────────────────────────────────────────────────
class _InfoBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Company name
        const Text(
          'MicroTech Computers',
          style: TextStyle(
            color: Color(0xFF1565C0),
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 3),
        // Subtitle
        const Text(
          'ENTERPRISE INFRASTRUCTURE V4.0',
          style: TextStyle(
            color: Color(0xFF1E88E5),
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        // Address row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.location_on, color: Color(0xFF1E88E5), size: 15),
            const SizedBox(width: 4),
            const Expanded(
              child: Text(
                'መገናኛ መተባበር\nህንፃ 2ኛ ፎቅ',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              '•  ',
              style: TextStyle(color: Colors.black54, fontSize: 11),
            ),
            const Expanded(
              child: Text(
                'Megenagna Metebaber\nBuilding, 2nd Floor',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        // Phone row
        Row(
          children: const [
            Icon(Icons.phone, color: Color(0xFF1E88E5), size: 14),
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
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      child: Row(
        children: [
          // Honor Systems logo placeholder
          Container(width: 16, height: 16, color: Colors.grey.shade500),
          const SizedBox(width: 6),
          const Text(
            'POWERED BY HONOR SYSTEMS',
            style: TextStyle(
              fontSize: 9,
              color: Colors.black54,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          const Text(
            'honourhq.app@gmail.com   |   0944032128',
            style: TextStyle(
              fontSize: 9,
              color: Colors.black45,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
