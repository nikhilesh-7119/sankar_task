import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sankar_task/constants/app_constants.dart';
import 'package:sankar_task/screens/auth_gateway/auth_gateway.dart';
import 'package:sankar_task/theme/app_Colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Responsive scale based on screen width (reference 390)
    final Size screen = MediaQuery.of(context).size; // width/height [7]
    final double s = (screen.width / 390).clamp(
      0.85,
      1.25,
    ); // guard extremes [1]

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          // subtle decorative circles (scaled)
          _SoftCircle(top: 48 * s, left: 24 * s, size: 28 * s),
          _SoftCircle(top: 140 * s, left: 160 * s, size: 18 * s),
          _SoftCircle(top: 70 * s, right: 160 * s, size: 32 * s),
          _SoftCircle(top: 250 * s, right: 40 * s, size: 32 * s),
          _SoftCircle(bottom: 32 * s, right: 32 * s, size: 22 * s),
          _SoftCircle(bottom: 70 * s, left: 48 * s, size: 22 * s),

          // main content
          SafeArea(
            // respects notches and system UI [2]
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 360),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24 * s),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 24 * s),

                      // heart icon
                      Icon(
                        Icons.favorite,
                        color: AppColors.heartPink,
                        size: 48 * s,
                      ),
                      SizedBox(height: 20 * s),

                      // title and subtitle
                      Text(
                        AppConstants.splashTitle,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: AppColors.textDark,
                          fontSize: 32 * s,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1 * s,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4 * s),
                      Text(
                        AppConstants.splashPlanner,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: AppColors.subtitleGrey,
                          letterSpacing: 2.2 * s,
                          fontSize: 20 * s,
                        ),
                      ),
                      SizedBox(height: 20 * s),
                      Text(
                        AppConstants.splashTagline,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.subtitleGrey,
                          height: 1.4,
                          fontSize: 16 * s,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 60 * s),

                      // Get Started button (soft neumorphic)
                      _NeumorphicButton(
                        label: AppConstants.getStartedLabel,
                        onTap: () {
                          Get.offAll(const AuthGateway());
                        },
                      ),

                      SizedBox(height: 32 * s),

                      // footer
                      Opacity(
                        opacity: 0.9,
                        child: Text(
                          AppConstants.splashFooter,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.footerGrey,
                            fontSize: 15 * s,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 24 * s),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SoftCircle extends StatelessWidget {
  final double size;
  final double? top, left, right, bottom;
  const _SoftCircle({
    this.size = 24,
    this.top,
    this.left,
    this.right,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppColors.softCirclePinkOp25,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.black12Op05),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackOp03,
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
      ),
    );
  }
}

class _NeumorphicButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _NeumorphicButton({required this.label, required this.onTap});

  @override
  State<_NeumorphicButton> createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<_NeumorphicButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final double s = (MediaQuery.of(context).size.width / 390).clamp(
      0.85,
      1.25,
    ); // [7]
    return Listener(
      onPointerDown: (_) => setState(() => _pressed = true),
      onPointerUp: (_) => setState(() => _pressed = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: EdgeInsets.symmetric(horizontal: 24 * s, vertical: 16 * s),
          decoration: BoxDecoration(
            color: AppColors.cardCream,
            borderRadius: BorderRadius.circular(14 * s),
            boxShadow: _pressed
                ? [
                    BoxShadow(
                      color: AppColors.buttonShadowPink,
                      blurRadius: 4 * s,
                      offset: Offset(0, 2 * s),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: AppColors.buttonShadowPink,
                      blurRadius: 16 * s,
                      spreadRadius: 1 * s,
                      offset: Offset(0, 6 * s),
                    ),
                    BoxShadow(
                      color: AppColors.white,
                      blurRadius: 12 * s,
                      offset: Offset(-2 * s, -2 * s),
                    ),
                  ],
          ),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.textDark,
              fontSize: 20 * s,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
