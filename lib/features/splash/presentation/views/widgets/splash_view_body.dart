import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:pickpay/constants.dart';
import 'package:pickpay/core/services/firebase_auth_service.dart';
import 'package:pickpay/core/services/shared_preferences_singletone.dart';
import 'package:pickpay/core/utils/app_images.dart';
import 'package:pickpay/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:pickpay/features/auth/presentation/views/signin_view.dart';
import 'package:pickpay/features/home/presentation/views/main_navigation_screen.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  static const Duration _minSplashDuration = Duration(milliseconds: 5000);
  static const Duration _fadeOutDuration = Duration(milliseconds: 1000);
  static const Duration _animationDuration = Duration(milliseconds: 3000);

  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _rotationAnimation;
  late final Animation<double> _fadeTextAnimation;
  late final Animation<Offset> _slideTextAnimation;
  late final Animation<double> _glowAnimation;

  late final AudioPlayer _audioPlayer;

  bool _isSplashVisible = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.1), weight: 0.5),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 1.0), weight: 0.5),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _rotationAnimation =
        Tween<double>(begin: -0.05, end: 0.05).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _fadeTextAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeInCubic),
      ),
    );

    _slideTextAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.elasticOut),
      ),
    );

    _glowAnimation = Tween<double>(begin: 0.4, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutQuad,
      ),
    );

    _controller.forward();
    _audioPlayer = AudioPlayer()..setReleaseMode(ReleaseMode.stop);
    _playSplashSound();
    _navigateAfterSplash();
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playSplashSound() async {
    try {
      await _audioPlayer.play(AssetSource('sounds/pickpay_jingle.wav'));
      debugPrint('Playing splash sound...');
    } catch (e) {
      debugPrint('Error playing splash sound: $e');
    }
  }

  Future<void> _navigateAfterSplash() async {
    final stopwatch = Stopwatch()..start();

    final bool isOnBoardingSeen = Prefs.getBool(kIsOnBoardingViewSeen);
    final bool isLoggedIn = FirebaseAuthService().isLoggedIn();

    stopwatch.stop();
    final remaining = _minSplashDuration - stopwatch.elapsed;
    if (remaining > Duration.zero) {
      await Future.delayed(remaining);
    }

    if (!mounted) return;

    setState(() {
      _isSplashVisible = false;
    });

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          if (!isOnBoardingSeen) {
            return const OnBoardingView();
          } else if (isLoggedIn) {
            return const MainNavigationScreen();
          } else {
            return const SigninView();
          }
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
        opaque: false,
      ),
    );
  }

  void _skipSplash() {
    if (!_isSplashVisible) return;
    _navigateAfterSplash();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: _skipSplash,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    const Color(0xFF0F0F1E),
                    const Color(0xFF1A1A3E),
                    const Color(0xFF2D1B69),
                  ]
                : [
                    Colors.white,
                    const Color(0xFFFFF8FC),
                    const Color(0xFFF8F8FF),
                  ],
          ),
        ),
        child: AnimatedOpacity(
          duration: _fadeOutDuration,
          opacity: _isSplashVisible ? 1.0 : 0.0,
          child: SizedBox.expand(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _rotationAnimation.value,
                            child: Transform.scale(
                              scale: _scaleAnimation.value,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: (isDark
                                              ? Colors.deepPurple[300]!
                                              : Colors.pink[400]!)
                                          .withOpacity(
                                              0.7 * _glowAnimation.value),
                                      blurRadius: 120 * _glowAnimation.value,
                                      spreadRadius: 50 * _glowAnimation.value,
                                    ),
                                    BoxShadow(
                                      color: (isDark
                                              ? Colors.blue[400]!
                                              : Colors.purple[300]!)
                                          .withOpacity(
                                              0.5 * _glowAnimation.value),
                                      blurRadius: 100 * _glowAnimation.value,
                                      spreadRadius: 40 * _glowAnimation.value,
                                    ),
                                    BoxShadow(
                                      color: (isDark
                                              ? Colors.purple[200]!
                                              : Colors.pink[200]!)
                                          .withOpacity(
                                              0.3 * _glowAnimation.value),
                                      blurRadius: 80 * _glowAnimation.value,
                                      spreadRadius: 30 * _glowAnimation.value,
                                    ),
                                  ],
                                ),
                                child: child,
                              ),
                            ),
                          );
                        },
                        child: Image.asset(
                          Assets.appLogo,
                          width: size.width * 0.4,
                          height: size.width * 0.4,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      SizedBox(height: size.height * 0.05),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 300,
                        ),
                        child: SlideTransition(
                          position: _slideTextAnimation,
                          child: FadeTransition(
                            opacity: _fadeTextAnimation,
                            child: Text(
                              'PickPay',
                              style: GoogleFonts.poppins(
                                fontSize: size.width * 0.15,
                                fontWeight: FontWeight.w800,
                                height: 0.9,
                                letterSpacing: -1.5,
                                foreground: Paint()
                                  ..shader = LinearGradient(
                                    colors: [
                                      Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? const Color(
                                              0xFFFF6B8B) // Vibrant pink for dark mode
                                          : const Color(
                                              0xFFFE117A), // Original pink for light mode
                                      Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? const Color(
                                              0xFF9D4EDD) // Rich purple for dark mode
                                          : const Color(
                                              0xFF9370DB), // Medium purple for light mode
                                      Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? const Color(
                                              0xFF5E60CE) // Electric blue for dark mode
                                          : const Color(
                                              0xFF483BAF), // Deep blue for light mode
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    stops: const [0.0, 0.5, 1.0],
                                    tileMode: TileMode.clamp,
                                  ).createShader(
                                    Rect.fromLTWH(
                                        0, 0, size.width * 0.15 * 4, 100),
                                  ),
                                shadows: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? [
                                        Shadow(
                                          color: Colors.black.withOpacity(0.4),
                                          blurRadius: 12,
                                          offset: const Offset(0, 3),
                                        ),
                                        Shadow(
                                          color: const Color(0xFF9D4EDD)
                                              .withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ]
                                    : [
                                        Shadow(
                                          color: const Color(0xFFFE117A)
                                              .withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
