import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/core/services/get_it_service.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';
import 'package:pickpay/features/bottom_navigation/bottom_navigation_cubits/bottom_navigation_cubit.dart';
import 'package:pickpay/features/bottom_navigation/custom_bottom_navigation_bar.dart';
import 'package:pickpay/features/home/presentation/views/widgets/main_navigation_body.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  static const String routeName = '/main-navigation';

  /// Tab indexes for better readability
  static const int homeTab = 0;
  static const int categoriesTab = 1;
  static const int cartTab = 2;
  static const int accountTab = 3;

  /// Helper method for consistent tab navigation
  static void navigateToTab(BuildContext context, int tabIndex) {
    // Check if we're already in the main navigation flow
    final isInMainFlow = ModalRoute.of(context)?.settings.name == routeName;

    if (isInMainFlow) {
      // Just change the tab if we're already in main flow
      context.read<BottomNavigationCubit>().changeTab(tabIndex);
    } else {
      // Push the main navigation screen with the desired tab
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MainNavigationScreen(),
          settings: const RouteSettings(name: routeName),
        ),
      );
      // Change to the desired tab after build completes
      Future.delayed(Duration.zero, () {
        context.read<BottomNavigationCubit>().changeTab(tabIndex);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authRepo = getIt<AuthRepo>();

    return BlocProvider(
      create: (_) => BottomNavigationCubit(),
      child: _MainNavigationView(authRepo: authRepo),
    );
  }
}

class _MainNavigationView extends StatelessWidget {
  final AuthRepo authRepo;

  const _MainNavigationView({
    required this.authRepo,
  });
  Future<bool> _showExitConfirmation(BuildContext context) async {
    final shouldExit = await showDialog<bool>(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 12,
        shadowColor: Colors.black.withOpacity(0.2),
        child: AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Animated icon with splash effect
                  ScaleTransition(
                    scale: CurvedAnimation(
                      parent: ModalRoute.of(context)!.animation!,
                      curve: Curves.elasticOut,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.red.shade100,
                            Colors.red.shade300,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 2,
                            offset: const Offset(0, 5),
                          )
                        ],
                      ),
                      child: Icon(
                        Icons.exit_to_app,
                        size: 42,
                        color: Colors.red.shade700,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Title with fade animation
                  FadeTransition(
                    opacity: CurvedAnimation(
                      parent: ModalRoute.of(context)!.animation!,
                      curve: const Interval(0.2, 1.0),
                    ),
                    child: Text(
                      'Hold On!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onSurface,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Subtitle
                  FadeTransition(
                    opacity: CurvedAnimation(
                      parent: ModalRoute.of(context)!.animation!,
                      curve: const Interval(0.3, 1.0),
                    ),
                    child: Text(
                      'Are you sure you want to exit?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.4,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.8),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),
                  const Divider(height: 1, thickness: 0.5),

                  const SizedBox(height: 20),

                  // Buttons with slide animation
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.5),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: ModalRoute.of(context)!.animation!,
                        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Cancel button
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          style: TextButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).colorScheme.primary,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.1),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Exit button
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade500,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                            shadowColor: Colors.red.withOpacity(0.3),
                          ),
                          child: const Text(
                            'Exit',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
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
      ),
    );
    return shouldExit ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        final shouldExit = await _showExitConfirmation(context);
        if (shouldExit) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        extendBody: true,
        body: SafeArea(
          child: MainNavigationScreenBody(authRepo: authRepo),
        ),
        bottomNavigationBar:
            BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
          builder: (context, state) {
            return CustomBottomNavigationBar(
              selectedIndex: state.currentIndex,
              onItemSelected: (index) =>
                  context.read<BottomNavigationCubit>().changeTab(index),
            );
          },
        ),
      ),
    );
  }
}
