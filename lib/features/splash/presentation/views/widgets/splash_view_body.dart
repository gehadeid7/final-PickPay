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
  static const Duration _minSplashDuration = Duration(milliseconds: 2000);

  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _rotationAnimation;
  late final Animation<double> _fadeTextAnimation;
  late final Animation<Offset> _slideTextAnimation;

  late final AudioPlayer _audioPlayer;

  bool _isSplashVisible = true;

  @override
  void initState() {
    super.initState();

    // Animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    // Scale pulse
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.1), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Rotation small angle
    _rotationAnimation = Tween<double>(begin: -0.03, end: 0.03)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Text fade in + slide up
    _fadeTextAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );

    _slideTextAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller.repeat(reverse: true);

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
    if (remaining > Duration.zero) await Future.delayed(remaining);

    if (!mounted) return;

    setState(() {
      _isSplashVisible = false;
    });

    await Future.delayed(const Duration(milliseconds: 600));

    if (!mounted) return;

    if (!isOnBoardingSeen) {
      Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
    } else if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, MainNavigationScreen.routeName);
    } else {
      Navigator.pushReplacementNamed(context, SigninView.routeName);
    }
  }

  void _skipSplash() {
    if (!_isSplashVisible) return;
    _navigateAfterSplash();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: _skipSplash,
      child: Scaffold(
        backgroundColor: isDark ? Colors.black : Colors.white,
        body: AnimatedOpacity(
          duration: const Duration(milliseconds: 600),
          opacity: _isSplashVisible ? 1.0 : 0.0,
          child: SizedBox.expand(
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Moving gradient background
                AnimatedGradientBackground(isDark: isDark),

                // Main content
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
                              child: child,
                            ),
                          );
                        },
                        child: Image.asset(
                          Assets.appLogo,
                          width: 180,
                          height: 180,
                        ),
                      ),
                      const SizedBox(height: 32),
                      SlideTransition(
                        position: _slideTextAnimation,
                        child: FadeTransition(
                          opacity: _fadeTextAnimation,
                          child: Text(
                            'PickPay',
                            style: GoogleFonts.poppins(
                              fontSize: 52,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()
                                ..shader = const LinearGradient(
                                  colors: [
                                    Color(0xFFFE1679),
                                    Color(0xFF5440B3),
                                  ],
                                ).createShader(
                                  const Rect.fromLTWH(0, 0, 200, 70),
                                ),
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

class AnimatedGradientBackground extends StatefulWidget {
  final bool isDark;
  const AnimatedGradientBackground({required this.isDark, super.key});

  @override
  State<AnimatedGradientBackground> createState() =>
      _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<Color?> _colorAnim1;
  late Animation<Color?> _colorAnim2;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _setupAnimations();
  }

  void _setupAnimations() {
    _colorAnim1 = ColorTween(
      begin: widget.isDark ? Colors.deepPurple[900] : Colors.pink[100],
      end: widget.isDark ? Colors.deepPurple[700] : Colors.purple[100],
    ).animate(_controller);

    _colorAnim2 = ColorTween(
      begin: widget.isDark ? Colors.black : Colors.white,
      end: widget.isDark ? Colors.deepPurple[900] : Colors.pink[50],
    ).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant AnimatedGradientBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isDark != widget.isDark) {
      _setupAnimations();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _colorAnim1.value ?? Colors.purple,
                _colorAnim2.value ?? Colors.pink,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        );
      },
    );
  }
}
