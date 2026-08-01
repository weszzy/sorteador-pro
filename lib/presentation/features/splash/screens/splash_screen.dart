import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../sorteio/screens/sorteio_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061B02),
      body: Center(
        child:
            Image.asset('assets/icon/splash_icon.png', width: 150, height: 150)
                .animate()
                .fadeIn(duration: 800.ms, curve: Curves.easeOut)
                .scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1.0, 1.0),
                  duration: 800.ms,
                  curve: Curves.easeOutBack,
                )
                .then(delay: 500.ms)
                .callback(
                  callback: (_) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const SorteioScreen()),
                    );
                  },
                ),
      ),
    );
  }
}
